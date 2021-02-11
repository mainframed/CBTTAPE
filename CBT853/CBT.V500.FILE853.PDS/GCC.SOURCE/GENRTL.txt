/* Generated automatically by gengenrtl from rtl.def.  */

#include "config.h"
#include "system.h"
#include "coretypes.h"
#include "tm.h"
#include "obstack.h"
#include "rtl.h"
#include "ggc.h"

rtx
gen_rtx_fmt_s (RTX_CODE code, enum machine_mode mode,
	const char *arg0)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XSTR (rt, 0) = arg0;

  return rt;
}

rtx
gen_rtx_fmt_ee (RTX_CODE code, enum machine_mode mode,
	rtx arg0,
	rtx arg1)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XEXP (rt, 0) = arg0;
  XEXP (rt, 1) = arg1;

  return rt;
}

rtx
gen_rtx_fmt_ue (RTX_CODE code, enum machine_mode mode,
	rtx arg0,
	rtx arg1)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XEXP (rt, 0) = arg0;
  XEXP (rt, 1) = arg1;

  return rt;
}

rtx
gen_rtx_fmt_iss (RTX_CODE code, enum machine_mode mode,
	int arg0,
	const char *arg1,
	const char *arg2)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XINT (rt, 0) = arg0;
  XSTR (rt, 1) = arg1;
  XSTR (rt, 2) = arg2;

  return rt;
}

rtx
gen_rtx_fmt_is (RTX_CODE code, enum machine_mode mode,
	int arg0,
	const char *arg1)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XINT (rt, 0) = arg0;
  XSTR (rt, 1) = arg1;

  return rt;
}

rtx
gen_rtx_fmt_i (RTX_CODE code, enum machine_mode mode,
	int arg0)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XINT (rt, 0) = arg0;

  return rt;
}

rtx
gen_rtx_fmt_isE (RTX_CODE code, enum machine_mode mode,
	int arg0,
	const char *arg1,
	rtvec arg2)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XINT (rt, 0) = arg0;
  XSTR (rt, 1) = arg1;
  XVEC (rt, 2) = arg2;

  return rt;
}

rtx
gen_rtx_fmt_iE (RTX_CODE code, enum machine_mode mode,
	int arg0,
	rtvec arg1)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XINT (rt, 0) = arg0;
  XVEC (rt, 1) = arg1;

  return rt;
}

rtx
gen_rtx_fmt_Ess (RTX_CODE code, enum machine_mode mode,
	rtvec arg0,
	const char *arg1,
	const char *arg2)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XVEC (rt, 0) = arg0;
  XSTR (rt, 1) = arg1;
  XSTR (rt, 2) = arg2;

  return rt;
}

rtx
gen_rtx_fmt_sEss (RTX_CODE code, enum machine_mode mode,
	const char *arg0,
	rtvec arg1,
	const char *arg2,
	const char *arg3)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XSTR (rt, 0) = arg0;
  XVEC (rt, 1) = arg1;
  XSTR (rt, 2) = arg2;
  XSTR (rt, 3) = arg3;

  return rt;
}

rtx
gen_rtx_fmt_eE (RTX_CODE code, enum machine_mode mode,
	rtx arg0,
	rtvec arg1)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XEXP (rt, 0) = arg0;
  XVEC (rt, 1) = arg1;

  return rt;
}

rtx
gen_rtx_fmt_E (RTX_CODE code, enum machine_mode mode,
	rtvec arg0)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XVEC (rt, 0) = arg0;

  return rt;
}

rtx
gen_rtx_fmt_e (RTX_CODE code, enum machine_mode mode,
	rtx arg0)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XEXP (rt, 0) = arg0;

  return rt;
}

rtx
gen_rtx_fmt_ss (RTX_CODE code, enum machine_mode mode,
	const char *arg0,
	const char *arg1)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XSTR (rt, 0) = arg0;
  XSTR (rt, 1) = arg1;

  return rt;
}

