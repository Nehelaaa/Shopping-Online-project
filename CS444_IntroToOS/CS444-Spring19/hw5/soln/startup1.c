/* C startup file, called from startup0.s-- */
extern clr_bss(void);
extern init_devio(void);
extern k_init(void);
void startupc(void);

void startupc()
{
  clr_bss();			/* clear BSS area (uninitialized data) */
  init_devio();			/* latch onto Tutor-supplied info, code */
  (void)k_init();		/* start kernel */
}
