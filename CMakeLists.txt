###
## Author:  Ricardo Vicente
##
## CMake arm-none-eabi toolchain for ARM Cortex M4 using Nordic nRF5 SDK
##
cmake_minimum_required(VERSION 3.14)

# Set toolchain paths and check for binaries.
# It is done here so it can be performed before all the calls of toolchain.cmake file.
if (NOT DEFINED CMAKE_TOOLCHAIN_FILE)
    message(FATAL_ERROR "Toolchain file not set. Please set CMAKE_TOOLCHAIN_FILE with toolchain.cmake path.")
endif()

if (NOT DEFINED SDK_DIR)
    message(FATAL_ERROR "SDK directory not defined. Please set SDK_DIR with SDK directory.")
endif ()

include(cmake/binaries.cmake)

project(TagWifi
        VERSION 0.0.1
        LANGUAGES C ASM
)

set(CMAKE_VERBOSE_MAKEFILE ON)

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
# Nested builds
#----------------------------------------------------------------------------------------------------------------------
add_subdirectory(src)

#----------------------------------------------------------------------------------------------------------------------
# Targets
#----------------------------------------------------------------------------------------------------------------------
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