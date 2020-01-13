macro(dump_object TARGET ARG FILE)
    add_custom_command(
            TARGET
            ${TARGET} POST_BUILD
            COMMAND
            ${CMAKE_COMMAND} -E echo ===============================================================================
            COMMAND
            ${ARM_OBJDUMP} ${ARG} ${FILE}
            COMMAND
            ${CMAKE_COMMAND} -E echo ===============================================================================
    )
endmacro()

macro(set_target_properties_default TARGET)
    set_target_properties(${TARGET}
            PROPERTIES
            ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
            LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
            RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
            )
endmacro()