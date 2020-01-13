# CMake ARM Toolchain

Toolchain for arm-none-eabi using the *blinky* example from nRF5 SDK.

## Dependencies

To build the solution one must have:

* [The GNU Embedded Toolchain for Arm](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads)
* [The nRF5 SDK](https://www.nordicsemi.com/Software-and-tools/Software/nRF5-SDK)
* [The nRF Command Line Tools](https://www.nordicsemi.com/Software-and-tools/Development-Tools/nRF-Command-Line-Tools/Download)

## Configuration

This project uses CMake as configuration tool. The required parameters for grained configuration are:

* The generator given by the '-G' flag. 
* CMAKE_BUILD_TYPE: 'Debug' or 'Release build type.
* TOOLCHAIN_PREFIX: Path to toolchain folder.
* SDK_DIR: Path to the SDK directory.
* CMAKE_TOOLCHAIN_FILE: Path to the toolchain file. By default should be "cmake/toolchain.cmake".
* The build folder given by the '-B' flag.

Example:

```cmake
cmake -G Ninja -DCMAKE_BUILD_TYPE="Release" -DTOOLCHAIN_PREFIX="C:/Program Files (x86)/GNU Tools ARM Embedded/8 2019-q3-update"  -DSDK_DIR="C:/nRF5_SDK_16.0.0_98a08e2" -DCMAKE_TOOLCHAIN_FILE="cmake/toolchain.cmake" -B _build
```

For more information type
```shell
cmake -h
```
or visit https://cmake.org/documentation/.

## Targets

After the configuration is completed the following targets are available through the chosen generator:

* export_elf - Exports the .elf file to .hex and .bin. Depends on blinky.elf.
* flash - Programs the board with chip erase and reset. Depends on export_elf.
* erase - Erases the board.
* reset - Resets the board firmware.
* dump_section_headers - Dumps section headers of all code targets.
* dump_symbols - Dumps symbols of all code targets.

For more information about the targets and usage of each generator, please visit the help info of the one's choice.