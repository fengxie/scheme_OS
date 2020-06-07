#ifndef ASM_SEGMENT_H
#define ASM_SEGMENT_H

struct seg_des {
	unsigned limit_l : 16;
	unsigned base_l : 16;
	unsigned base_c : 8;
	unsigned type : 4;
	unsigned s : 1;
	unsigned dpl : 2;
	unsigned p : 1;
	unsigned limit_h : 4;
	unsigned avl : 1;
	unsigned rsv : 1;
	unsigned db : 1;
	unsigned g : 1;
	unsigned base_h : 8;
} __attribute__((packed));

static inline void seg_setup_base(struct seg_des *des, void *addr)
{
	des->base_l = (unsigned)((0xffff & addr));
	des->base_c = (unsigned)((0xff0000 & addr) >> 16);
	des->base_h = (unsigned)((0xff000000 & addr) >> 24);
}

static inline void seg_setup_limit(struct seg_des *des, size_t size)
{
	des->limit_l = (0xffff000 & size) >> 12;
	des->limit_h = (0xf0000000 & size) >> 28;
}

#endif
