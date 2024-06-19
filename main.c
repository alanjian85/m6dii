#include <stdio.h>
#include <sys/mman.h>

#include <dasm_proto.h>

typedef int (*jit_func_t)(void);

void emit(dasm_State **Dst, int num);

static jit_func_t encode(dasm_State **Dst) {
    void *buf;
    size_t size;
    dasm_link(Dst, &size);
    buf = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    dasm_encode(Dst, buf);
    mprotect(buf, size, PROT_EXEC | PROT_READ);
    return buf;
}

int main() {
    dasm_State *dasm_state;

    int num;
    scanf("%d", &num);

    emit(&dasm_state, num);
    jit_func_t jit_func = encode(&dasm_state);

    printf("%d\n", jit_func());
    return 0;
}
