#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>

#include <count.h>
#include <chrono>

constexpr char     test_file_path[] = R"(../data/bib)";
constexpr uint32_t file_size        = 111261;
constexpr auto     symbol           = 'o';
constexpr auto     outer_cycle      = 100;
constexpr auto     inner_cycle      = 100;

int main()
{
    // Open test file
    std::ifstream        file(test_file_path, std::ifstream::binary);
    std::vector<uint8_t> source;
    int32_t              result = 0;

    if (!file.is_open())
    {
        std::cout << "Could not open the file\n";

        return 1;
    }
    source.reserve(file_size);
    source.assign(std::istreambuf_iterator<char>(file), std::istreambuf_iterator<char>());

    // Performance measurement for ASM implementation
    std::chrono::duration<double, std::milli> asm_time = std::chrono::duration<double>::max();

    for (int i = 0; i < outer_cycle; i++)
    {
        auto start = std::chrono::high_resolution_clock::now();

        for (int j = 0; j < inner_cycle; j++)
        {
            count(reinterpret_cast<const uint8_t *>(source.data()),
                  source.size(),
                  symbol,
                  &result);
        }

        auto end = std::chrono::high_resolution_clock::now();

        std::chrono::duration<double, std::milli> time = end - start;
        if (time < asm_time)
        {
            asm_time = time;
        }
    }

    std::cout << "Asm implementation runs with: " << asm_time.count() / inner_cycle << " ms" << std::endl;

    // Performance measurement for STL implementation
    std::chrono::duration<double, std::milli> cxx_time = std::chrono::duration<double>::max();

    for (int i = 0; i < outer_cycle; i++)
    {
        auto start = std::chrono::high_resolution_clock::now();

        for (int j = 0; j < inner_cycle; j++)
        {
            result = std::count(source.begin(), source.end(), symbol);
        }

        auto end = std::chrono::high_resolution_clock::now();

        std::chrono::duration<double, std::milli> time = end - start;
        if (time < cxx_time)
        {
            cxx_time = time;
        }
    }

    std::cout << "C++ implementation runs with: " << cxx_time.count() / inner_cycle << " ms" << std::endl;

    return 0;
}