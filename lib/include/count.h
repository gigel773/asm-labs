#ifndef ASM_LAB_COUNT_H
#define ASM_LAB_COUNT_H

#include "vector_defs.h"

#ifdef __cplusplus
extern "C" {
#endif

int32_t count(const uint8_t *src_ptr, size_t src_size, uint8_t symbol, int32_t *result_ptr);

#ifdef __cplusplus
}
#endif

#endif //ASM_LAB_COUNT_H
