/* Type information for stmt.c.
   Copyright (C) 2003 Free Software Foundation, Inc.

This file is part of GCC.

GCC is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2, or (at your option) any later
version.

GCC is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

You should have received a copy of the GNU General Public License
along with GCC; see the file COPYING.  If not, write to the Free
Software Foundation, 59 Temple Place - Suite 330, Boston, MA
02111-1307, USA.  */

/* This file is machine generated.  Do not edit.  */

void
gt_ggc_mx_goto_fixup (void *x_p)
{
  struct goto_fixup * const x = (struct goto_fixup *)x_p;
  if (ggc_test_and_set_mark (x))
    {
      gt_ggc_m_10goto_fixup ((*x).next);
      gt_ggc_m_7rtx_def ((*x).before_jump);
      gt_ggc_m_9tree_node ((*x).target);
      gt_ggc_m_9tree_node ((*x).context);
      gt_ggc_m_7rtx_def ((*x).target_rtl);
      gt_ggc_m_7rtx_def ((*x).stack_level);
      gt_ggc_m_9tree_node ((*x).cleanup_list_list);
    }
}

void
gt_ggc_mx_label_chain (void *x_p)
{
  struct label_chain * const x = (struct label_chain *)x_p;
  if (ggc_test_and_set_mark (x))
    {
      gt_ggc_m_11label_chain ((*x).next);
      gt_ggc_m_9tree_node ((*x).label);
    }
}

void
gt_ggc_mx_nesting (void *x_p)
{
  struct nesting * const x = (struct nesting *)x_p;
  if (ggc_test_and_set_mark (x))
    {
      gt_ggc_m_7nesting ((*x).all);
      gt_ggc_m_7nesting ((*x).next);
      gt_ggc_m_7rtx_def ((*x).exit_label);
      switch (((*x)).desc)
        {
        case COND_NESTING:
          gt_ggc_m_7rtx_def ((*x).data.cond.endif_label);
          gt_ggc_m_7rtx_def ((*x).data.cond.next_label);
          break;
        case LOOP_NESTING:
          gt_ggc_m_7rtx_def ((*x).data.loop.start_label);
          gt_ggc_m_7rtx_def ((*x).data.loop.end_label);
          gt_ggc_m_7rtx_def ((*x).data.loop.continue_label);
          break;
        case BLOCK_NESTING:
          gt_ggc_m_7rtx_def ((*x).data.block.stack_level);
          gt_ggc_m_7rtx_def ((*x).data.block.first_insn);
          gt_ggc_m_7nesting ((*x).data.block.innermost_stack_block);
          gt_ggc_m_9tree_node ((*x).data.block.cleanups);
          gt_ggc_m_9tree_node ((*x).data.block.outer_cleanups);
          gt_ggc_m_11label_chain ((*x).data.block.label_chain);
          gt_ggc_m_7rtx_def ((*x).data.block.last_unconditional_cleanup);
          break;
        case CASE_NESTING:
          gt_ggc_m_7rtx_def ((*x).data.case_stmt.start);
          gt_ggc_m_9case_node ((*x).data.case_stmt.case_list);
          gt_ggc_m_9tree_node ((*x).data.case_stmt.default_label);
          gt_ggc_m_9tree_node ((*x).data.case_stmt.index_expr);
          gt_ggc_m_9tree_node ((*x).data.case_stmt.nominal_type);
          break;
        default:
          break;
        }
    }
}

void
gt_ggc_mx_case_node (void *x_p)
{
  struct case_node * const x = (struct case_node *)x_p;
  if (ggc_test_and_set_mark (x))
    {
      gt_ggc_m_9case_node ((*x).left);
      gt_ggc_m_9case_node ((*x).right);
      gt_ggc_m_9case_node ((*x).parent);
      gt_ggc_m_9tree_node ((*x).low);
      gt_ggc_m_9tree_node ((*x).high);
      gt_ggc_m_9tree_node ((*x).code_label);
    }
}

void
gt_ggc_mx_stmt_status (void *x_p)
{
  struct stmt_status * const x = (struct stmt_status *)x_p;
  if (ggc_test_and_set_mark (x))
    {
      gt_ggc_m_7nesting ((*x).x_block_stack);
      gt_ggc_m_7nesting ((*x).x_stack_block_stack);
      gt_ggc_m_7nesting ((*x).x_cond_stack);
      gt_ggc_m_7nesting ((*x).x_loop_stack);
      gt_ggc_m_7nesting ((*x).x_case_stack);
      gt_ggc_m_7nesting ((*x).x_nesting_stack);
      gt_ggc_m_9tree_node ((*x).x_last_expr_type);
      gt_ggc_m_7rtx_def ((*x).x_last_expr_value);
      gt_ggc_m_7rtx_def ((*x).x_last_expr_alt_rtl);
      gt_ggc_m_10goto_fixup ((*x).x_goto_fixup_chain);
    }
}

