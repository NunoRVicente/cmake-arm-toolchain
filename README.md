# CMake ARM Toolchain

Toolchain for arm-none-eabi using the *blinky* example from nRF5 SDK.

## Requirements

* GNU ARM Embedded Toolchain: https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm
* Nordic nRF5SDK: https://www.nordicsemi.com/Software-and-Tools/Software/nRF5-SDK
* nRF Command Line Tools: https://www.nordicsemi.com/Software-and-Tools/Development-Tools/nRF-Command-Line-Tools

## Usage

Invoke CMake using these variables to define the external paths needed for the build:
* **TOOLCHAIN_PREFIX** : Path to GCC toolchain
* **SDK_DIR** : Path to nRF5 SDK
* **CMAKE_TOOLCHAIN_FILE**: Path to the toolchain file

Example:
```
cmake -DTOOLCHAIN_PREFIX=parent/directories/gcc-arm-none-eabi-X-20YY-qZ-update -DSDK_DIR=parent/directories/nRF5_SDK_XX.Y.Z_WWWWWW -DCMAKE_TOOLCHAIN_FILE=cmake/toolchain.cmake ./ -B build
```