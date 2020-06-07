
#include "scheme.h"
#include "salloc.h"
#include "port.h"
#include "sstring.h"
#include "bool.h"
#include "numb.h"
#include "read.h"
#include "syylex.h"
#include "display.h"
#include "eval.h"
#include "hash.h"
#include "env.h"

#include <stdio.h>
#include <ctype.h>

extern Scheme_prim_bind_t string_funcs[10];
extern Scheme_prim_bind_t read_funcs[10];
extern Scheme_obj_t *_meta_string_to_obj(const char *str, Scheme_token_type_t type);

struct Test {
	int length;
	char str[0];
};

int main(int argc, char *argv[])
{
	int i, len;
	Scheme_obj_t *p, *exp, *port, *str1, *str2, *p1, *p2, *l1, *l2, *arg[30];
	char *str = "abcdefghijklmnopq";
	char des[20], buf[1024];
	struct Test *pack = (struct Test *)malloc(sizeof(struct Test) + 10);
	pack->length = 10;
	strcpy(pack->str, "abcdefg");
	
	scheme_init();
	
	for (i = 0; i < 25; i++) {
		arg[i] = SCHEME_CHAR_TO_OBJ('A' + 2 * i);
	}
	
	/* 
         * SCHEME_SET_TYPE(arg[0], scheme_integer_type);
	 * SCHEME_SET_INT(arg[0], 10);
	 * arg[1] = SCHEME_CHAR_TO_OBJ('b');
         */
	str1 = string_funcs[1].fun(25, arg);
	str2 = string_funcs[1].fun(25, arg);
	printf("str1: %s, str2: %s\n", SCHEME_STR_VAL(str1), SCHEME_STR_VAL(str2));
	p1 = string_funcs[2].fun(1, &str1);
	p2 = string_funcs[2].fun(1, arg);
	printf("pred1: %d, pred2: %d\n", SCHEME_TRUEP(p1), SCHEME_TRUEP(p2));
	l1 = string_funcs[3].fun(1, &str1);
	l2 = string_funcs[3].fun(1, &str2);
	printf("len1: %d, len2: %d\n", SCHEME_INT_VAL(l1), SCHEME_INT_VAL(l2));

	arg[0] = str1;
	arg[1] = scheme_alloc_obj();
	SCHEME_SET_TYPE(arg[1], scheme_integer_type);
	SCHEME_SET_INT(arg[1], 7);
	printf("char of str1: %c\n", SCHEME_CHAR_VAL(string_funcs[4].fun(2, arg)));
	arg[0] = str2;
	arg[2] = SCHEME_CHAR_TO_OBJ('\\');
	string_funcs[5].fun(3, arg);
	printf("str2: %s\n", SCHEME_STR_VAL(str2));

	if (argc > 1) {
		port = scheme_make_char_input_stream(argv[1]);
	}
	else
/* 
 * 		port = scheme_make_char_input_stream("(define (fun a b) (if (null? a) b (fun (cdr a) (+ 1 b)))) \
 * (fun \'(1 2 3 4 5) 0)");
 */
		port = scheme_make_char_input_stream("(+ 1 2)\n");
		/* 
                 * port = scheme_make_char_input_stream("(define (fun a b) \
                 *                                          (cond ((null? a) 0) \
                 *                                                (#t (+ 5 b)))) (fun \'(1) 5)");
                 */

	exp = scheme_read(port);
	scheme_obj_to_string(buf, exp);
	printf("object: %s\n", buf);
	p = scheme_eval(exp, scheme_global_environment);
	scheme_obj_to_string(buf, p);
	printf("value: %s\n", buf);

	/* 
         * exp = scheme_read(port);
	 * scheme_obj_to_string(buf, exp);
	 * printf("object: %s\n", buf);
	 * p = scheme_eval(exp, scheme_global_environment);
	 * scheme_obj_to_string(buf, p);
	 * printf("value: %s\n", buf);
         */

	printf("%x, %x, %s\n", &(pack->length), &(pack->str), pack->str);
	
	/* 
         * p = read_funcs[0].fun(1, &port);
	 * scheme_obj_to_string(buf, p);
	 * printf("object: %s\n", buf);
	 * exp = scheme_analyze(p);
	 * p = scheme_eval(exp, scheme_global_environment);
	 * scheme_obj_to_string(buf, p);
	 * printf("value: %s\n", buf);
         */

	return 0;
}
