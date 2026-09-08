#!/usr/bin/env python3
from collections import deque

DR=(-1,0,1,0); DC=(0,1,0,-1)

def parse_code(code):
    p=[int(x) for x in code.split()]
    h=p[-1]; w=p[-2]; cells=p[:-2]

    cells=cells[:w*h]
    if len(cells)!=w*h: raise ValueError('cell count mismatch')
    return w,h,cells

def build_model(code):
    w,h,cells=parse_code(code)
    m={'w':w,'h':h,'cells':cells,'start':None,'goal':None,'walls':set(),'coins':[],
       'coin_index':{},'coin_blocks':{},'voids':set(),'blue':[],'pink':[],
       'ramps':{},'teleports':{},'tele_dest':{}}
    for i,t in enumerate(cells):
        if t==2:m['walls'].add(i)
        elif t==3:m['goal']=i
        elif t==4:m['coin_index'][i]=len(m['coins']);m['coins'].append(i)
        elif 5<=t<=9:m['coin_blocks'][i]=t-4
        elif t in (10,11,20,21):m['teleports'].setdefault(t,[]).append(i)
        elif t==12:m['voids'].add(i)
        elif t==13:m['blue'].append(i)
        elif t==14:m['pink'].append(i)
        elif 16<=t<=19:m['ramps'][i]=t
        elif t==15:m['start']=i
    if m['start'] is None or m['goal'] is None: raise ValueError('missing start/goal')
    for typ,lst in m['teleports'].items():
        for src in lst:
            sr,sc=divmod(src,w)
            best=None; bd=10**9
            for cand in lst:
                if cand==src: continue
                cr,cc=divmod(cand,w); d=(cr-sr)**2+(cc-sc)**2
                if d<bd: bd=d; best=cand
            if best is not None:m['tele_dest'][src]=best
    return m

def ramp_turn(t,d):
    if t==16:
        return {1:0,2:3}.get(d)
    if t==17:
        return {2:1,3:0}.get(d)
    if t==18:
        return {0:3,1:2}.get(d)
    if t==19:
        return {0:1,3:2}.get(d)

def inside(m,r,c):return 0<=r<m['h'] and 0<=c<m['w']
def collect(state,cell,m):
    r,c,d,mask,count,blue,pink=state
    ci=m['coin_index'].get(cell)
    if ci is not None:
        b=1<<ci
        if not(mask&b):mask|=b;count+=1
    return (r,c,d,mask,count,blue,pink)
def iswall(state,cell,m):
    return cell in m['walls'] or (cell in m['coin_blocks'] and state[4]<m['coin_blocks'][cell])
def canpush(state,cell,d,m):
    r,c=divmod(cell,m['w']); nr=r+DR[d]; nc=c+DC[d]
    if not inside(m,nr,nc):return False
    target=nr*m['w']+nc
    if target in state[5] or target in state[6]:return False
    if target in m['walls'] or target in m['voids'] or target in m['ramps'] or target==m['goal']:return False
    if target in m['coin_blocks'] and state[4]<m['coin_blocks'][target]:return False
    return True

def moveblock(arr,old,new):
    a=list(arr); a[a.index(old)]=new; a.sort(); return tuple(a)

