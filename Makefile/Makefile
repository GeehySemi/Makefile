# ------------------------------------------------
# Generic Makefile (based on gcc)
#
# ChangeLog :
#   2022-5-23 - first version
# ------------------------------------------------

######################################
# target
######################################
TARGET = SysTick_TimeBase


######################################
# building variables
######################################
# debug build?
DEBUG = 1
# optimization
OPT = -Og


#######################################
# paths
#######################################
# Build path
BUILD_DIR = build

######################################
# source
######################################
# C sources
C_SOURCES =  \
Board/Board.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_adc.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_bakpr.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_can.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_crc.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_dac.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_dbgmcu.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_dma.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_dmc.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_eint.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_emmc.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_fmc.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_gpio.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_i2c.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_iwdt.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_misc.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_pmu.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_qspi.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_rcm.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_rtc.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_sci2c.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_sdio.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_spi.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_tmr.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_usart.c \
Library/APM32F10x_StdPeriphDriver/src/apm32f10x_wwdt.c \
Library/Device/Geehy/APM32F10x/Source/system_apm32f10x.c \
Source/apm32f10x_int.c \
Source/syscall.c \
Source/main.c

# ASM sources
ASM_SOURCES =  \
startup_apm32f10x_hd.s


#######################################
# binaries
#######################################
PREFIX = arm-none-eabi-
# The gcc compiler bin path can be either defined in make command via GCC_PATH variable (> make GCC_PATH=xxx)
# either it can be added to the PATH environment variable.
ifdef GCC_PATH
CC = $(GCC_PATH)/$(PREFIX)gcc
AS = $(GCC_PATH)/$(PREFIX)gcc -x assembler-with-cpp
CP = $(GCC_PATH)/$(PREFIX)objcopy
SZ = $(GCC_PATH)/$(PREFIX)size
else
CC = $(PREFIX)gcc
AS = $(PREFIX)gcc -x assembler-with-cpp
CP = $(PREFIX)objcopy
SZ = $(PREFIX)size
endif
HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S
 
#######################################
# CFLAGS
#######################################
# cpu
CPU = -mcpu=cortex-m3

# fpu
# NONE for Cortex-M0/M0+/M3

# float-abi


# mcu
MCU = $(CPU) -mthumb $(FPU) $(FLOAT-ABI)

# macros for gcc
# AS defines
AS_DEFS = 

# C defines
C_DEFS =  \
-DAPM32F103_MINI \
-DAPM32F10X_HD


# AS includes
AS_INCLUDES = 

# C includes
C_INCLUDES =  \
-IBoard \
-IInclude \
-ILibrary/APM32F10x_StdPeriphDriver/inc \
-ILibrary/CMSIS/Include \
-ILibrary/Device/Geehy/APM32F10x/Include \


# compile gcc flags
ASFLAGS = $(MCU) $(AS_DEFS) $(AS_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

CFLAGS += $(MCU) $(C_DEFS) $(C_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif


# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"


#######################################
# LDFLAGS
#######################################
# link script
LDSCRIPT = apm32f103xe_flash.ld

# libraries
LIBS = -lc -lm -lnosys 
LIBDIR = 
LDFLAGS = $(MCU) -specs=nano.specs -T$(LDSCRIPT) $(LIBDIR) $(LIBS) -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections

# default action: build all
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin


#######################################
# build the application
#######################################
# list of objects
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))
# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR) 
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	$(AS) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(HEX) $< $@
	
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(BIN) $< $@	
	
$(BUILD_DIR):
	mkdir $@		

#######################################
# clean up
#######################################
clean:
	-rm -fR $(BUILD_DIR)

#######################################
# update
#######################################
update:
	Jlink -ExitOnError 1 -AutoConnect 1 -Device APM32F103VC -If SWD -Speed 8000 -CommandFile "commands.jlink"
  
#######################################
# dependencies
#######################################
-include $(wildcard $(BUILD_DIR)/*.d)

# *** EOF ***