#ifndef SSCAN_H
#define SSCAN_H

#include "syylex.h"

#define SCHEME_MAX_EXPR_LEN (64 * 1024)
typedef struct {
	Scheme_token_type_t type;
	char *token;
} Scheme_token_t;

#include "scheme.h"

Scheme_token_t *scheme_make_token_seq(Scheme_obj_t *port);
void scheme_free_token_seq(Scheme_token_t *seq);

#endif
