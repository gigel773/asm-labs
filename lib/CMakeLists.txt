project(voo C)

if (UNIX AND NOT APPLE)
    set(CMAKE_ASM_NASM_OBJECT_FORMAT elf64)
else ()
    set(CMAKE_ASM_NASM_OBJECT_FORMAT macho64)
endif ()

enable_language(ASM_NASM)

add_library(voo src/vector_ops.asm
        src/cum_sum.asm
        src/simple_sum.asm)

target_include_directories(voo
        PUBLIC include
        PRIVATE src)
