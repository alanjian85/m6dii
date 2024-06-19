#pragma once

typedef int (*jit_func_t)(void);

void jit_init(void);
jit_func_t jit_emit(int num);
