
#include <kscm/config.h>

#include <kscm/proc.h>
#include <kscm/mm.h>

Kscm_proc_t kscm_kernel[1];

Kscm_proc_t *kscm_current_proc;

void kscm_init_proc()
{
	extern Kscm_proc_t kscm_kernel[1], *kscm_current_proc;

	kscm_current_proc = kscm_kernel;
}