rtx
gen_rtx_fmt_sies (RTX_CODE code, enum machine_mode mode,
	const char *arg0,
	int arg1,
	rtx arg2,
	const char *arg3)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XSTR (rt, 0) = arg0;
  XINT (rt, 1) = arg1;
  XEXP (rt, 2) = arg2;
  XSTR (rt, 3) = arg3;

  return rt;
}

rtx
gen_rtx_fmt_sse (RTX_CODE code, enum machine_mode mode,
	const char *arg0,
	const char *arg1,
	rtx arg2)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XSTR (rt, 0) = arg0;
  XSTR (rt, 1) = arg1;
  XEXP (rt, 2) = arg2;

  return rt;
}

rtx
gen_rtx_fmt_sE (RTX_CODE code, enum machine_mode mode,
	const char *arg0,
	rtvec arg1)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XSTR (rt, 0) = arg0;
  XVEC (rt, 1) = arg1;

  return rt;
}

rtx
gen_rtx_fmt_ii (RTX_CODE code, enum machine_mode mode,
	int arg0,
	int arg1)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XINT (rt, 0) = arg0;
  XINT (rt, 1) = arg1;

  return rt;
}

rtx
gen_rtx_fmt_iuuBieiee (RTX_CODE code, enum machine_mode mode,
	int arg0,
	rtx arg1,
	rtx arg2,
	struct basic_block_def *arg3,
	int arg4,
	rtx arg5,
	int arg6,
	rtx arg7,
	rtx arg8)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XINT (rt, 0) = arg0;
  XEXP (rt, 1) = arg1;
  XEXP (rt, 2) = arg2;
  XBBDEF (rt, 3) = arg3;
  XINT (rt, 4) = arg4;
  XEXP (rt, 5) = arg5;
  XINT (rt, 6) = arg6;
  XEXP (rt, 7) = arg7;
  XEXP (rt, 8) = arg8;

  return rt;
}

rtx
gen_rtx_fmt_iuuBieiee0 (RTX_CODE code, enum machine_mode mode,
	int arg0,
	rtx arg1,
	rtx arg2,
	struct basic_block_def *arg3,
	int arg4,
	rtx arg5,
	int arg6,
	rtx arg7,
	rtx arg8)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XINT (rt, 0) = arg0;
  XEXP (rt, 1) = arg1;
  XEXP (rt, 2) = arg2;
  XBBDEF (rt, 3) = arg3;
  XINT (rt, 4) = arg4;
  XEXP (rt, 5) = arg5;
  XINT (rt, 6) = arg6;
  XEXP (rt, 7) = arg7;
  XEXP (rt, 8) = arg8;
  X0EXP (rt, 9) = NULL_RTX;

  return rt;
}

rtx
gen_rtx_fmt_iuuBieieee (RTX_CODE code, enum machine_mode mode,
	int arg0,
	rtx arg1,
	rtx arg2,
	struct basic_block_def *arg3,
	int arg4,
	rtx arg5,
	int arg6,
	rtx arg7,
	rtx arg8,
	rtx arg9)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XINT (rt, 0) = arg0;
  XEXP (rt, 1) = arg1;
  XEXP (rt, 2) = arg2;
  XBBDEF (rt, 3) = arg3;
  XINT (rt, 4) = arg4;
  XEXP (rt, 5) = arg5;
  XINT (rt, 6) = arg6;
  XEXP (rt, 7) = arg7;
  XEXP (rt, 8) = arg8;
  XEXP (rt, 9) = arg9;

  return rt;
}

rtx
gen_rtx_fmt_iuu000000 (RTX_CODE code, enum machine_mode mode,
	int arg0,
	rtx arg1,
	rtx arg2)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XINT (rt, 0) = arg0;
  XEXP (rt, 1) = arg1;
  XEXP (rt, 2) = arg2;
  X0EXP (rt, 3) = NULL_RTX;
  X0EXP (rt, 4) = NULL_RTX;
  X0EXP (rt, 5) = NULL_RTX;
  X0EXP (rt, 6) = NULL_RTX;
  X0EXP (rt, 7) = NULL_RTX;
  X0EXP (rt, 8) = NULL_RTX;

  return rt;
}

