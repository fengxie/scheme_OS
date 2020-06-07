
#include <kscm/config.h>

#include <kscm/mm.h>
#include <asm/system.h>
#include <asm/page.h>
#include <sys/types.h>
#include <kscm/proc.h>

#include <stdio.h>

#define PAGING_MEMORY (TOTAL_MEMORY - LOW_MEM)
#define PAGING_PAGES (PAGING_MEMORY >> 12)
#define PAGE_NUMB(vaddr) (((vaddr) - LOW_MEM) >> 12)
/* frame number -> physical address */
#define FRAME_NUMB_PADDR(fn) ((fn) << 12 + LOW_MEM)

/* data structures */
/* memory layout of the kernel */
Kscm_mm_region_t kscm_kernel_mm[] = {
	{ 0x0, K_PG_SIZE * 1024, -1},                   /* code & data structure */
	{ K_HEAP_START, K_PG_SIZE, MMR_EXPAND_UP},      /* heap */
	{ K_STACK_START, K_PG_SIZE, MMR_EXPAND_DOWN},    /* stack */
	{ K_SLOTS_START, K_PG_SIZE, MMR_EXPAND_UP},     /* slots */
	{ K_SLOTS_START + K_SLOTS_SIZE, 0, MMR_EXPAND_UP },
};

#define BITMAP_SIZE (PAGING_PAGES / sizeof(long) / 8)
static unsigned long _mm_bitmap[BITMAP_SIZE];
static unsigned long HIGH_MEMORY = 0;

unsigned long get_free_frame(void);

#define MEM_CODE_REGION 0
#define MEM_STACK_REGION 1
#define MEM_DATA_REGION 2

#define PAGE_FRAMES ((HIGH_MEMORY - LOW_MEM) >> 12)

/* locals */
static inline void *page_copy(void *pdest, void *psrc)
{
	void * __res = pdest;

	__asm__ volatile (
		"push %%esi\n\t"
		"push %%edi\n\t"
		"cld\n\t"
		"rep\n\t"
		"movsd\n\t"
		"pop %%edi\n\t"
		"pop %%esi\n\t"
		:
		: "D" ((long)__res), "S" ((long)psrc), "c" (1024)
		: "memory");
	
	return __res;
}

/* make a temp map for a page */
static inline void *temp_map_page(unsigned long addr)
{
	union pde *page_dir = 0x0;
	page_dir[TEMP_PAGE].val = (addr & 0xffc00000) | 0x87;
	
	return (void *)((addr & 0x3fffff) | (TEMP_PAGE << 22));
}

static void clear_page(void *page)
{
	int i, *__p = page;
	for (i = 0; i < K_PG_SIZE / sizeof(int); i++)
		*__p++ = 0;
}

/* initialize data structures for paging */
void kscm_init_paging()
{
	extern unsigned long KSCM_PAGE_DIR;
	extern Kscm_mm_region_t kscm_kernel_mm[];

	void *ptr, *q;
	unsigned long i, frame;
	union pte *page_table;
	union pde *page_dir = (union pde *)&KSCM_PAGE_DIR;

	HIGH_MEMORY = (EXTEND_MEMORY << 10) + 0x100000;

	/* there must be some wrong with my code what implicity
	 * changes is contents in ``kcm_mm_regions'' */
	kscm_kernel_mm[mm_text].start = 0;
	kscm_kernel_mm[mm_text].size = K_CODE_SIZE;
	kscm_kernel_mm[mm_text].flag = -1;
	kscm_kernel_mm[mm_heap].start = K_HEAP_START;
	kscm_kernel_mm[mm_heap].size = K_PG_SIZE;
	kscm_kernel_mm[mm_heap].flag = MMR_EXPAND_UP;
	kscm_kernel_mm[mm_stack].start = K_STACK_START;
	kscm_kernel_mm[mm_stack].size = K_PG_SIZE;
	kscm_kernel_mm[mm_stack].flag = MMR_EXPAND_DOWN;
	kscm_kernel_mm[mm_slots].start = K_SLOTS_START;
	kscm_kernel_mm[mm_slots].size = K_PG_SIZE;
	kscm_kernel_mm[mm_slots].flag = MMR_EXPAND_UP;
	kscm_current_proc->kernel_mm = kscm_kernel_mm;

	/* initialize memory map */
	for (i = 0; i < BITMAP_SIZE; i++)
		_mm_bitmap[i] = ~0x0;
	for (i = (LOW_MEM >> 22); i < 1024; i++)
		page_dir[i].val = 0;

	/* set the first stack page at end of the first 1G of vitual addr */
	/* allocate one 4-Kbyte pages for stack */
	ptr = kscm_kernel_mm[mm_stack].start;
	frame = get_free_frame();
	page_dir[PDT_IDX(ptr)].val = (unsigned long)frame | 0x7;
	page_table = temp_map_page(frame);

	clear_page(page_table);
	
	frame = get_free_frame();
	page_table[PGT_IDX(ptr)].val = (frame | 0x007); /* dirty & accessed */
	
	/* move temp stack from last 4KB page in code region to
	 * right place in stack region. At least one stack page
	 * is needed for running of this program. */
	q = kscm_kernel_mm[mm_text].start + kscm_kernel_mm[mm_text].size - K_PG_SIZE;
	page_copy(ptr, q);
	
	ptr = kscm_kernel_mm[mm_stack].start + kscm_kernel_mm[mm_stack].size;
	q = kscm_kernel_mm[mm_text].start + kscm_kernel_mm[mm_text].size;
	__asm__(
		"addl %%eax, %%esp\n\t"
		"addl %%eax, %%ebp\n\t"
		:: "a"((long)(ptr - q))
		);

	/* setup heap */
	frame = get_free_frame();
	put_page(K_HEAP_START, frame);
}

