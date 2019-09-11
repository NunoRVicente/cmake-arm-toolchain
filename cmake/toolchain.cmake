#---------------------------------------------------------------------------------------------------------------------
# Targets
#---------------------------------------------------------------------------------------------------------------------
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)
# set(CMAKE_SYSTEM_VERSION )

#---------------------------------------------------------------------------------------------------------------------
# Set compilers
#---------------------------------------------------------------------------------------------------------------------
set(CMAKE_C_COMPILER ${ARM_GCC})
set(CMAKE_CXX_COMPILER ${ARM_G++})
set(CMAKE_ASM_COMPILER ${ARM_GCC})

#---------------------------------------------------------------------------------------------------------------------
# Flags
#---------------------------------------------------------------------------------------------------------------------
# ====================================================================================================================
# -mcpu=cortex-m4       : Select Cortex-M4 architecture.
#
# -mthumb               : Executes in Thumb state. Thumb instruction set is (mostly) 16 bit and allows for code to be
#                         smaller, and can potentially be faster if the target has slow memory.
#
# -mabi=aapcs           : Uses Procedure Call Standard (PCS) for the ARM Architecture.
#                         https://web.eecs.umich.edu/~prabal/teaching/resources/eecs373/ARM-AAPCS-EABI-v2.08.pdf
#
# -Wall                 : Enables all the warnings about constructions that some users consider questionable, and that
#                         are easy to avoid (or modify to prevent the warning), even in conjunction with macros.
#
# -Wextra               : Enable extra warnings not enabled by Wall
#
# -Werror               : Make all warnings into errors.
#
# -mfloat-abi=hard      : Floating-point ABI set to 'hard'.
#
# -mfpu=fpv4-sp-d16     : Floating-point hardware set to fpv4-sp-d16.
#                         The combination of these flags sets Cortex-M4 with Hard FP.
#
# -ffunction-sections
# -fdata-sections       : Place each function or data item into its own section in the output file if the target
#                         supports arbitrary sections. The name of the function or the name of the data item determines
#                         the section’s name in the output file.
#
# -fno-strict-aliasing  :
#
# -fno-builtin          : Don’t recognize built-in functions that do not begin with '__builtin_' as prefix.
#
# -fshort-enums         : Allocate to an enum type only as many bytes as it needs for the declared range of possible
#                         values. Specifically, the enum type is equivalent to the smallest integer type that has
#                         enough room.
#
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
# -O3 -g3
# -Werror \
# ====================================================================================================================
set(CMAKE_C_FLAGS_INIT
        "-mcpu=cortex-m4 \
        -mthumb \
        -mabi=aapcs \
        -Wall \
        -Wextra \
        -mfloat-abi=hard \
        -mfpu=fpv4-sp-d16 \
        -ffunction-sections \
        -fdata-sections \
        -fno-strict-aliasing \
        -fno-builtin \
        -fshort-enums"
)

# ====================================================================================================================
# -mcpu=cortex-m4       : Select Cortex-M4 architecture.
#
# -mthumb               : Executes in Thumb state. Thumb instruction set is (mostly) 16 bit and allows for code to be
#                         smaller, and can potentially be faster if the target has slow memory.
#
# -mabi=aapcs           : Uses Procedure Call Standard (PCS) for the ARM Architecture.
#                         https://web.eecs.umich.edu/~prabal/teaching/resources/eecs373/ARM-AAPCS-EABI-v2.08.pdf
#
# -mfloat-abi=hard      : Floating-point ABI set to 'hard'.
#
# -mfpu=fpv4-sp-d16     : Floating-point hardware set to fpv4-sp-d16.
#                         The combination of these flags sets Cortex-M4 with Hard FP.
#
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
# -g3
# ====================================================================================================================
set(CMAKE_ASM_FLAGS
        "-mcpu=cortex-m4 \
        -mthumb \
        -mabi=aapcs \
        -mfloat-abi=hard \
        -mfpu=fpv4-sp-d16"
)

# ====================================================================================================================
# https://www.st.com/content/ccc/resource/technical/document/user_manual/group1/cd/29/43/c5/36/c0/40/bb/Newlib_nano_readme/files/newlib-nano_readme.pdf/jcr:content/translations/en.newlib-nano_readme.pdf
# ====================================================================================================================
# -mcpu=cortex-m4       : Select Cortex-M4 architecture.
#
# -mthumb               : Executes in Thumb state. Thumb instruction set is (mostly) 16 bit and allows for code to be
#                         smaller, and can potentially be faster if the target has slow memory.
#
# -mabi=aapcs           : Uses Procedure Call Standard (PCS) for the ARM Architecture.
#                         https://web.eecs.umich.edu/~prabal/teaching/resources/eecs373/ARM-AAPCS-EABI-v2.08.pdf
#
# -mfloat-abi=hard      : Floating-point ABI set to 'hard'.
#
# -mfpu=fpv4-sp-d16     : Floating-point hardware set to fpv4-sp-d16.
#                         The combination of these flags sets Cortex-M4 with Hard FP.
#
# -Wl,--gc-sections     : Linker option for enabling garbage collection of unused input sections.
#
# --specs=nano.specs    : Link with newlib-nano. https://keithp.com/newlib-nano/
#
# --specs=nosys.specs   : No syscalls, provide empty implementations for the POSIX system calls.
#
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
# -O3 -g3
# -L${SDK_DIR}/modules/nrfx/mdk -T${CMAKE_HOME_DIRECTORY}/linker.ld
# ====================================================================================================================
set(CMAKE_EXE_LINKER_FLAGS_INIT
        "-mcpu=cortex-m4 \
        -mthumb \
        -mabi=aapcs \
        -mfloat-abi=hard \
        -mfpu=fpv4-sp-d16 \
        -Wl,--gc-sections \
        --specs=nano.specs \
        --specs=nosys.specs"
)

#---------------------------------------------------------------------------------------------------------------------
# Modes
#---------------------------------------------------------------------------------------------------------------------
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)