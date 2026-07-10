# APM32F103 GCC Makefile 示例 / APM32F103 GCC Makefile Example

[中文](#中文说明) | [English](#english)

## 中文说明

本项目提供一个基于 GNU Arm Embedded Toolchain 和 Makefile 的 APM32F103 编译示例。默认目标工程为 `SysTick_TimeBase`。

### 开发环境

- MCU：APM32F103（Cortex-M3）
- 开发板宏：`APM32F103_MINI`
- 工具链前缀：`arm-none-eabi-`
- 构建工具：GNU Make
- 默认优化：`-Og`
- 默认开启调试信息
- 输出目录：`build`

### 使用方法

请先安装 GNU Arm Embedded Toolchain 和 GNU Make，并确保 `arm-none-eabi-gcc` 可在系统 PATH 中使用。

```sh
cd Makefile
make
```

如果工具链未加入 PATH，可通过 `GCC_PATH` 指定工具链目录：

```sh
make GCC_PATH=/path/to/toolchain/bin
```

清理构建文件：

```sh
make clean
```

构建完成后，HEX、BIN、ELF 及映射文件将输出至 `build` 目录。

### 目录说明

- `Board/`：开发板支持文件
- `Library/`：APM32F10x 外设驱动与器件文件
- `Source/`：应用代码与中断处理
- `Include/`：应用头文件
- `Makefile`：编译配置
- `build/`：构建输出

### 注意事项

更换 MCU 型号、链接脚本、启动文件或开发板后，请同步检查编译宏、内存布局、CPU 参数和源文件列表。

### 技术支持

更多产品资料与技术支持请访问：[www.geehy.com](https://www.geehy.com/)。

---

## English

This project provides an APM32F103 build example based on the GNU Arm Embedded Toolchain and Make. The default target is `SysTick_TimeBase`.

### Development environment

- MCU: APM32F103 (Cortex-M3)
- Board macro: `APM32F103_MINI`
- Toolchain prefix: `arm-none-eabi-`
- Build tool: GNU Make
- Default optimization: `-Og`
- Debug information enabled by default
- Output directory: `build`

### Usage

Install the GNU Arm Embedded Toolchain and GNU Make, and ensure that `arm-none-eabi-gcc` is available in your PATH.

```sh
cd Makefile
make
```

If the toolchain is not in PATH, specify its binary directory with `GCC_PATH`:

```sh
make GCC_PATH=/path/to/toolchain/bin
```

Clean the build output:

```sh
make clean
```

The HEX, BIN, ELF, and map files are generated in the `build` directory.

### Directory structure

- `Board/`: board support files
- `Library/`: APM32F10x peripheral drivers and device files
- `Source/`: application and interrupt source files
- `Include/`: application headers
- `Makefile`: build configuration
- `build/`: generated output

### Notes

When changing the MCU, linker script, startup file, or board, review the build macros, memory layout, CPU options, and source-file list together.

### Support

For product information and technical support, visit [www.geehy.com](https://www.geehy.com/).