/*
 * Get physical address of first (actually last :-) free page, and mark it
 * used. If no free pages left, return 0.
 */
unsigned long get_free_frame(void)
{
	extern unsigned long _mm_bitmap[BITMAP_SIZE];

	unsigned long i = 0, fn, t;

	while (i < BITMAP_SIZE && _mm_bitmap[i] == 0)
		i++;
	if (i == BITMAP_SIZE)
		return 0;

	for (fn = 0, t = 1; t != 0; fn++, t <<= 1)
		if ((_mm_bitmap[i] & t) != 0) {
			_mm_bitmap[i] &= ~t;
			break;
		}
	
	return ((fn + i * sizeof(long) * 8) << 12) + LOW_MEM;
}

void free_frame(unsigned long frame)
{
	frame = (frame - LOW_MEM) >> 12;
	_mm_bitmap[frame >> 5] |= 1 << (frame & 0x1f);
}

void *put_page(void *ptr, unsigned long page)
{
	extern unsigned long KSCM_PAGE_DIR;

	unsigned long frame;

	/* for each procedure, its private page_dir is located at linear
	 * address 0x0 */
	union pde *page_dir = (union pde*)&KSCM_PAGE_DIR;
	union pte *page_table;

	if (page < LOW_MEM || page >= HIGH_MEMORY)
		return NULL;	/* out of physical mem range */
	/* 
         * if ((unsigned long)ptr < LOW_MEM || (unsigned long)ptr > TOTAL_MEMORY)
	 * 	return NULL;
         */
	
	/* union pte *page_table; */
	if (page_dir[PDT_IDX(ptr)].val == 0) {
		frame = get_free_frame();
		page_dir[PDT_IDX(ptr)].val = frame | 0x3;
		page_table = temp_map_page(frame);
		clear_page(page_table);
	}
	else if (page_dir[PDT_IDX(ptr)].pde.present == 0)
		/* use pde as a pointer to some data structure that
		 * hold the information for this page */
		;		/* on swap */
	else {
		frame = page_dir[PDT_IDX(ptr)].pde.base << 12;
		frame = page_dir[PDT_IDX(ptr)].val & ~0xfff;
		page_table = temp_map_page(frame);
	}

	page_table[PGT_IDX(ptr)].val = page | 0x3;
	/* reload tlbs */
	invalidate_tlbs();
	
	return ptr;
}

void *expand_region(int region)
{
	extern Kscm_proc_t *kscm_current_proc;

	unsigned long f;
	void *p = NULL;
	Kscm_mm_region_t *r, *t;

	if (region > mm_slots)
		return NULL;

	r = kscm_current_proc->kernel_mm + region;
	if (r->flag == MMR_EXPAND_UP) {
		t = kscm_current_proc->kernel_mm + region + 1;
		if (r->start + r->size + K_PG_SIZE > t->start)
			return NULL;
		p = r->start + r->size;
	}
	else if (r->flag == MMR_EXPAND_DOWN) {
		t = kscm_current_proc->kernel_mm + region - 1;
		if (r->start - K_PG_SIZE < t->start + t->size)
			return NULL;
		r->start -= K_PG_SIZE;
		p = r->start;
	}
	else if (r->flag < 0)
		return NULL;
	r->size += K_PG_SIZE;
	
	f = get_free_frame();
	if (put_page(p, f) == NULL) {
		free_frame(f);
		return NULL;
	}
	
	return p;
}
