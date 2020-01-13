add_library(sdk
        STATIC
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
            ${SDK_DIR}/modules/nrfx/nrfx.h
)

target_include_directories(sdk
        PUBLIC
            ${SDK_DIR}/components
            ${SDK_DIR}/modules/nrfx/mdk
            ${SDK_DIR}/components/libraries/strerror
            ${SDK_DIR}/components/toolchain/cmsis/include
            ${SDK_DIR}/components/libraries/util
            ${SDK_DIR}/components/libraries/balloc
            ${SDK_DIR}/components/libraries/ringbuf
            ${SDK_DIR}/modules/nrfx/hal
            ${SDK_DIR}/components/libraries/bsp
            ${SDK_DIR}/components/libraries/log
            ${SDK_DIR}/modules/nrfx
            ${SDK_DIR}/components/libraries/experimental_section_vars
            ${SDK_DIR}/components/libraries/delay
            ${SDK_DIR}/integration/nrfx
            ${SDK_DIR}/components/drivers_nrf/nrf_soc_nosd
            ${SDK_DIR}/components/libraries/atomic
            ${SDK_DIR}/components/boards
            ${SDK_DIR}/components/libraries/memobj
            ${SDK_DIR}/external/fprintf
            ${SDK_DIR}/components/libraries/log/src
            ${SDK_DIR}/examples/peripheral/blinky/pca10040/blank/config
)

set_source_files_properties(${SDK_DIR}/modules/nrfx/mdk/gcc_startup_nrf52.S PROPERTIES
        COMPILE_FLAGS
            "-x assembler-with-cpp"
)

set_target_properties_default(sdk)