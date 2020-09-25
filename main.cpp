#include <iostream>
#include <array>
#include <numeric>
#include <algorithm>

#include <vector_ops.h>

int main()
{
    std::array<int, 200>          src_1{};
    std::array<int, src_1.size()> src_2{};
    std::array<int, src_1.size()> dest{};

    std::iota(std::begin(src_1), std::end(src_1), 0);
    std::iota(std::begin(src_2), std::end(src_2), 0);
    std::fill(std::begin(dest), std::end(dest), 0);

    sum_vectors(src_1.data(), src_2.data(), dest.data(), src_1.size());

    std::for_each(dest.begin(), dest.end(),
                  [](int it)
                  {
                      std::cout << it << "\n";
                  });

    return 0;
}
