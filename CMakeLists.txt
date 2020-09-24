cmake_minimum_required(VERSION 3.16)
project(asm_lab C)

set(CMAKE_C_STANDARD 11)

set(CMAKE_ASM_NASM_OBJECT_FORMAT macho64)
enable_language(ASM_NASM)

add_executable(asm_lab main.c lib.asm)