void
gt_pch_nx_goto_fixup (void *x_p)
{
  struct goto_fixup * const x = (struct goto_fixup *)x_p;
  if (gt_pch_note_object (x, x, gt_pch_p_10goto_fixup))
    {
      gt_pch_n_10goto_fixup ((*x).next);
      gt_pch_n_7rtx_def ((*x).before_jump);
      gt_pch_n_9tree_node ((*x).target);
      gt_pch_n_9tree_node ((*x).context);
      gt_pch_n_7rtx_def ((*x).target_rtl);
      gt_pch_n_7rtx_def ((*x).stack_level);
      gt_pch_n_9tree_node ((*x).cleanup_list_list);
    }
}

void
gt_pch_nx_label_chain (void *x_p)
{
  struct label_chain * const x = (struct label_chain *)x_p;
  if (gt_pch_note_object (x, x, gt_pch_p_11label_chain))
    {
      gt_pch_n_11label_chain ((*x).next);
      gt_pch_n_9tree_node ((*x).label);
    }
}

void
gt_pch_nx_nesting (void *x_p)
{
  struct nesting * const x = (struct nesting *)x_p;
  if (gt_pch_note_object (x, x, gt_pch_p_7nesting))
    {
      gt_pch_n_7nesting ((*x).all);
      gt_pch_n_7nesting ((*x).next);
      gt_pch_n_7rtx_def ((*x).exit_label);
      switch (((*x)).desc)
        {
        case COND_NESTING:
          gt_pch_n_7rtx_def ((*x).data.cond.endif_label);
          gt_pch_n_7rtx_def ((*x).data.cond.next_label);
          break;
        case LOOP_NESTING:
          gt_pch_n_7rtx_def ((*x).data.loop.start_label);
          gt_pch_n_7rtx_def ((*x).data.loop.end_label);
          gt_pch_n_7rtx_def ((*x).data.loop.continue_label);
          break;
        case BLOCK_NESTING:
          gt_pch_n_7rtx_def ((*x).data.block.stack_level);
          gt_pch_n_7rtx_def ((*x).data.block.first_insn);
          gt_pch_n_7nesting ((*x).data.block.innermost_stack_block);
          gt_pch_n_9tree_node ((*x).data.block.cleanups);
          gt_pch_n_9tree_node ((*x).data.block.outer_cleanups);
          gt_pch_n_11label_chain ((*x).data.block.label_chain);
          gt_pch_n_7rtx_def ((*x).data.block.last_unconditional_cleanup);
          break;
        case CASE_NESTING:
          gt_pch_n_7rtx_def ((*x).data.case_stmt.start);
          gt_pch_n_9case_node ((*x).data.case_stmt.case_list);
          gt_pch_n_9tree_node ((*x).data.case_stmt.default_label);
          gt_pch_n_9tree_node ((*x).data.case_stmt.index_expr);
          gt_pch_n_9tree_node ((*x).data.case_stmt.nominal_type);
          gt_pch_n_S ((*x).data.case_stmt.printname);
          break;
        default:
          break;
        }
    }
}

void
gt_pch_nx_case_node (void *x_p)
{
  struct case_node * const x = (struct case_node *)x_p;
  if (gt_pch_note_object (x, x, gt_pch_p_9case_node))
    {
      gt_pch_n_9case_node ((*x).left);
      gt_pch_n_9case_node ((*x).right);
      gt_pch_n_9case_node ((*x).parent);
      gt_pch_n_9tree_node ((*x).low);
      gt_pch_n_9tree_node ((*x).high);
      gt_pch_n_9tree_node ((*x).code_label);
    }
}

void
gt_pch_nx_stmt_status (void *x_p)
{
  struct stmt_status * const x = (struct stmt_status *)x_p;
  if (gt_pch_note_object (x, x, gt_pch_p_11stmt_status))
    {
      gt_pch_n_7nesting ((*x).x_block_stack);
      gt_pch_n_7nesting ((*x).x_stack_block_stack);
      gt_pch_n_7nesting ((*x).x_cond_stack);
      gt_pch_n_7nesting ((*x).x_loop_stack);
      gt_pch_n_7nesting ((*x).x_case_stack);
      gt_pch_n_7nesting ((*x).x_nesting_stack);
      gt_pch_n_9tree_node ((*x).x_last_expr_type);
      gt_pch_n_7rtx_def ((*x).x_last_expr_value);
      gt_pch_n_7rtx_def ((*x).x_last_expr_alt_rtl);
      gt_pch_n_S ((*x).x_emit_locus.file);
      gt_pch_n_10goto_fixup ((*x).x_goto_fixup_chain);
    }
}

