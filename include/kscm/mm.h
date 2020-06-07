#ifndef MM_H
#define MM_H

#include <kscm/config.h>

#include <sys/types.h>

#define MMR_EXPAND_UP 0
#define MMR_EXPAND_DOWN 1

#define KSCM_MAX_REGION 16
enum Region_type {
	mm_text = 0,
	mm_heap,
	mm_stack,
	mm_slots,
};

typedef struct kscm_mm_region {
	void *start;
	size_t size;
	short flag;		/* expand direction */
} Kscm_mm_region_t;

typedef struct kscm_mm {
	Kscm_mm_region_t *kernel, *user;
} Kscm_mm_t;

#define invalidate_tlbs() \
	__asm__("movl %%eax,%%cr3"::"a" (PGDIR_PADDR))

#define MM_REGION_END(rs, t) ((rs)[(t)].start + (rs)[(t)].size)

#define TEMP_PAGE	255

extern void kscm_init_paging();

extern void *expand_region(int region);
extern void *put_page(void *ptr, unsigned long page);

#endif
