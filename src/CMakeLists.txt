add_subdirectory(sdk)

add_executable(blinky.elf blinky.c)

target_link_libraries(blinky.elf sdk)

set_target_properties(blinky.elf PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
        LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
        RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
)

target_link_options(blinky.elf
        PRIVATE
            -L${SDK_DIR}/modules/nrfx/mdk           # Add serach path
            -T${CMAKE_SOURCE_DIR}/misc/linker.ld    # Linker file
)