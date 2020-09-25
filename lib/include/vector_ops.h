#ifndef ASM_LAB_VECTOR_OPS_H
#define ASM_LAB_VECTOR_OPS_H

#include "vector_defs.h"

#ifdef __cplusplus
extern "C" {
#endif

int32_t sum(int a, int b);

int32_t cum_sum(const int *vector_ptr, size_t size);

int32_t sum_vectors(const int *vector_ptr_1, const int *vector_ptr_2, int *vector_dst_ptr, size_t size);

#ifdef __cplusplus
}
#endif

#endif //ASM_LAB_VECTOR_OPS_H
