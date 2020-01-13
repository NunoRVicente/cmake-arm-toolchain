#----------------------------------------------------------------------------------------------------------------------
# Local Libs
#----------------------------------------------------------------------------------------------------------------------
add_subdirectory(sdk)

#----------------------------------------------------------------------------------------------------------------------
# Main target
#----------------------------------------------------------------------------------------------------------------------
add_executable(blinky.elf blinky.c)

set_target_properties_default(blinky.elf)

target_link_options(blinky.elf
        PRIVATE
            -L${SDK_DIR}/modules/nrfx/mdk           # Add serach path
            -T${CMAKE_SOURCE_DIR}/misc/linker.ld    # Linker file
            -Wl,-Map=${CMAKE_BINARY_DIR}/bin/main.map
        )

target_link_libraries(blinky.elf sdk)