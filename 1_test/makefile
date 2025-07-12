# Makefile for NASM Hello World program

# File names
SRC     := main.asm exit.asm read_puz_file.asm print.asm
OBJ 	:= $(SRC:.asm=.o)
BIN     := test

# Tools
ASM     := nasm
ASMFLAGS:= -felf64 -g
LD      := ld
LDFLAGS :=

# Default target
all: $(BIN)

# Build with debug info
debug: ASFLAGS += -g
debug: LDFLAGS += -g
debug: $(OUT)

# Link the object file
$(BIN): $(OBJ)
	$(LD) $(LDFLAGS) $(OBJ) -o $@

# Assemble the source file
%.o: %.asm
	$(ASM) $(ASMFLAGS) -o $@ $<



# Clean up build files
clean:
	rm -f $(OBJ) $(BIN)

.PHONY: all debug clean