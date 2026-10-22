all: firmware.elf

hello.txt:
	echo "hello world!" > hello.txt

# PICO_TOOLCHAIN_PATH?=~/pico-sdk/toolchain/13_2_Rel1
CPP=arm-none-eabi-cpp
CC=arm-none-eabi-gcc
AS=arm-none-eabi-as
LD=arm-none-eabi-ld

SRC=main.c second.c
OBJS=$(patsubst %.c,%.o,$(SRC))

firmware.elf: $(OBJS)
# 	ls -a $(ARM_NONE_EABI_GCC_PATH)/bin
	$(LD) -e main -o $@ $^

main.s: main.i
	$(CC) -S main.i

%.o: %.s
	$(AS) $< -o $@

main.i: main.c
	$(CPP) main.c > main.i

clean: 
	rm -f main.i hello.txt
	rm -f *.o
	rm -f *.i
	rm -f *.s
	rm -f *.elf

.PHONY: clean all