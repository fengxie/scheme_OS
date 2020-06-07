
#include "proc.h"

#include "eval.h"
#include "scheme.h"
#include "salloc.h"
#include "list.h"
#include "env.h"

#include <stdio.h>

Scheme_obj_t scheme_void[1]; /* the void constant */

/* locals */
DEFUN_LOCAL(apply);

#ifndef TEST
static
#endif	/* TEST */
Scheme_prim_bind_t proc_funcs[] = {
	{ "apply", apply, 2, 2, },
};

void scheme_init_proc(Scheme_env_t *env)
{
	SCHEME_SET_TYPE(scheme_void, scheme_void_type);
}

Scheme_obj_t *scheme_apply(Scheme_obj_t *proc, Scheme_obj_t *pars)
{
	Scheme_obj_t *rslt;
	
	switch (SCHEME_TYPE(proc)) {
	case scheme_prim_proc_type:
		rslt = scheme_apply_prim_proc(proc, pars);
		break;
	case scheme_cpd_proc_type:
		rslt = scheme_eval_sequence(
			SCHEME_PROC_BODY(proc),
			scheme_extend_env(
				SCHEME_PROC_PARAS(proc),
				pars,
				SCHEME_PROC_ENV(proc)));
		break;
	default:		/* excetpion: */
		#ifdef DEBUG_MSG
		printf("Unknown procedure type -- APPLY\n");
		#endif	/* DEBUG_MSG */
		rslt = scheme_void;
		break;
	}
	
	return rslt;
}

Scheme_obj_t *scheme_make_prim_proc(Scheme_local_func_t fun, int mina, int maxa)
{
	Scheme_obj_t *prim;

	prim = scheme_alloc_obj();
	SCHEME_SET_PRIM_FUN(prim, fun);
	SCHEME_SET_PRIM_MAXA(prim, maxa);
	SCHEME_SET_PRIM_MINA(prim, mina);
	SCHEME_SET_TYPE(prim, scheme_prim_proc_type);

	return prim;
}

Scheme_obj_t *scheme_apply_prim_proc(Scheme_obj_t *prim_proc, Scheme_obj_t *arg)
{
	int i, argc;
	Scheme_obj_t *p, **argv, **q;
	
	for (argc = 0, p = arg; !SCHEME_NULLP(p); argc++)
		p = SCHEME_CDR(p);
	
	if (SCHEME_PRIM_MAXA(prim_proc) > 0
	    && argc > SCHEME_PRIM_MAXA(prim_proc)) { /* exception: */
		return scheme_void;
	}
	else if (argc < SCHEME_PRIM_MINA(prim_proc)) { /* exception: */
		return scheme_void;
	}

	q = argv = (Scheme_obj_t **)scheme_alloc(sizeof(Scheme_obj_t *) * argc);
	i = 0;
	while (i < argc) {
		i++;
		*q++ = SCHEME_CAR(arg);
		arg = SCHEME_CDR(arg);
	}
	
	return SCHEME_PRIM_FUN(prim_proc)(argc, argv);
}

Scheme_obj_t *scheme_make_procedure(Scheme_obj_t *vars, Scheme_obj_t *body, Scheme_env_t *env)
{
	Scheme_obj_t *proc;

	proc = scheme_alloc_obj();
	SCHEME_SET_PROC_BODY(proc, body);
	SCHEME_SET_PROC_PARAS(proc, vars);
	SCHEME_SET_PROC_ENV(proc, env);
	SCHEME_SET_TYPE(proc, scheme_cpd_proc_type);
	
	return proc;
}

/* locals */
DEFUN_LOCAL(apply)
{
	return scheme_apply(argv[0], argv[1]);
}

