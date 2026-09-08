#ifndef CYBER_ROLLER_BUILTIN_LEVELS_H
#define CYBER_ROLLER_BUILTIN_LEVELS_H
#include <stdint.h>
typedef struct {
    const char *name;
    uint8_t width;
    uint8_t height;
    const uint8_t *cells;
    uint16_t solution_len;
    const uint8_t *solution;
} BuiltinLevel;
extern const BuiltinLevel builtin_levels[49];
extern const uint8_t builtin_level_count;
#endif