rtx
gen_rtx_fmt_iuuB00is (RTX_CODE code, enum machine_mode mode,
	int arg0,
	rtx arg1,
	rtx arg2,
	struct basic_block_def *arg3,
	int arg4,
	const char *arg5)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XINT (rt, 0) = arg0;
  XEXP (rt, 1) = arg1;
  XEXP (rt, 2) = arg2;
  XBBDEF (rt, 3) = arg3;
  X0EXP (rt, 4) = NULL_RTX;
  X0EXP (rt, 5) = NULL_RTX;
  XINT (rt, 6) = arg4;
  XSTR (rt, 7) = arg5;

  return rt;
}

rtx
gen_rtx_fmt_ssiEEsi (RTX_CODE code, enum machine_mode mode,
	const char *arg0,
	const char *arg1,
	int arg2,
	rtvec arg3,
	rtvec arg4,
	const char *arg5,
	int arg6)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XSTR (rt, 0) = arg0;
  XSTR (rt, 1) = arg1;
  XINT (rt, 2) = arg2;
  XVEC (rt, 3) = arg3;
  XVEC (rt, 4) = arg4;
  XSTR (rt, 5) = arg5;
  XINT (rt, 6) = arg6;

  return rt;
}

rtx
gen_rtx_fmt_Ei (RTX_CODE code, enum machine_mode mode,
	rtvec arg0,
	int arg1)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XVEC (rt, 0) = arg0;
  XINT (rt, 1) = arg1;

  return rt;
}

rtx
gen_rtx_fmt_eEee0 (RTX_CODE code, enum machine_mode mode,
	rtx arg0,
	rtvec arg1,
	rtx arg2,
	rtx arg3)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XEXP (rt, 0) = arg0;
  XVEC (rt, 1) = arg1;
  XEXP (rt, 2) = arg2;
  XEXP (rt, 3) = arg3;
  X0EXP (rt, 4) = NULL_RTX;

  return rt;
}

rtx
gen_rtx_fmt_eee (RTX_CODE code, enum machine_mode mode,
	rtx arg0,
	rtx arg1,
	rtx arg2)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XEXP (rt, 0) = arg0;
  XEXP (rt, 1) = arg1;
  XEXP (rt, 2) = arg2;

  return rt;
}

rtx
gen_rtx_fmt_ (RTX_CODE code, enum machine_mode mode)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);

  return rt;
}

rtx
gen_rtx_fmt_w (RTX_CODE code, enum machine_mode mode,
	HOST_WIDE_INT arg0)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XWINT (rt, 0) = arg0;

  return rt;
}

rtx
gen_rtx_fmt_0 (RTX_CODE code, enum machine_mode mode)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  X0EXP (rt, 0) = NULL_RTX;

  return rt;
}

rtx
gen_rtx_fmt_i00 (RTX_CODE code, enum machine_mode mode,
	int arg0)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XINT (rt, 0) = arg0;
  X0EXP (rt, 1) = NULL_RTX;
  X0EXP (rt, 2) = NULL_RTX;

  return rt;
}

rtx
gen_rtx_fmt_ei (RTX_CODE code, enum machine_mode mode,
	rtx arg0,
	int arg1)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XEXP (rt, 0) = arg0;
  XINT (rt, 1) = arg1;

  return rt;
}

rtx
gen_rtx_fmt_e0 (RTX_CODE code, enum machine_mode mode,
	rtx arg0)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XEXP (rt, 0) = arg0;
  X0EXP (rt, 1) = NULL_RTX;

  return rt;
}

rtx
gen_rtx_fmt_u00 (RTX_CODE code, enum machine_mode mode,
	rtx arg0)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XEXP (rt, 0) = arg0;
  X0EXP (rt, 1) = NULL_RTX;
  X0EXP (rt, 2) = NULL_RTX;

  return rt;
}

rtx
gen_rtx_fmt_s00 (RTX_CODE code, enum machine_mode mode,
	const char *arg0)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XSTR (rt, 0) = arg0;
  X0EXP (rt, 1) = NULL_RTX;
  X0EXP (rt, 2) = NULL_RTX;

  return rt;
}

