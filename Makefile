DIR_BUILD=build

OBJECTS=$(DIR_BUILD)/blink.o

MSP_TOOLCHAIN_HOME=/home/shylock/Workspace/msp430-gcc
GCC_DIR =  $(MSP_TOOLCHAIN_HOME)/bin
SUPPORT_FILE_DIRECTORY = $(MSP_TOOLCHAIN_HOME)/include


# Please set your device here
DEVICE  = msp430f5526
CC      = $(GCC_DIR)/msp430-elf-gcc
GDB     = $(GCC_DIR)/msp430-elf-gdb

CFLAGS = -I $(SUPPORT_FILE_DIRECTORY) -mmcu=$(DEVICE) -O2 -g
LFLAGS = -L $(SUPPORT_FILE_DIRECTORY) -T $(DEVICE).ld

all: ${OBJECTS} $(DIR_BUILD)
	$(CC) $(CFLAGS) $(LFLAGS) $< -o $(DIR_BUILD)/$(DEVICE).out

%.o : %.c $(DIR_BUILD)
	$(CC) $(CFLAGS) $(LFLAGS) -c $< -o $(DIR_BUILD)/$@

$(DIR_BUILD) : 
	mkdir -p ./build

debug: all
	$(GCC_DIR)/gdb_agent_console $(MSP_TOOLCHAIN_HOME)/msp430.dat &
	$(GDB) $(DIR_BUILD)/$(DEVICE).out
