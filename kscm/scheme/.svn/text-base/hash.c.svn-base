#include "hash.h"

#include "scheme.h"
#include "salloc.h"

#include <stdio.h>

struct _HtList *_HT_[HTABLE_SIZE];

/* locals */
static long _hash_symbol(void *obj);

void scheme_init_hash(Scheme_obj_t *env)
{
	
}

Scheme_htable_t *scheme_make_hash(Scheme_compar_t eq_p)
{
	int i;
	Scheme_htable_t *ht;

	ht = scheme_alloc(sizeof(Scheme_htable_t));
	ht->ht = _HT_;
	ht->eq_p = eq_p;
	for (i = 0; i < HTABLE_SIZE; i++)
		ht->ht[i] = NULL;
	
	return ht;
}

Scheme_obj_t *scheme_hash_get(Scheme_htable_t *ht, void *key)
{
	struct _HtList *p;
	
	p = ht->ht[_hash_symbol(key)];
	while (p != NULL) {
		if (ht->eq_p(key, p->key))
			break;
		p = p->next;
	}
	if (p != NULL)
		return p->val;

	return scheme_void;
}

int scheme_hash_put(Scheme_htable_t *ht, void *key, Scheme_obj_t *obj)
{
	long k;
	struct _HtList *p;
	
	p = ht->ht[k = _hash_symbol(key)];
	while (p != NULL) {
		if (ht->eq_p(key, p->key) == 0)
			break;
		p = p->next;
	}
	if (p != NULL)
		p->val = obj;
	else {
		p = scheme_alloc(sizeof(struct _HtList));
		p->next = ht->ht[k];
		p->key = key;
		p->val = obj;
		ht->ht[k] = p;
	}
	
	return 0;
}

/* locals */
static long _hash_symbol(void *obj)
{
	int i, h = 0;
	char *s = (char *)obj;
	
	for (i = 0; s[i] != '\0'; i++)
		;
	while (i-- > 0)
		h += (h<< 5) + h + s[i];
	h += (h << 2);

	return ((unsigned long)h >> 1) % HTABLE_SIZE;
}
