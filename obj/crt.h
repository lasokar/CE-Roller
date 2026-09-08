/* generated from: obj/CROLLER.o */
#define HAS_INIT_ARRAY 0
#define HAS_FINI_ARRAY 0
#define HAS_CLOCK 1
#define HAS_ABORT 0
#define HAS_EXIT 0
#define HAS_C99__EXIT 0
#define HAS_RUN_PRGM 0
#define HAS_MAIN_ARGC_ARGV 0
#define HAS_ATEXIT 0
#ifdef __ASSEMBLER__
.macro LIBLOAD_LIBS
	.global __libload_library_FILEIOC
	.type __libload_library_FILEIOC, @object
__libload_library_FILEIOC:
	.db 0xC0, "FILEIOC", 0, 8
	.global _ti_Open
	.type _ti_Open, @function
_ti_Open:
	jp 3
	.global _ti_Close
	.type _ti_Close, @function
_ti_Close:
	jp 9
	.global _ti_Write
	.type _ti_Write, @function
_ti_Write:
	jp 12
	.global _ti_Read
	.type _ti_Read, @function
_ti_Read:
	jp 15
	.global __libload_library_GRAPHX
	.type __libload_library_GRAPHX, @object
__libload_library_GRAPHX:
	.db 0xC0, "GRAPHX", 0, 14
	.global _gfx_Begin
	.type _gfx_Begin, @function
_gfx_Begin:
	jp 0
	.global _gfx_End
	.type _gfx_End, @function
_gfx_End:
	jp 3
	.global _gfx_SetColor
	.type _gfx_SetColor, @function
_gfx_SetColor:
	jp 6
	.global _gfx_SetPalette
	.type _gfx_SetPalette, @function
_gfx_SetPalette:
	jp 12
	.global _gfx_FillScreen
	.type _gfx_FillScreen, @function
_gfx_FillScreen:
	jp 15
	.global _gfx_SetPixel
	.type _gfx_SetPixel, @function
_gfx_SetPixel:
	jp 18
	.global _gfx_SetDraw
	.type _gfx_SetDraw, @function
_gfx_SetDraw:
	jp 27
	.global _gfx_SwapDraw
	.type _gfx_SwapDraw, @function
_gfx_SwapDraw:
	jp 30
	.global _gfx_BlitRectangle
	.type _gfx_BlitRectangle, @function
_gfx_BlitRectangle:
	jp 39
	.global _gfx_PrintUInt
	.type _gfx_PrintUInt, @function
_gfx_PrintUInt:
	jp 48
	.global _gfx_PrintStringXY
	.type _gfx_PrintStringXY, @function
_gfx_PrintStringXY:
	jp 54
	.global _gfx_SetTextBGColor
	.type _gfx_SetTextBGColor, @function
_gfx_SetTextBGColor:
	jp 60
	.global _gfx_SetTextFGColor
	.type _gfx_SetTextFGColor, @function
_gfx_SetTextFGColor:
	jp 63
	.global _gfx_SetTextTransparentColor
	.type _gfx_SetTextTransparentColor, @function
_gfx_SetTextTransparentColor:
	jp 66
	.global _gfx_GetStringWidth
	.type _gfx_GetStringWidth, @function
_gfx_GetStringWidth:
	jp 78
	.global _gfx_Line
	.type _gfx_Line, @function
_gfx_Line:
	jp 90
	.global _gfx_HorizLine
	.type _gfx_HorizLine, @function
_gfx_HorizLine:
	jp 93
	.global _gfx_FillCircle
	.type _gfx_FillCircle, @function
_gfx_FillCircle:
	jp 102
	.global _gfx_Rectangle
	.type _gfx_Rectangle, @function
_gfx_Rectangle:
	jp 105
	.global _gfx_FillRectangle
	.type _gfx_FillRectangle, @function
_gfx_FillRectangle:
	jp 108
	.global _gfx_TransparentSprite
	.type _gfx_TransparentSprite, @function
_gfx_TransparentSprite:
	jp 174
	.global _gfx_FillTriangle
	.type _gfx_FillTriangle, @function
_gfx_FillTriangle:
	jp 213
	.global _gfx_SetTextScale
	.type _gfx_SetTextScale, @function
_gfx_SetTextScale:
	jp 222
	.global _gfx_SetTransparentColor
	.type _gfx_SetTransparentColor, @function
_gfx_SetTransparentColor:
	jp 225
	.global __libload_library_KEYPADC
	.type __libload_library_KEYPADC, @object
__libload_library_KEYPADC:
	.db 0xC0, "KEYPADC", 0, 2
	.global _kb_Scan
	.type _kb_Scan, @function
_kb_Scan:
	jp 0
	.global _kb_AnyKey
	.type _kb_AnyKey, @function
_kb_AnyKey:
	jp 6
	.global _kb_Reset
	.type _kb_Reset, @function
_kb_Reset:
	jp 9
.endm
#endif
#define HAS_LIBLOAD 1