def automatic(state,m):
    seen=set()
    for _ in range(100000):
        if state in seen:return ('loop',state)
        seen.add(state)
        r,c,d,mask,count,blue,pink=state
        cur=r*m['w']+c
        state=collect(state,cur,m); r,c,d,mask,count,blue,pink=state
        if cur in m['tele_dest']:
            dest=m['tele_dest'][cur]; r,c=divmod(dest,m['w'])
            state=(r,c,d,mask,count,blue,pink); state=collect(state,dest,m); r,c,d,mask,count,blue,pink=state
        nr=r+DR[d]; nc=c+DC[d]; nxt=nr*m['w']+nc if inside(m,nr,nc) else -1
        if nxt!=-1 and nxt in m['ramps']:
            nd=ramp_turn(m['ramps'][nxt],d)
            if nd is None:return ('stable',state)
            r=nr+DR[nd]; c=nc+DC[nd]; d=nd
            state=(r,c,d,mask,count,blue,pink)
            if not inside(m,r,c):return ('dead',state)
            dest=r*m['w']+c
            if dest==m['goal']:return ('won',state)
            if dest in m['voids']:return ('dead',state)
            if iswall(state,dest,m):return ('stable',state)
            continue
        if nxt!=-1 and (nxt in blue or nxt in pink):
            isp=nxt in pink; arr=pink if isp else blue
            if not canpush(state,nxt,d,m):return ('stable',state)
            bp=nxt
            while True:
                if not canpush(state,bp,d,m):break
                br,bc=divmod(bp,m['w']); dest=(br+DR[d])*m['w']+(bc+DC[d])
                arr=moveblock(arr,bp,dest)
                if isp:pink=arr
                else:blue=arr
                r,c=br,bc; state=(r,c,d,mask,count,blue,pink); state=collect(state,r*m['w']+c,m)
                r,c,d,mask,count,blue,pink=state
                if not isp:break
                bp=dest
                if not canpush(state,bp,d,m):break
            return ('stable',state)
        if nxt!=-1 and iswall(state,nxt,m):return ('stable',state)
        r,c=nr,nc; state=(r,c,d,mask,count,blue,pink)
        if not inside(m,r,c):return ('dead',state)
        dest=r*m['w']+c
        if dest==m['goal']:return ('won',state)
        if dest in m['voids']:return ('dead',state)
    return ('loop',state)

def apply(state,d,m):
    r,c,_,mask,count,blue,pink=state; state=(r,c,d,mask,count,blue,pink)
    nr=r+DR[d]; nc=c+DC[d]
    if not inside(m,nr,nc):return None
    nxt=nr*m['w']+nc
    if nxt in m['ramps']:
        nd=ramp_turn(m['ramps'][nxt],d)
        if nd is None:return None
        r=nr+DR[nd]; c=nc+DC[nd]; d=nd; state=(r,c,d,mask,count,blue,pink)
        if not inside(m,r,c):return ('dead',state)
        dest=r*m['w']+c
        if dest==m['goal']:return ('won',state)
        if dest in m['voids']:return ('dead',state)
        if iswall(state,dest,m):return ('stable',state)
        return automatic(state,m)
    if nxt in blue or nxt in pink:
        isp=nxt in pink; arr=pink if isp else blue
        if not canpush(state,nxt,d,m):return None
        br,bc=divmod(nxt,m['w']); dest=(br+DR[d])*m['w']+(bc+DC[d])
        arr=moveblock(arr,nxt,dest)
        if isp:pink=arr
        else:blue=arr
        r,c=br,bc; state=(r,c,d,mask,count,blue,pink); state=collect(state,r*m['w']+c,m)
        r,c,d,mask,count,blue,pink=state
        if isp:
            bp=dest
            while canpush(state,bp,d,m):
                cr,cc=divmod(bp,m['w']); bd=(cr+DR[d])*m['w']+(cc+DC[d])
                pink=moveblock(pink,bp,bd); r,c=cr,cc; state=(r,c,d,mask,count,blue,pink); state=collect(state,r*m['w']+c,m)
                r,c,d,mask,count,blue,pink=state; bp=bd
        return ('stable',state)
    if iswall(state,nxt,m):return None
    state=(nr,nc,d,mask,count,blue,pink)
    if nxt==m['goal']:return ('won',state)
    if nxt in m['voids']:return ('dead',state)
    return automatic(state,m)

def solve(code,max_states=800000):
    m=build_model(code); sr,sc=divmod(m['start'],m['w'])
    init=(sr,sc,1,0,0,tuple(sorted(m['blue'])),tuple(sorted(m['pink'])))
    q=deque([(init,b'')]); seen={init}
    while q:
        st,path=q.popleft()
        for d in range(4):
            res=apply(st,d,m)
            if not res: continue
            typ,ns=res
            if typ=='won':return path+bytes([d])
            if typ!='stable':continue
            if ns not in seen:
                seen.add(ns)
                if len(seen)>max_states:return None
                q.append((ns,path+bytes([d])))
    return None

if __name__=='__main__':
    import sys,json
    code=sys.stdin.read().strip()
    s=solve(code)
    if s is None: print('NO SOLUTION')
    else: print(' '.join('URDL'[d] for d in s), len(s))
