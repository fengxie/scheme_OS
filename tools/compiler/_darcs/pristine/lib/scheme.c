
#include <scheme.h>
#include <svm.h>

#include <stdlib.h>

SCHEME_DEF_CONST(Void, scheme_void);
SCHEME_DEF_CONST(Null, scheme_null);
SCHEME_DEF_CONST(True, scheme_true);
SCHEME_DEF_CONST(False, scheme_false);

SCHEME_CTYPE(Obj) scheme_ascii[256][1];

SCHEME_DEF_CONST(Envt, global_environment, NULL, NULL);

extern void mod_init();

void scheme_init_all(int stack_size)
{
	int i;
        Scheme_Obj_t **stack;
	Scheme_Obj_t *binds;

        stack = malloc(sizeof(void *) * stack_size);
        gc_init();

	/* initialize some global constants */
	for (i = 0; i < 256; i++) {
		SCHEME_HEAD_TYPE(scheme_ascii[i]) = Scheme_Char_Type;
		SCHEME_SIZE(scheme_ascii[i]) = SCHEME_ROUND_SIZE(Char);
	}

	/* initialize global environment */
        SCHEME_HEAD_TYPE(global_environment) = Scheme_Envt_Type;

	/* binds slots will be initialized when enter module */
	/* binds = malloc(sizeof(void *) * 2 * 16); */
	/* SCHEME_ENVT_BINDINGS(global_environment) = alloc_binds(16); */

	/* initialize the virtual machine */
        svm_init(global_environment, stack, stack_size);

	mod_init();
}

Scheme_Binds_t alloc_binds(int nobj)
{
	Scheme_Binds_t p;

	p = malloc(sizeof(Scheme_Obj_t *) * nobj * 2);

	return p;
}
