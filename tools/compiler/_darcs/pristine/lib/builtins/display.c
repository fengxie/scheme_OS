
#include <builtins/display.h>

#include <config.h>

#include <builtin.h>
#include <svm.h>
#include <scheme.h>

#include <stdio.h>
#include <stdlib.h>

static char output_buffer[MAX_OUTPUT_BUF];

static int list_to_string(char *buf, Scheme_Obj_t *list);

static int obj_to_string(char *buf, Scheme_Obj_t *obj)
{
	int cnt;
	
	switch (SCHEME_TYPE(obj)) {
	case Scheme_Int_Type:
		cnt = sprintf(buf, "%d", SCHEME_OBJ_TO_INT(obj));
		break;
	case Scheme_True_Type:
		cnt = sprintf(buf, "#t");
		break;
	case Scheme_False_Type:
		cnt = sprintf(buf, "#f");
		break;
	case Scheme_Symbol_Type:
		cnt = sprintf(buf, "%s", SCHEME_SYMBOL_GET_STR(obj));
		break;
	case Scheme_String_Type:
		cnt = sprintf(buf, "\"%s\"", SCHEME_SYMBOL_GET_STR(obj));
		break;
	case Scheme_Pair_Type:
		cnt = list_to_string(buf, obj);
		break;
	case Scheme_Null_Type:
		cnt = sprintf(buf, "()");
	default:
		break;
	}
	
	return cnt;
}

static int list_to_string(char *buf, Scheme_Obj_t *list)
{
	char *__des = buf;
	Scheme_Obj_t *p, *car;

	*__des++ = '('; p = list;
	while (SCHEME_PAIRP(p)) {
		car = SCHEME_CAR(p);
		if(SCHEME_PAIRP(car))
			__des += list_to_string(__des, car);
		else
			__des += obj_to_string(__des, car);

		*__des++ = ' ';
		p = SCHEME_CDR(p);
	}
	if (!SCHEME_NULLP(p)) {
		*__des++ = '.';
		*__des++ = ' ';
		__des += obj_to_string(__des, p);
		*__des++ = ' ';
	}
	*(__des - 1) = ')';
	*__des = '\0';

	return __des - buf;
}

/* (display #<scheme object>) */
void builtin_display()
{
	obj_to_string(output_buffer, svm_register(value));
	printf("%s\n", output_buffer);
}
