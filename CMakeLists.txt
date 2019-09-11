##
## Author:  Ricardo Vicente
##
## CMake arm-none-eabi toolchain for ARM Cortex M4 using Nordic nRF5 SDK
##
cmake_minimum_required(VERSION 3.14)

# Set toolchain paths and check for binaries.
# It is done here so it can be performed before all the calls of toolchain.cmake file.
include(cmake/binaries.cmake)

project(TagWifi
        VERSION 0.0.1
        LANGUAGES C
)

#----------------------------------------------------------------------------------------------------------------------
# Set SDK
#----------------------------------------------------------------------------------------------------------------------
set(SDK_COMPONENTS ${SDK_DIR}/components)

#----------------------------------------------------------------------------------------------------------------------
# Preprocessor defines
#----------------------------------------------------------------------------------------------------------------------
add_compile_definitions(BOARD_PCA10040)
add_compile_definitions(BSP_DEFINES_ONLY)
add_compile_definitions(CONFIG_GPIO_AS_PINRESET)
add_compile_definitions(FLOAT_ABI_HARD)
add_compile_definitions(NRF52)
add_compile_definitions(NRF52832_XXAA)
add_compile_definitions(NRF52_PAN_74)

add_compile_options(-o main.out)

add_link_options(-L${SDK_DIR}/modules/nrfx/mdk)     # Add serach path
add_link_options(-T${CMAKE_SOURCE_DIR}/linker.ld)   # Linker file.

#----------------------------------------------------------------------------------------------------------------------
# Libraries
#----------------------------------------------------------------------------------------------------------------------
#add_library(nrfx_mdk STATIC
#        ${SDK_DIR}/modules/nrfx/mdk/gcc_startup_nrf52.S
#        ${SDK_DIR}/modules/nrfx/mdk/system_nrf52.c
#)
#target_include_directories(nrfx_mdk
#        INTERFACE
#            $<BUILD_INTERFACE:${SDK_DIR}/modules/nrfx/>
#            $<BUILD_INTERFACE:${SDK_DIR}/modules/nrfx/mdk/>
#            $<INSTALL_INTERFACE:include>
#)
#
#add_library(log STATIC
#        ${SDK_DIR}/components/libraries/log/src/nrf_log_frontend.c
#        ${SDK_DIR}/components/libraries/log/src/nrf_log_str_formatter.c
#)
#target_include_directories(log
#        INTERFACE
#            $<BUILD_INTERFACE:${SDK_DIR}/components/libraries/log/>
#            $<INSTALL_INTERFACE:include>
#)
#
#add_library(config INTERFACE)
#target_include_directories(config
#        INTERFACE
#            $<BUILD_INTERFACE:${SDK_DIR}/examples/peripheral/blinky/pca10040/blank/config>
#            $<INSTALL_INTERFACE:include>
#)
#
#add_library(util STATIC
#        ${SDK_DIR}/components/libraries/util/app_error.c
#        ${SDK_DIR}/components/libraries/util/app_error_handler_gcc.c
#        ${SDK_DIR}/components/libraries/util/app_error_weak.c
#        ${SDK_DIR}/components/libraries/util/app_util_platform.c
#        ${SDK_DIR}/components/libraries/util/nrf_assert.c
#)
#
#target_include_directories(util
#        INTERFACE
#            $<BUILD_INTERFACE:${SDK_DIR}/components/libraries/util>
#            $<INSTALL_INTERFACE:include>
#)

add_library(sdk_lib STATIC
        ${SDK_DIR}/modules/nrfx/mdk/gcc_startup_nrf52.S
        ${SDK_DIR}/components/libraries/log/src/nrf_log_frontend.c
        ${SDK_DIR}/components/libraries/log/src/nrf_log_str_formatter.c
        ${SDK_DIR}/components/boards/boards.c
        ${SDK_DIR}/components/libraries/util/app_error.c
        ${SDK_DIR}/components/libraries/util/app_error_handler_gcc.c
        ${SDK_DIR}/components/libraries/util/app_error_weak.c
        ${SDK_DIR}/components/libraries/util/app_util_platform.c
        ${SDK_DIR}/components/libraries/util/nrf_assert.c
        ${SDK_DIR}/components/libraries/atomic/nrf_atomic.c
        ${SDK_DIR}/components/libraries/balloc/nrf_balloc.c
        ${SDK_DIR}/external/fprintf/nrf_fprintf.c
        ${SDK_DIR}/external/fprintf/nrf_fprintf_format.c
        ${SDK_DIR}/components/libraries/memobj/nrf_memobj.c
        ${SDK_DIR}/components/libraries/ringbuf/nrf_ringbuf.c
        ${SDK_DIR}/components/libraries/strerror/nrf_strerror.c
        ${SDK_DIR}/modules/nrfx/soc/nrfx_atomic.c
        ${SDK_DIR}/modules/nrfx/mdk/system_nrf52.c
)

target_include_directories(sdk_lib
        PUBLIC
            $<BUILD_INTERFACE:${SDK_DIR}/components/>
            $<BUILD_INTERFACE:${SDK_DIR}/modules/nrfx/mdk>
            $<BUILD_INTERFACE:${SDK_DIR}/components/libraries/strerror>
            $<BUILD_INTERFACE:${SDK_DIR}/components/toolchain/cmsis/include>
            $<BUILD_INTERFACE:${SDK_DIR}/components/libraries/util>
            $<BUILD_INTERFACE:${SDK_DIR}/components/libraries/balloc>
            $<BUILD_INTERFACE:${SDK_DIR}/components/libraries/ringbuf>
            $<BUILD_INTERFACE:${SDK_DIR}/modules/nrfx/hal>
            $<BUILD_INTERFACE:${SDK_DIR}/components/libraries/bsp>
            $<BUILD_INTERFACE:${SDK_DIR}/components/libraries/log>
            $<BUILD_INTERFACE:${SDK_DIR}/modules/nrfx>
            $<BUILD_INTERFACE:${SDK_DIR}/components/libraries/experimental_section_vars>
            $<BUILD_INTERFACE:${SDK_DIR}/components/libraries/delay>
            $<BUILD_INTERFACE:${SDK_DIR}/integration/nrfx>
            $<BUILD_INTERFACE:${SDK_DIR}/components/drivers_nrf/nrf_soc_nosd>
            $<BUILD_INTERFACE:${SDK_DIR}/components/libraries/atomic>
            $<BUILD_INTERFACE:${SDK_DIR}/components/boards>
            $<BUILD_INTERFACE:${SDK_DIR}/components/libraries/memobj>
            $<BUILD_INTERFACE:${SDK_DIR}/external/fprintf>
            $<BUILD_INTERFACE:${SDK_DIR}/components/libraries/log/src>
            $<BUILD_INTERFACE:${SDK_DIR}/examples/peripheral/blinky/pca10040/blank/config>
            $<INSTALL_INTERFACE:include>
)

#----------------------------------------------------------------------------------------------------------------------
# Targets
#----------------------------------------------------------------------------------------------------------------------
#target_link_libraries(util nrfx_mdk config log)
#target_link_libraries(log nrfx_mdk util)

add_executable(main main.c)
target_link_libraries(main sdk_lib)

add_custom_command(
        TARGET
            main
        POST_BUILD
        COMMAND
            ${ARM_OBJCOPY} -O ihex ${CMAKE_CURRENT_BINARY_DIR}/main${CMAKE_EXECUTABLE_SUFFIX} ${CMAKE_SOURCE_DIR}/main.hex
)