#ifndef SCHEME_H
#define SCHEME_H

#include <sys/types.h>

#ifndef __int8_t_defined
typedef unsigned long int32_t;
#endif	/* __int8_t_defined */
typedef int32_t mem_blk_t;

#define ROUND_SIZE(size) (((size) - 1) / sizeof(mem_blk_t) + 1)

typedef enum Scheme_Type {
	scheme_env_type,
	scheme_cont_type,	/* continuation */
	scheme_forward_type,
	scheme_entry_type,
	
	_scheme_values_types_,
	
	scheme_void_type,

	scheme_true_type,
	scheme_false_type,
	scheme_symbol_type,
	scheme_null_type,	/* () */
	scheme_pair_type,	/* (x . y) */

	scheme_closure_type,
} Scheme_Type_t;

enum {
	Scheme_Envt_Type,
	Scheme_Cont_Type,	/* continuation */
	Scheme_Forward_Type,
	Scheme_Entry_Type,
	
	_Scheme_Values_Types_,
	
	Scheme_Void_Type,

	Scheme_True_Type,
	Scheme_False_Type,
	Scheme_Char_Type,
	Scheme_Int_Type,
	Scheme_String_Type,
	Scheme_Symbol_Type,
	Scheme_Null_Type,	/* () */
	Scheme_Pair_Type,	/* (x . y) */

	Scheme_Closure_Type,
};

typedef unsigned long _svm_word_t;

typedef struct Scheme_Head {
	int16_t type;
	int16_t size;
} Scheme_Head_t;

typedef struct Scheme_Obj {
	/* head field of scheme object */
	Scheme_Head_t head;

	int32_t value[0];
} Scheme_Obj_t;

#define SCHEME_HEAD_TYPE(obj) ((obj)->head.type)

#define SCHEME_INTP(obj) ((unsigned long)(obj) & 0x1)
#define SCHEME_INT_ZERO ((Scheme_Obj_t *)0x1)
#define SCHEME_OBJ_TO_INT(obj) ((int)(obj) >> 1)
#define SCHEME_INT_TO_OBJ(obj) ((Scheme_Obj_t *)(((int)(obj) << 1) | 0x1))

#define SCHEME_CTYPE(type) Scheme_ ## type ## _t

#define SCHEME_TYPE(obj) (SCHEME_INTP(obj)? Scheme_Int_Type: (obj)->head.type)
#define SCHEME_SIZE(obj) ((obj)->head.size)
#define SCHEME_SET_TAG(obj, type, size)		\
	((obj)->head.type = ((type) | (ROUND_SIZE(size)) << 16 ))

#define SCHEME_ROUND_SIZE(type) ((sizeof(SCHEME_CTYPE(type)) - 1) / sizeof(Scheme_Obj_t) + 1)

/* short types */
typedef Scheme_Obj_t Scheme_Void_t;
typedef Scheme_Obj_t Scheme_Null_t;
typedef Scheme_Obj_t Scheme_True_t;
typedef Scheme_Obj_t Scheme_False_t;
typedef Scheme_Obj_t Scheme_Char_t;

#define SCHEME_FALSEP(obj) ((obj) == scheme_false)
#define SCHEME_TRUEP(obj) (!SCHEME_FALSEP(obj))

typedef void (*Compiled_Code_t)();

typedef struct Scheme_Template {
	Compiled_Code_t code;
} Scheme_Template_t;

#define SCHEME_DEF_TEMPLATE(name, fn)		\
	Scheme_Template_t name[1] = {{ fn }}	\

typedef Scheme_Obj_t *(*Scheme_Binds_t)[][2];

Scheme_Binds_t alloc_binds(int nobj);

typedef struct Scheme_Envt {
	Scheme_Head_t head;

	struct Scheme_Envt *enclosing;
	/* Scheme_Obj_t (*bindings)[0][2]; */
	Scheme_Binds_t bindings;
} Scheme_Envt_t;

#define SCHEME_ENVT_ENCLOSING(envt)		\
	(((Scheme_Envt_t *)(envt))->enclosing)
#define SCHEME_ENVT_BINDINGS(envt)		\
	(((Scheme_Envt_t *)(envt))->bindings)
#define SCHEME_SET_VAR(envt, offset, value)				\
	((*(((Scheme_Envt_t *)(envt))->bindings))[(offset)][0] =	\
	 (Scheme_Obj_t *)(value))
#define SCHEME_GET_VAR(envt, offset)				\
	((*(((Scheme_Envt_t *)(envt))->bindings))[(offset)][0])

typedef struct Scheme_Closure {
	Scheme_Head_t head;

	struct Scheme_Envt *envt;
	struct Scheme_Template *template;
} Scheme_Closure_t;

#define SCHEME_CLOSURE_ENVT(proc)		\
	(((Scheme_Closure_t *)proc)->envt)
#define SCHEME_CLOSURE_TEMPLATE(proc)		\
	(((Scheme_Closure_t *)proc)->template)

/* description of continuation */
typedef struct Scheme_Cont {
	Scheme_Head_t head;
	
	Scheme_Envt_t *reg_envt;
	Scheme_Template_t *reg_template;
	Compiled_Code_t reg_pc;
	
	Scheme_Obj_t **stack_base, **stack_top;

	struct Scheme_Cont *next;
} Scheme_Cont_t;

#define OBJ_TO_CONT(obj) ((Scheme_Cont_t *)(obj))

/* macros that help write more readable compiler */
#define SCHEME_HEAD_INIT(type)						\
	{Scheme_ ## type ## _Type, SCHEME_ROUND_SIZE(type)}

#define SCHEME_TYPEDEF(type, fields)		\
	typedef struct Scheme_ ## type {	\
			Scheme_Head_t head;	\
			fields			\
	} Scheme_ ## type ## _t;

#ifdef __GNUC__

#define SCHEME_DEF_CONST(type, obj, fields...)			\
	SCHEME_CTYPE(type) obj[1] = {				\
		{						\
			SCHEME_HEAD_INIT(type),			\
			## fields,				\
		}						\
	}

#define SCHEME_DECL(type, obj)			\
	extern SCHEME_CTYPE(type) obj[1]

#else

/* do not support gnu c, stop! */
#error Your need gcc to compile this program.

#endif

SCHEME_TYPEDEF(Pair, Scheme_Obj_t *car; Scheme_Obj_t *cdr;)

/* operation on pair */
#define SCHEME_CAR(obj) (((SCHEME_CTYPE(Pair) *)(obj))->car)
#define SCHEME_CDR(obj) (((SCHEME_CTYPE(Pair) *)(obj))->cdr)

SCHEME_TYPEDEF(String, char *str; int str_len;)
SCHEME_TYPEDEF(Symbol, char *str; int str_len;)

/* predefined contants */
SCHEME_DECL(Void, scheme_void);
SCHEME_DECL(Null, scheme_null);
SCHEME_DECL(True, scheme_true);
SCHEME_DECL(False, scheme_false);

extern Scheme_Obj_t scheme_ascii[256][1];

SCHEME_DECL(Envt, global_environment);

extern void scheme_init_all(int stack_size);

#endif
