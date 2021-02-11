/* Generated automatically from machmode.def
   by genmodes.  */

#ifndef GCC_INSN_MODES_H
#define GCC_INSN_MODES_H

enum machine_mode
{
  VOIDmode,                /* machmode.def:146 */
  BLKmode,                 /* machmode.def:150 */
  CCmode,                  /* machmode.def:178 */
  BImode,                  /* machmode.def:153 */
  QImode,                  /* machmode.def:158 */
  HImode,                  /* machmode.def:159 */
  SImode,                  /* machmode.def:160 */
  DImode,                  /* machmode.def:161 */
  TImode,                  /* machmode.def:162 */
  SFmode,                  /* machmode.def:173 */
  DFmode,                  /* machmode.def:174 */
  CQImode,                 /* machmode.def:186 */
  CHImode,                 /* machmode.def:186 */
  CSImode,                 /* machmode.def:186 */
  CDImode,                 /* machmode.def:186 */
  CTImode,                 /* machmode.def:186 */
  SCmode,                  /* machmode.def:187 */
  DCmode,                  /* machmode.def:187 */
  V2QImode,                /* machmode.def:190 */
  V4QImode,                /* machmode.def:191 */
  V2HImode,                /* machmode.def:191 */
  V8QImode,                /* machmode.def:192 */
  V4HImode,                /* machmode.def:192 */
  V2SImode,                /* machmode.def:192 */
  V1DImode,                /* machmode.def:206 */
  V16QImode,               /* machmode.def:193 */
  V8HImode,                /* machmode.def:193 */
  V4SImode,                /* machmode.def:193 */
  V2DImode,                /* machmode.def:193 */
  V8SImode,                /* machmode.def:197 */
  V4DImode,                /* machmode.def:198 */
  V8DImode,                /* machmode.def:199 */
  V2SFmode,                /* machmode.def:209 */
  V4SFmode,                /* machmode.def:210 */
  V2DFmode,                /* machmode.def:210 */
  V8SFmode,                /* machmode.def:214 */
  V4DFmode,                /* machmode.def:216 */
  V16SFmode,               /* machmode.def:215 */
  V8DFmode,                /* machmode.def:217 */
  MAX_MACHINE_MODE,

  MIN_MODE_RANDOM = VOIDmode,
  MAX_MODE_RANDOM = BLKmode,

  MIN_MODE_CC = CCmode,
  MAX_MODE_CC = CCmode,

  MIN_MODE_INT = QImode,
  MAX_MODE_INT = TImode,

  MIN_MODE_PARTIAL_INT = VOIDmode,
  MAX_MODE_PARTIAL_INT = VOIDmode,

  MIN_MODE_FLOAT = SFmode,
  MAX_MODE_FLOAT = DFmode,

  MIN_MODE_COMPLEX_INT = CQImode,
  MAX_MODE_COMPLEX_INT = CTImode,

  MIN_MODE_COMPLEX_FLOAT = SCmode,
  MAX_MODE_COMPLEX_FLOAT = DCmode,

  MIN_MODE_VECTOR_INT = V2QImode,
  MAX_MODE_VECTOR_INT = V8DImode,

  MIN_MODE_VECTOR_FLOAT = V2SFmode,
  MAX_MODE_VECTOR_FLOAT = V8DFmode,

  NUM_MACHINE_MODES = MAX_MACHINE_MODE
};

#define CONST_MODE_SIZE const
#define CONST_MODE_BASE_ALIGN const

#endif /* insn-modes.h */
