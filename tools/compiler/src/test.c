/* This file is generated by scm2c */

/* File head */

#include <svm.h>
#include <scheme.h>
#include <gc.h>
#include <builtin.h>
#include <config.h>

#include <debug.h>

#include <stdio.h>
#include <stdlib.h>




void mod_init()
{
SCHEME_ENVT_BINDINGS(global_environment) = alloc_binds(0);
}

static void test_mod_run()
{
push_continuation(scheme_return);

svm_register(value) = (SCHEME_CTYPE(Obj) *)scheme_false;
if (SCHEME_TRUEP(svm_register(value))) {
svm_register(value) = (SCHEME_CTYPE(Obj) *)SCHEME_INT_TO_OBJ(1);
GOTO(.L_scm_0);
}
svm_register(value) = (SCHEME_CTYPE(Obj) *)scheme_false;
if (SCHEME_TRUEP(svm_register(value))) {
svm_register(value) = (SCHEME_CTYPE(Obj) *)SCHEME_INT_TO_OBJ(2);
GOTO(.L_scm_0);
}
svm_register(value) = (SCHEME_CTYPE(Obj) *)scheme_true;
if (SCHEME_TRUEP(svm_register(value))) {
svm_register(value) = (SCHEME_CTYPE(Obj) *)SCHEME_INT_TO_OBJ(3);
GOTO(.L_scm_0);
}
svm_register(value) = (SCHEME_CTYPE(Obj) *)scheme_void;
LABEL(.L_scm_0);
M_builtin_display(0);
MOVESP(0);

LABEL(scheme_return);
}


int main(int argc, char *argv[])
{
scheme_init_all(STACK_SIZE);

test_mod_run();
printf("Finish\n");

return 0;
}
