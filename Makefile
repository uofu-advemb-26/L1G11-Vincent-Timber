all: firmware.elf

hello.txt:
	echo "hello world!" > hello.txt

PICO_TOOLCHAIN_PATH?=~/pico-sdk/toolchain/13_2_Rel1
CPP=/bin/arm-none-eabi-cpp
CC=/bin/arm-none-eabi-gcc
AS=/bin/arm-none-eabi-as
LD=/bin/arm-none-eabi-ld

SRC=main.c second.c
OBJS=$(patsubst %.c,%.o,$(SRC))

firmware.elf: $(OBJS)
	$(LD) -o $@ $^

main.s: main.i
	$(CC) -S main.i

%.o: %.s
	$(AS) $< -o $@

main.i: main.c
	$(CPP) main.c > main.i

clean: 
	rm -f main.i hello.txt
	rm -f *.o

.PHONY: clean all