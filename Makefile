TARGET = DENEME001
ALLEGRO_VER = 5.0.10
MINGW_VER = 4.7.0

CC = gcc
CFLAGS = -Wall 

LL = gcc
LFLAGS = -Wall

CFLAGS_OWN_INC = -I./include
LFLAGS_OWN_LIB = -L./lib

TOP := $(dir $(lastword $(MAKEFILE_LIST)))

ALLEGRO_INC = -I./include/allegro-$(ALLEGRO_VER)-mingw-$(MINGW_VER)/include
ALLEGRO_LIB = $(TOP)/include/allegro-$(ALLEGRO_VER)-mingw-$(MINGW_VER)/lib/liballegro-$(ALLEGRO_VER)-monolith-mt.a

DIRSOURCE = src
DIROBJECT = lib
DIRBINARY = bin

OWN_SOURCES := $(wildcard $(DIRSOURCE)/*.c)
OWN_OBJECTS := $(OWN_SOURCES:$(DIRSOURCE)/%.c=$(DIROBJECT)/%.o)

rm = del /Q

ALL: $(DIRBINARY)/$(TARGET) RUN remove

$(DIRBINARY)/$(TARGET): $(OWN_OBJECTS)
	@$(LL) $(LFLAGS) $(LFLAGS_OWN_LIB) $< -o $@ $(ALLEGRO_LIB)
	@echo "Linking complete!"

$(OWN_OBJECTS): $(DIROBJECT)/%.o : $(DIRSOURCE)/%.c
	@$(CC) $(CFLAGS) $(CFLAGS_OWN_INC) $(ALLEGRO_INC) -c $< -o $@
	@echo "Compiled "$<" successfully!"
	
RUN:
	./$(DIRBINARY)/$(TARGET)

.PHONY: clean
clean:
	@$(rm) $(OWN_SOURCES:$(DIRSOURCE)/%.c=$(DIROBJECT)\\%.o) 2>NULL.txt
	@echo "Cleanup complete!"

.PHONY: remove
remove: clean
	@$(rm) $(DIRBINARY)\\$(TARGET).exe 2>NULL.txt
	@echo "Executable removed!"