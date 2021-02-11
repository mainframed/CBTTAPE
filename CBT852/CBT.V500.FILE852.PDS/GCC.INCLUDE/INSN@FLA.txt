/* Generated automatically by the program `genflags'
   from the machine description file `md'.  */

#ifndef GCC_INSN_FLAGS_H
#define GCC_INSN_FLAGS_H

#define HAVE_tstdi 1
#define HAVE_tstsi 1
#define HAVE_tsthi 1
#define HAVE_tstdf 1
#define HAVE_tstsf 1
#define HAVE_cmpsi 1
#define HAVE_cmphi 1
#define HAVE_cmpqi 1
#define HAVE_cmpdf 1
#define HAVE_cmpsf 1
#define HAVE_cmpstrsi_1 1
#define HAVE_movdi 1
#define HAVE_movsi 1
#define HAVE_movhi 1
#define HAVE_movqi 1
#define HAVE_movstricthi 1
#define HAVE_movdf 1
#define HAVE_movsf 1
#define HAVE_movstrsi_1 1
#define HAVE_extendhisi2 1
#define HAVE_extendqisi2 1
#define HAVE_extendqihi2 1
#define HAVE_zero_extendhisi2 1
#define HAVE_zero_extendqisi2 1
#define HAVE_zero_extendqihi2 1
#define HAVE_truncsihi2 1
#define HAVE_fix_truncdfsi2 1
#define HAVE_floatsidf2 1
#define HAVE_truncdfsf2 1
#define HAVE_extendsfdf2 1
#define HAVE_addsi3 1
#define HAVE_addhi3 1
#define HAVE_addqi3 1
#define HAVE_adddf3 1
#define HAVE_addsf3 1
#define HAVE_subsi3 1
#define HAVE_subhi3 1
#define HAVE_subqi3 1
#define HAVE_subdf3 1
#define HAVE_subsf3 1
#define HAVE_muldf3 1
#define HAVE_mulsf3 1
#define HAVE_divdf3 1
#define HAVE_divsf3 1
#define HAVE_andsi3 1
#define HAVE_andhi3 1
#define HAVE_andqi3 1
#define HAVE_iorsi3 1
#define HAVE_iorhi3 1
#define HAVE_iorqi3 1
#define HAVE_xorsi3 1
#define HAVE_xorhi3 1
#define HAVE_xorqi3 1
#define HAVE_negsi2 1
#define HAVE_neghi2 1
#define HAVE_negdf2 1
#define HAVE_negsf2 1
#define HAVE_abssi2 1
#define HAVE_abshi2 1
#define HAVE_absdf2 1
#define HAVE_abssf2 1
#define HAVE_one_cmplsi2 1
#define HAVE_one_cmplhi2 1
#define HAVE_one_cmplqi2 1
#define HAVE_ashldi3 1
#define HAVE_ashrdi3 1
#define HAVE_ashlsi3 1
#define HAVE_ashrsi3 1
#define HAVE_ashlhi3 1
#define HAVE_ashrhi3 1
#define HAVE_ashlqi3 1
#define HAVE_ashrqi3 1
#define HAVE_lshrdi3 1
#define HAVE_lshrsi3 1
#define HAVE_lshrhi3 1
#define HAVE_lshrqi3 1
#define HAVE_beq 1
#define HAVE_bne 1
#define HAVE_bgt 1
#define HAVE_bgtu 1
#define HAVE_blt 1
#define HAVE_bltu 1
#define HAVE_bge 1
#define HAVE_bgeu 1
#define HAVE_ble 1
#define HAVE_bleu 1
#define HAVE_jump 1
#define HAVE_indirect_jump 1
#define HAVE_tablejump 1
#define HAVE_call 1
#define HAVE_call_value 1
#define HAVE_nop 1
#define HAVE_cmpstrsi 1
#define HAVE_clrstrsi 1
#define HAVE_movstrsi 1
#define HAVE_extendsidi2 1
#define HAVE_zero_extendsidi2 1
#define HAVE_adddi3 1
#define HAVE_mulsi3 1
#define HAVE_divsi3 1
#define HAVE_udivsi3 1
#define HAVE_modsi3 1
#define HAVE_umodsi3 1
#define HAVE_untyped_call 1
struct rtx_def;
extern struct rtx_def *gen_tstdi            PARAMS ((struct rtx_def *));
extern struct rtx_def *gen_tstsi            PARAMS ((struct rtx_def *));
extern struct rtx_def *gen_tsthi            PARAMS ((struct rtx_def *));
extern struct rtx_def *gen_tstdf            PARAMS ((struct rtx_def *));
extern struct rtx_def *gen_tstsf            PARAMS ((struct rtx_def *));
extern struct rtx_def *gen_cmpsi            PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_cmphi            PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_cmpqi            PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_cmpdf            PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_cmpsf            PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_cmpstrsi_1       PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_movdi            PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_movsi            PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_movhi            PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_movqi            PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_movstricthi      PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_movdf            PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_movsf            PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_movstrsi_1       PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_extendhisi2      PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_extendqisi2      PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_extendqihi2      PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_zero_extendhisi2 PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_zero_extendqisi2 PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_zero_extendqihi2 PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_truncsihi2       PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_fix_truncdfsi2   PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_floatsidf2       PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_truncdfsf2       PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_extendsfdf2      PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_addsi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_addhi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_addqi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_adddf3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_addsf3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_subsi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_subhi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_subqi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_subdf3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_subsf3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_muldf3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_mulsf3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_divdf3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_divsf3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_andsi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_andhi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_andqi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_iorsi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_iorhi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_iorqi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_xorsi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_xorhi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_xorqi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_negsi2           PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_neghi2           PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_negdf2           PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_negsf2           PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_abssi2           PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_abshi2           PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_absdf2           PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_abssf2           PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_one_cmplsi2      PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_one_cmplhi2      PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_one_cmplqi2      PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_ashldi3          PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_ashrdi3          PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_ashlsi3          PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_ashrsi3          PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_ashlhi3          PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_ashrhi3          PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_ashlqi3          PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_ashrqi3          PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_lshrdi3          PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_lshrsi3          PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_lshrhi3          PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_lshrqi3          PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_beq              PARAMS ((struct rtx_def *));
extern struct rtx_def *gen_bne              PARAMS ((struct rtx_def *));
extern struct rtx_def *gen_bgt              PARAMS ((struct rtx_def *));
extern struct rtx_def *gen_bgtu             PARAMS ((struct rtx_def *));
extern struct rtx_def *gen_blt              PARAMS ((struct rtx_def *));
extern struct rtx_def *gen_bltu             PARAMS ((struct rtx_def *));
extern struct rtx_def *gen_bge              PARAMS ((struct rtx_def *));
extern struct rtx_def *gen_bgeu             PARAMS ((struct rtx_def *));
extern struct rtx_def *gen_ble              PARAMS ((struct rtx_def *));
extern struct rtx_def *gen_bleu             PARAMS ((struct rtx_def *));
extern struct rtx_def *gen_jump             PARAMS ((struct rtx_def *));
extern struct rtx_def *gen_indirect_jump    PARAMS ((struct rtx_def *));
extern struct rtx_def *gen_tablejump        PARAMS ((struct rtx_def *, struct rtx_def *));
#define GEN_CALL(A, B, C, D) gen_call ((A), (B))
extern struct rtx_def *gen_call             PARAMS ((struct rtx_def *, struct rtx_def *));
#define GEN_CALL_VALUE(A, B, C, D, E) gen_call_value ((A), (B), (C))
extern struct rtx_def *gen_call_value       PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_nop              PARAMS ((void));
extern struct rtx_def *gen_cmpstrsi         PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_clrstrsi         PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_movstrsi         PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_extendsidi2      PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_zero_extendsidi2 PARAMS ((struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_adddi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_mulsi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_divsi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_udivsi3          PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_modsi3           PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_umodsi3          PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));
extern struct rtx_def *gen_untyped_call     PARAMS ((struct rtx_def *, struct rtx_def *, struct rtx_def *));

#endif /* GCC_INSN_FLAGS_H */
