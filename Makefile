all: m6dii

emit.c: emit.dasc
	luajit LuaJIT/dynasm/dynasm.lua $< -o $@

CFLAGS = -I . -I LuaJIT/dynasm
SRCS := $(wildcard *.c)
ifeq ($(filter jit.c,$(SRCS)),)
	SRCS += emit.c
endif
OBJS := $(patsubst %.c,%.o,$(SRCS))

%.o: %.c
	$(CC) $< -c -o $@ $(CFLAGS)

m6dii: $(OBJS) 
	$(CC) $(OBJS) -o m6dii 

run: | m6dii
	./m6dii

clean:
	rm -f emit.c
	rm -f *.o
	rm -f m6dii
