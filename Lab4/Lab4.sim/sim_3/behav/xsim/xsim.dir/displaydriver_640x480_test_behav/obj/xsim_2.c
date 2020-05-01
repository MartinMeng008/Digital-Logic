/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_8(char*, char *);
extern void execute_9(char*, char *);
extern void execute_2240(char*, char *);
extern void execute_2241(char*, char *);
extern void execute_2242(char*, char *);
extern void execute_2243(char*, char *);
extern void execute_2244(char*, char *);
extern void execute_2245(char*, char *);
extern void execute_2246(char*, char *);
extern void execute_2237(char*, char *);
extern void execute_2238(char*, char *);
extern void execute_2239(char*, char *);
extern void execute_4(char*, char *);
extern void execute_2230(char*, char *);
extern void execute_2231(char*, char *);
extern void execute_2232(char*, char *);
extern void execute_2233(char*, char *);
extern void execute_2234(char*, char *);
extern void execute_2235(char*, char *);
extern void execute_2236(char*, char *);
extern void execute_6(char*, char *);
extern void execute_7(char*, char *);
extern void execute_11(char*, char *);
extern void execute_2227(char*, char *);
extern void execute_2228(char*, char *);
extern void execute_2229(char*, char *);
extern void execute_2247(char*, char *);
extern void execute_2248(char*, char *);
extern void execute_2249(char*, char *);
extern void execute_2250(char*, char *);
extern void execute_2251(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[32] = {(funcp)execute_8, (funcp)execute_9, (funcp)execute_2240, (funcp)execute_2241, (funcp)execute_2242, (funcp)execute_2243, (funcp)execute_2244, (funcp)execute_2245, (funcp)execute_2246, (funcp)execute_2237, (funcp)execute_2238, (funcp)execute_2239, (funcp)execute_4, (funcp)execute_2230, (funcp)execute_2231, (funcp)execute_2232, (funcp)execute_2233, (funcp)execute_2234, (funcp)execute_2235, (funcp)execute_2236, (funcp)execute_6, (funcp)execute_7, (funcp)execute_11, (funcp)execute_2227, (funcp)execute_2228, (funcp)execute_2229, (funcp)execute_2247, (funcp)execute_2248, (funcp)execute_2249, (funcp)execute_2250, (funcp)execute_2251, (funcp)vlog_transfunc_eventcallback};
const int NumRelocateId= 32;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/displaydriver_640x480_test_behav/xsim.reloc",  (void **)funcTab, 32);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/displaydriver_640x480_test_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/displaydriver_640x480_test_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstantiate();

extern void implicit_HDL_SCcleanup();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/displaydriver_640x480_test_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/displaydriver_640x480_test_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/displaydriver_640x480_test_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
