
/* head of compiled C source file */
#include <svm.h>
#include <gc.h>
#include <scheme.h>

#include <stdio.h>
#include <stdlib.h>

static Scheme_Symbol_t sym_add;
static Scheme_Symbol_t sym_func;

static Scheme_Pair_t pair_1;
static Scheme_Pair_t pair_2;

static Scheme_Template_t add_template[1];
static Scheme_Template_t func_template[1];

static void compiled_add();
static void compiled_func();

static Scheme_Obj_t *global_bindings[][2];

/* data field */
/* runtime environment */
/* 
 * static Scheme_Envt_t global_environment[1] = {
 * 	{{scheme_env_type, 2}, NULL, &global_bindings}
 * };
 */

static Scheme_Obj_t *global_bindings[][2] = {
	{(Scheme_Obj_t *)&sym_add, NULL},
	{(Scheme_Obj_t *)&sym_func, NULL}
};

/* template for binary code */
/* SCHEME_DEF_CONST(Template, ) */
static SCHEME_DEF_TEMPLATE(add_template, compiled_add);
/* static Scheme_Template_t add_template[1] = {{ compiled_add, }}; */
static Scheme_Template_t func_template[1] = {{ compiled_func, }};

static Scheme_Closure_t add_closure[1] = {
	{
		/* head of object */
		{
			scheme_closure_type,
			sizeof(Scheme_Closure_t) / sizeof(void *)
		},
		global_environment,
		add_template,
	}
};

static Scheme_Closure_t func_closure[1] = {
	{
		/* head of object */
		{
			scheme_closure_type,
			sizeof(Scheme_Closure_t) / sizeof(void *)
		},
		global_environment,
		func_template,
	}
};

/* constant values in code */
static Scheme_Symbol_t sym_add = {
	{scheme_symbol_type, 3}, "add", 3,
};

static Scheme_Symbol_t sym_func = {
	{scheme_symbol_type, 3}, "func", 4,
};

static Scheme_Pair_t pair_1 = {
	{scheme_pair_type, 3},
	(Scheme_Obj_t *)((1 << 1) | 0x1),
	(Scheme_Obj_t *)((3 << 1) | 0x1),
};

static Scheme_Pair_t pair_2 = {
	{scheme_pair_type, 3},
	(Scheme_Obj_t *)((10 << 1) | 0x1),
	(Scheme_Obj_t *)((5 << 1) | 0x1),
};

/* Definitions of functions */
/* (define (add a) (+ (car a) (cdr a))) */
static void add()
{
	/* start of compiled procedure */
	BEGIN_PROC(compiled_add);
	
	g_svm.reg_temp[0] = ((Scheme_Pair_t *)g_svm.stack_top[0])->car;
	g_svm.reg_temp[1] = ((Scheme_Pair_t *)g_svm.stack_top[0])->cdr;

	/* return caller */
	g_svm.reg_value = (Scheme_Obj_t *)
		((unsigned long)g_svm.reg_temp[0] +
		 (unsigned long)g_svm.reg_temp[1] - 1);
	resume_continuation();
}

/* (define (func a b)
 *    (let ((c 100)
 *          (d 200))
 *       (if (> a b)
 *           (add (10 . 5))
 *           d))) */
static void func()
{
	PROC_ENTRY(compiled_func);

	new_obj(scheme_env_type, sizeof(Scheme_Envt_t));
	SCHEME_ENVT_BINDINGS(g_svm.reg_new) = malloc(sizeof(Scheme_Obj_t *) * 2 * 2);
	
	/* for ``let*'' */
	/* EXTEND_ENVT(g_svm.reg_new); */
	SCHEME_SET_VAR(g_svm.reg_new, 0, (100 << 1) | 0x1);
	SCHEME_SET_VAR(g_svm.reg_new, 1, (200 << 1) | 0x1);
	EXTEND_ENVT(g_svm.reg_new);

	/* a: g_svm.stack_top[0]
	 * b: g_svm.stack_top[1] */
	/* ����չ��(> a b)������ֵ�������bool�͵ı��ʽ�������㹻
	 * �򵥵ģ����Խ�����if�ϳ�һ�� */
	if (g_svm.stack_top[0] > g_svm.stack_top[1])
		g_svm.reg_value = scheme_true;
	else
		g_svm.reg_value = scheme_false;
	if (SCHEME_TRUEP(g_svm.reg_value)) {
		/*
		 * ����β�ݹ飬�Ż����������continuation�Ĵ���
		 * push_continuation(resume3); */
		g_svm.reg_value = (Scheme_Obj_t *)&pair_2;
		svm_push();
		g_svm.reg_value = SCHEME_GET_VAR(g_svm.reg_envt->enclosing, 0);
		apply_procedure();
		/* LABEL(resume3); */
	}
	else
		g_svm.reg_value = SCHEME_GET_VAR(g_svm.reg_envt, 1);

	/* return caller */
	resume_continuation();
}

/* end of function definitions */

static void all_init()
{
	Scheme_Obj_t **stack;

	stack = malloc(sizeof(void *) * 1024);
	gc_init();
	global_environment->bindings = &global_bindings;
	
	SCHEME_HEAD_TYPE(global_environment) = scheme_env_type;
	svm_init(global_environment, stack, 1024);

	/* ��ʼ��ȫ�ֹ��̣�ֱ��������Χ����ָ������㻷�� */
}

void mod_init()
{
	
}

/* func name: <prefix>_mod_init */
void tst_svm_mod_init()
{
	/* ������ֵ�ڻ����е�ƫ���ɱ��������������������ҵ��������
	 * ��ǰ������λ�ã������ҵ���Ӧ��Χ������ָ�룬������Ҫ����
	 * �������ã��������ȫ�ֻ����У���ֱ������ȫ�ֻ�����*/
	SCHEME_SET_VAR(g_svm.reg_envt, 0, add_closure);
	SCHEME_SET_VAR(g_svm.reg_envt, 1, func_closure);

	/* Compiled code for ``(add (2 . 3))'' */
	/* save current contination */
	push_continuation(resume1); /* label: resume1  */

	/* calculate all arguments */
	g_svm.reg_value = (Scheme_Obj_t *)&pair_1;
	/* ������ջ���Ż��Ժ󣬲���Ҫÿ��һ����������ջ��
	 * ����һ�ε���ջָ���������㹻�Ĳ������������ã�
	 * �µĺ������ûᱣ��continuation��������Ӱ�� */
	svm_push();

	/* calculate function */
	g_svm.reg_value = SCHEME_GET_VAR(g_svm.reg_envt, 0);

	/* GOTO(resume1); */
	/* apply function */
	apply_procedure();   /* ����������Ψһlabel: resume1 */
	LABEL(resume1);
	printf("%d\n", (unsigned int)g_svm.reg_value >> 1);

	push_continuation(resume2);

	/* (func a b) */
	/* b */
	/* SETREG(value, (21 << 1) | 0x1); */
	/* cat(g_svm, reg_value); */
	
	g_svm.reg_value = (Scheme_Obj_t *)((21 << 1) | 0x1);
	svm_push();
	/* a */
	g_svm.reg_value = (Scheme_Obj_t *)((23 << 1) | 0x1);
	svm_push();

	g_svm.reg_value = SCHEME_GET_VAR(g_svm.reg_envt, 1);

	apply_procedure();
	LABEL(resume2);
	
	printf("%d\n", (unsigned int)g_svm.reg_value >> 1);
}

int main(int argc, char *argv[])
{
	all_init();
	tst_svm_mod_init();
	printf("Finish\n");

	return 0;
}
