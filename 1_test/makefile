# Makefile for NASM Hello World program

# File names
OBJDIR     := build
SRCS       := main.asm exit.asm read_puz_file.asm print.asm
OBJS       := $(SRCS:%.asm=$(OBJDIR)/%.o)
TARGET     := sudoku

# Tools
COMP       := nasm
COMPFLAGS  := -felf64 -g
LD         := ld
LDFLAGS    :=

# Default target
all: $(TARGET)
	@echo -----
	@echo Cleaning up object files...
	@rm -rf build
	@echo Build complete: $(TARGET)
	
run: $(TARGET)
	@echo -----
	@echo Cleaning up object files...
	@rm -rf build
	@echo Build complete: $(TARGET)
	@echo - running......
	@echo
	@./$(TARGET)

# Build with debug info
debug: ASFLAGS += -g
debug: LDFLAGS += -g
debug: $(TARGET)
	@echo Debug build complete: $(TARGET)
	@echo - running debugger......
	@gdb $(TARGET)


$(TARGET): $(OBJS)
	@echo -----
	@echo Linking $(TARGET)...
	$(LD) $(LDFLAGS) $(OBJS) -o $@
	@echo Target created: $(TARGET)

$(OBJDIR)/%.o: %.asm | $(OBJDIR)
	@echo -----
	@echo Compiling $<...
	$(COMP) $(COMPFLAGS) -o $@ $<
	@echo Object file created: $@

$(OBJDIR):
	@echo -----
	@echo Creating object directory...
	mkdir -p $(OBJDIR)
	@echo Object directory created: $(OBJDIR)

# Clean up build files
clean:
	rm -f $(OBJS) $(TARGET) 
	rm -rf $(OBJDIR)

.PHONY: all debug clean run