#ifndef CYBER_ROLLER_ENGINE_H
#define CYBER_ROLLER_ENGINE_H
#include <stdint.h>
#define CR_MAX_CELLS 400
#define CR_MAX_SOLUTION 1024

extern uint8_t level_w, level_h;
extern uint8_t base_grid[CR_MAX_CELLS], grid[CR_MAX_CELLS];
extern uint8_t base_blocks[CR_MAX_CELLS], blocks[CR_MAX_CELLS];
extern uint8_t tele_r[CR_MAX_CELLS], tele_c[CR_MAX_CELLS];
extern uint8_t player_r, player_c, start_r, start_c, coin_count;
uint8_t engine_move(uint8_t direction);
void engine_tick(void);
void engine_reset(void);
#endif