rtx
gen_rtx_fmt_eit (RTX_CODE code, enum machine_mode mode,
	rtx arg0,
	int arg1,
	union tree_node *arg2)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XEXP (rt, 0) = arg0;
  XINT (rt, 1) = arg1;
  XTREE (rt, 2) = arg2;

  return rt;
}

rtx
gen_rtx_fmt_eeeee (RTX_CODE code, enum machine_mode mode,
	rtx arg0,
	rtx arg1,
	rtx arg2,
	rtx arg3,
	rtx arg4)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XEXP (rt, 0) = arg0;
  XEXP (rt, 1) = arg1;
  XEXP (rt, 2) = arg2;
  XEXP (rt, 3) = arg3;
  XEXP (rt, 4) = arg4;

  return rt;
}

rtx
gen_rtx_fmt_Ee (RTX_CODE code, enum machine_mode mode,
	rtvec arg0,
	rtx arg1)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XVEC (rt, 0) = arg0;
  XEXP (rt, 1) = arg1;

  return rt;
}

rtx
gen_rtx_fmt_uuEiiiiiibbii (RTX_CODE code, enum machine_mode mode,
	rtx arg0,
	rtx arg1,
	rtvec arg2,
	int arg3,
	int arg4,
	int arg5,
	int arg6,
	int arg7,
	int arg8,
	struct bitmap_head_def *arg9,
	struct bitmap_head_def *arg10,
	int arg11,
	int arg12)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XEXP (rt, 0) = arg0;
  XEXP (rt, 1) = arg1;
  XVEC (rt, 2) = arg2;
  XINT (rt, 3) = arg3;
  XINT (rt, 4) = arg4;
  XINT (rt, 5) = arg5;
  XINT (rt, 6) = arg6;
  XINT (rt, 7) = arg7;
  XINT (rt, 8) = arg8;
  XBITMAP (rt, 9) = arg9;
  XBITMAP (rt, 10) = arg10;
  XINT (rt, 11) = arg11;
  XINT (rt, 12) = arg12;

  return rt;
}

rtx
gen_rtx_fmt_iiiiiiiitt (RTX_CODE code, enum machine_mode mode,
	int arg0,
	int arg1,
	int arg2,
	int arg3,
	int arg4,
	int arg5,
	int arg6,
	int arg7,
	union tree_node *arg8,
	union tree_node *arg9)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XINT (rt, 0) = arg0;
  XINT (rt, 1) = arg1;
  XINT (rt, 2) = arg2;
  XINT (rt, 3) = arg3;
  XINT (rt, 4) = arg4;
  XINT (rt, 5) = arg5;
  XINT (rt, 6) = arg6;
  XINT (rt, 7) = arg7;
  XTREE (rt, 8) = arg8;
  XTREE (rt, 9) = arg9;

  return rt;
}

rtx
gen_rtx_fmt_eti (RTX_CODE code, enum machine_mode mode,
	rtx arg0,
	union tree_node *arg1,
	int arg2)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XEXP (rt, 0) = arg0;
  XTREE (rt, 1) = arg1;
  XINT (rt, 2) = arg2;

  return rt;
}

rtx
gen_rtx_fmt_bi (RTX_CODE code, enum machine_mode mode,
	struct bitmap_head_def *arg0,
	int arg1)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XBITMAP (rt, 0) = arg0;
  XINT (rt, 1) = arg1;

  return rt;
}

rtx
gen_rtx_fmt_uuuu (RTX_CODE code, enum machine_mode mode,
	rtx arg0,
	rtx arg1,
	rtx arg2,
	rtx arg3)
{
  rtx rt;
  rt = ggc_alloc_rtx (code);

  memset (rt, 0, RTX_HDR_SIZE);

  PUT_CODE (rt, code);
  PUT_MODE (rt, mode);
  XEXP (rt, 0) = arg0;
  XEXP (rt, 1) = arg1;
  XEXP (rt, 2) = arg2;
  XEXP (rt, 3) = arg3;

  return rt;
}

