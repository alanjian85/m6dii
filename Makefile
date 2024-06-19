all: m6dii

CFLAGS = -I LuaJIT/dynasm
SRCS := $(wildcard *.c) emit.c
OBJS := $(patsubst %.c,%.o,$(SRCS))

emit.c: emit.dasc
	luajit LuaJIT/dynasm/dynasm.lua -o emit.c emit.dasc

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
