#---------------------------------------------------------------------------------------
# Set toolchain paths
#---------------------------------------------------------------------------------------
if(NOT DEFINED TOOLCHAIN_PREFIX)
    message(FATAL_ERROR "Toolchain path not set. Please set TOOLCHAIN_PREFIX with GNU Tools path.")
endif()

set(TOOLCHAIN arm-none-eabi)
set(TOOLCHAIN_BIN_DIR ${TOOLCHAIN_PREFIX}/bin)
set(TOOLCHAIN_INC_DIR ${TOOLCHAIN_PREFIX}/${TOOLCHAIN}/include)
set(TOOLCHAIN_LIB_DIR ${TOOLCHAIN_PREFIX}/${TOOLCHAIN}/lib)

# Set system depended extensions
if(WIN32)
    set(TOOLCHAIN_EXT ".exe" )
else()
    set(TOOLCHAIN_EXT "" )
endif()

#---------------------------------------------------------------------------------------
# Defining macro for checking binaries
#---------------------------------------------------------------------------------------
macro(check_binary VAR_NAME BIN_NAME)
    FIND_PROGRAM(${VAR_NAME} ${TOOLCHAIN}-${BIN_NAME}${TOOLCHAIN_EXT} PATHS ${TOOLCHAIN_BIN_DIR})
    if (${${VAR_NAME}} STREQUAL ${VAR_NAME}-NOTFOUND)
        message(FATAL_ERROR "ARM ${BIN_NAME} Not Found in ${TOOLCHAIN_BIN_DIR}")
    endif()

    message("${BIN_NAME} : ${${VAR_NAME}}")
endmacro()

message("")
check_binary(ARM_ADDR2LINE addr2line)
check_binary(ARM_AR ar)
check_binary(ARM_AS as)
check_binary(ARM_C++ c++)
check_binary(ARM_CPP cpp)
check_binary(ARM_ELFEDIT elfedit)
check_binary(ARM_G++ g++)
check_binary(ARM_GCC gcc)
check_binary(ARM_GCOV gcov)
check_binary(ARM_GDB gdb)
check_binary(ARM_LD ld)
check_binary(ARM_OBJCOPY objcopy)
check_binary(ARM_OBJDUMP objdump)

message("")
message(STATUS "All binaries were found.")
message("")