cmake_minimum_required(VERSION 3.12)
project(asm_lab CXX)

add_subdirectory(lib)

if (UNIX AND NOT APPLE)
    set(CMAKE_ASM_NASM_OBJECT_FORMAT elf64)
else ()
    set(CMAKE_ASM_NASM_OBJECT_FORMAT macho64)
endif ()
enable_language(ASM_NASM)

add_executable(asm_lab_1 asm_lab_1.cpp)
add_executable(asm_lab_2 asm_lab_2.cpp)

target_link_libraries(asm_lab_1 PUBLIC voo)
target_link_libraries(asm_lab_2 PUBLIC voo)
