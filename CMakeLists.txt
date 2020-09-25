cmake_minimum_required(VERSION 3.16)
project(asm_lab CXX)

add_subdirectory(lib)

add_executable(asm_lab main.cpp)
target_link_libraries(asm_lab PUBLIC voo)
