PROJ_NAME=app
ASM_FILES=$(shell find . -name "*.asm")
OBJECT_FILES=$(ASM_FILES:%.asm=%.o)

NASM_OPTS=-f elf
LD_OPTS=-m32 -no-pie

all: $(PROJ_NAME)

$(PROJ_NAME): link
	@echo "\o/"

# Importante! Use TABs, o Makefile apenas aceita TABs

#ld -m elf_i386 -s -o hello hello.o
link: $(OBJECT_FILES)
	@echo "Ligando objetos $(OBJECT_FILES)"
	@gcc $(LD_OPTS) -s -o $(PROJ_NAME) $(OBJECT_FILES)

#nasm -f elf hello.asm
%.o: %.asm
	@echo "Montando arquivo $< -> $@"
	@nasm $(NASM_OPTS) -o $@ $<

clean:
	@echo "Limpando projeto"
	@rm -f $(PROJ_NAME) *.o


.PHONY: clean
