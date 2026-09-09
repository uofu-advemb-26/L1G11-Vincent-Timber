hello.txt:
	echo "hello world!" > hello.txt

PICO_TOOLCHAIN_PATH?=~/pico-sdk/toolchain/13_2_Rel1
CPP=/bin/arm-none-eabi-cpp
CC=/bin/arm-none-eabi-gcc
AS=/bin/arm-none-eabi-as

main.s: main.i
	$(CC) -S main.i

%.o: %.s
	$(AS) $< -o $@

main.i: main.c
	$(CPP) main.c > main.i

clean: 
	rm -f main.i hello.txt

.PHONY: clean