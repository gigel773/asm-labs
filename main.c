#include <stdio.h>

extern int sum(int a, int b);

extern int sum_vector(const int *vector_ptr, size_t size);

extern size_t sum_vectors(const int *vector_ptr_1,
                          const int *vector_ptr_2,
                          int *vector_dst_ptr,
                          size_t size);

int main()
{
    int src_1[200];
    int src_2[200];
    int dest[200];

    for (int i = 0; i < 197; i++)
    {
        src_1[i] = i + 1;
        src_2[i] = i + 1;
        dest[i]  = 0;
    }

    sum_vectors(src_1, src_2, dest, 197);

    for (int i = 0; i < 197; i++)
    {
        printf("%d\n", dest[i]);
    }

    return 0;
}