void
gt_pch_p_10goto_fixup (void *this_obj ATTRIBUTE_UNUSED,
	void *x_p,
	gt_pointer_operator op ATTRIBUTE_UNUSED,
	void *cookie ATTRIBUTE_UNUSED)
{
  struct goto_fixup * const x ATTRIBUTE_UNUSED = (struct goto_fixup *)x_p;
  if ((void *)(x) == this_obj)
    op (&((*x).next), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).before_jump), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).target), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).context), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).target_rtl), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).stack_level), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).cleanup_list_list), cookie);
}

void
gt_pch_p_11label_chain (void *this_obj ATTRIBUTE_UNUSED,
	void *x_p,
	gt_pointer_operator op ATTRIBUTE_UNUSED,
	void *cookie ATTRIBUTE_UNUSED)
{
  struct label_chain * const x ATTRIBUTE_UNUSED = (struct label_chain *)x_p;
  if ((void *)(x) == this_obj)
    op (&((*x).next), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).label), cookie);
}

void
gt_pch_p_7nesting (void *this_obj ATTRIBUTE_UNUSED,
	void *x_p,
	gt_pointer_operator op ATTRIBUTE_UNUSED,
	void *cookie ATTRIBUTE_UNUSED)
{
  struct nesting * const x ATTRIBUTE_UNUSED = (struct nesting *)x_p;
  if ((void *)(x) == this_obj)
    op (&((*x).all), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).next), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).exit_label), cookie);
  switch (((*x)).desc)
    {
    case COND_NESTING:
      if ((void *)(x) == this_obj)
        op (&((*x).data.cond.endif_label), cookie);
      if ((void *)(x) == this_obj)
        op (&((*x).data.cond.next_label), cookie);
      break;
    case LOOP_NESTING:
      if ((void *)(x) == this_obj)
        op (&((*x).data.loop.start_label), cookie);
      if ((void *)(x) == this_obj)
        op (&((*x).data.loop.end_label), cookie);
      if ((void *)(x) == this_obj)
        op (&((*x).data.loop.continue_label), cookie);
      break;
    case BLOCK_NESTING:
      if ((void *)(x) == this_obj)
        op (&((*x).data.block.stack_level), cookie);
      if ((void *)(x) == this_obj)
        op (&((*x).data.block.first_insn), cookie);
      if ((void *)(x) == this_obj)
        op (&((*x).data.block.innermost_stack_block), cookie);
      if ((void *)(x) == this_obj)
        op (&((*x).data.block.cleanups), cookie);
      if ((void *)(x) == this_obj)
        op (&((*x).data.block.outer_cleanups), cookie);
      if ((void *)(x) == this_obj)
        op (&((*x).data.block.label_chain), cookie);
      if ((void *)(x) == this_obj)
        op (&((*x).data.block.last_unconditional_cleanup), cookie);
      break;
    case CASE_NESTING:
      if ((void *)(x) == this_obj)
        op (&((*x).data.case_stmt.start), cookie);
      if ((void *)(x) == this_obj)
        op (&((*x).data.case_stmt.case_list), cookie);
      if ((void *)(x) == this_obj)
        op (&((*x).data.case_stmt.default_label), cookie);
      if ((void *)(x) == this_obj)
        op (&((*x).data.case_stmt.index_expr), cookie);
      if ((void *)(x) == this_obj)
        op (&((*x).data.case_stmt.nominal_type), cookie);
      if ((void *)(x) == this_obj)
        op (&((*x).data.case_stmt.printname), cookie);
      break;
    default:
      break;
    }
}

void
gt_pch_p_9case_node (void *this_obj ATTRIBUTE_UNUSED,
	void *x_p,
	gt_pointer_operator op ATTRIBUTE_UNUSED,
	void *cookie ATTRIBUTE_UNUSED)
{
  struct case_node * const x ATTRIBUTE_UNUSED = (struct case_node *)x_p;
  if ((void *)(x) == this_obj)
    op (&((*x).left), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).right), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).parent), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).low), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).high), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).code_label), cookie);
}

void
gt_pch_p_11stmt_status (void *this_obj ATTRIBUTE_UNUSED,
	void *x_p,
	gt_pointer_operator op ATTRIBUTE_UNUSED,
	void *cookie ATTRIBUTE_UNUSED)
{
  struct stmt_status * const x ATTRIBUTE_UNUSED = (struct stmt_status *)x_p;
  if ((void *)(x) == this_obj)
    op (&((*x).x_block_stack), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).x_stack_block_stack), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).x_cond_stack), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).x_loop_stack), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).x_case_stack), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).x_nesting_stack), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).x_last_expr_type), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).x_last_expr_value), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).x_last_expr_alt_rtl), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).x_emit_locus.file), cookie);
  if ((void *)(x) == this_obj)
    op (&((*x).x_goto_fixup_chain), cookie);
}
