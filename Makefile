%.o: %.c
	@echo "c to object"
	avr-gcc -c -Wall -Os -mmcu=atmega328p -DF_CPU=16000000UL $< -o $@

%.elf: %.o
	@echo "object to elf"
	avr-gcc -Wall -Os -mmcu=atmega328p -DF_CPU=16000000UL $< -o $@

%.hex: %.elf
	@echo "elf to hex"
	avr-objcopy -j .text -j .data -O ihex $< $@

install: hello-world.hex
	@echo "installing.."
	avrdude -v -patmega328p -carduino -b115200 -D -Uflash:w:$<:i -P$(wildcard /dev/tty.usb*)

clean:
	rm -f *.o *.elf *.hex

