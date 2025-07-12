# Makefile for NASM Hello World program

# File names
SRC     := 3.asm
OBJ     := 1.o
BIN     := test

# Tools
ASM     := nasm
ASMFLAGS:= -felf64 -g
LD      := ld
LDFLAGS :=

# Default target
all: $(BIN)

# Link the object file
$(BIN): $(OBJ)
	$(LD) $(LDFLAGS) -o $@ $^

# Assemble the source file
$(OBJ): $(SRC)
	$(ASM) $(ASMFLAGS) -o $@ $<



# Clean up build files
clean:
	rm -f $(OBJ) $(BIN)
