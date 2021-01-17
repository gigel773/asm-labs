#include <iostream>
#include <fstream>
#include <vector>

#include <count.h>

constexpr char     test_file_path[] = R"(../data/bib)";
constexpr uint32_t file_size        = 111261;
constexpr auto     symbol           = 'o';

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

    // Calculate number of occurrences
    auto status = count(reinterpret_cast<const uint8_t *>(source.data()),
                        source.size(),
                        symbol,
                        &result);

    if (status != VOO_OK)
    {
        std::cout << "Operation finished unsuccessfully\n";

        return 1;
    }

    std::cout << "Symbol " << symbol << " occurs " << result << " times within the text\n";

    return 0;
}