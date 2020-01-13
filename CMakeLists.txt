###
## Author:  Ricardo Vicente
##
## CMake arm-none-eabi toolchain for ARM Cortex M4 using Nordic nRF5 SDK
##
cmake_minimum_required(VERSION 3.14)

if (NOT DEFINED CMAKE_TOOLCHAIN_FILE)
    message("Setting default project toolchain 'cmake/toolchain.cmake'")
    set(CMAKE_TOOLCHAIN_FILE cmake/toolchain.cmake)
endif()

if (NOT DEFINED SDK_DIR)
    message(FATAL_ERROR "SDK directory not defined. Please set SDK_DIR with SDK directory.")
endif ()

include(cmake/binaries.cmake)

project(TagWifi
        VERSION 0.0.1
        LANGUAGES C ASM
)

option(VERBOSE_MAKEFILE "Makefile verbose [ON/OFF]" OFF)

include(cmake/tools.cmake)

message("==================== BUILD TYPE ====================")
message("                       ${CMAKE_BUILD_TYPE}          ")
message("====================================================")
message("")

#----------------------------------------------------------------------------------------------------------------------
# Basic configs
#----------------------------------------------------------------------------------------------------------------------
if (${VERBOSE_MAKEFILE})
    set(CMAKE_VERBOSE_MAKEFILE ON)
endif ()

find_program(NRFJPROG nrfjprog)

if (${NRFJPROG} STREQUAL "NRFJPROG-NOTFOUND")
    message(WARNING "nrfjprog not found! You might not be able to flash the board!")
endif()

#----------------------------------------------------------------------------------------------------------------------
# Preprocessor defines
#----------------------------------------------------------------------------------------------------------------------
add_compile_definitions(BOARD_PCA10040)
add_compile_definitions(BSP_DEFINES_ONLY)
add_compile_definitions(CONFIG_GPIO_AS_PINRESET)
add_compile_definitions(CONFIG_GPIO_AS_PINRESET)
add_compile_definitions(FLOAT_ABI_HARD)
add_compile_definitions(NRF52)
add_compile_definitions(NRF52832_XXAA)
add_compile_definitions(NRF52_PAN_74)
add_compile_definitions(__HEAP_SIZE=8192)
add_compile_definitions(__STACK_SIZE=8192)

#----------------------------------------------------------------------------------------------------------------------
# Child directories
#----------------------------------------------------------------------------------------------------------------------
add_subdirectory(src)

#----------------------------------------------------------------------------------------------------------------------
# Targets
#----------------------------------------------------------------------------------------------------------------------
file(GLOB LIBRARIES ${CMAKE_BINARY_DIR}/lib/*.a)

add_custom_target(export_elf ALL
        COMMAND
            ${ARM_OBJCOPY} -O ihex ${CMAKE_BINARY_DIR}/bin/blinky.elf ${CMAKE_BINARY_DIR}/bin/blinky.hex
        COMMAND
            ${ARM_OBJCOPY} -O binary ${CMAKE_BINARY_DIR}/bin/blinky.elf ${CMAKE_BINARY_DIR}/bin/blinky.bin
        DEPENDS
            blinky.elf
)

add_custom_target(flash
        COMMAND
            nrfjprog -f nRF52 --program ${CMAKE_BINARY_DIR}/bin/blinky.hex --chiperase
        COMMAND
            nrfjprog --reset
)

add_custom_target(erase
        COMMAND
            nrfjprog -e
)

add_custom_target(reset
        COMMAND
            nrfjprog --reset
        )

add_custom_target(dump_section_headers
        DEPENDS
        export_elf
        )

foreach(LIB ${LIBRARIES})
    dump_object(dump_section_headers -h ${LIB})
endforeach()
dump_object(dump_section_headers -h ${CMAKE_BINARY_DIR}/bin/blinky.hex)

add_custom_target(dump_symbols
        DEPENDS
        export_elf
        )

foreach(LIB ${LIBRARIES})
    dump_object(dump_symbols -t ${LIB})
endforeach()
dump_object(dump_symbols -t ${CMAKE_BINARY_DIR}/bin/blinky.hex)