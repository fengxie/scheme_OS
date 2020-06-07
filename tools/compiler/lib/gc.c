
#include <gc.h>
#include <scheme.h>
#include <svm.h>

#include <stdlib.h>

static Space_t _free_space;

int gc_init(void)
{
	_free_space.start = malloc(2 << 20);
	_free_space.size = 2 << 18;
	
	return 0;
}

void gc_alloc_obj(Scheme_Type_t type, int size)
{
	unsigned long nunits;
	Scheme_Obj_t *obj = _free_space.start;

	nunits = ROUND_SIZE(size);
	if (_free_space.size < nunits) {
		g_svm.reg_new = NULL;
		return ;
	}
	_free_space.start += (nunits & 0xffff) * 4;
	_free_space.size -= nunits & 0xffff;

	SCHEME_HEAD_TYPE(obj) = type;
	SCHEME_SIZE(obj) = size;
	g_svm.reg_new = obj;
}
