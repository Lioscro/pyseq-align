from libc.stdint cimport uint32_t

from .alignment cimport aligner_t, alignment_t
from .alignment_scoring cimport scoring_t

cdef extern from '../seq-align/src/smith_waterman.h':
    ctypedef struct BitSet:
        uint32_t *b
        size_t l
        size_t s

    ctypedef struct sw_history_t:
        BitSet match_scores_mask
        size_t *sorted_match_indices
        size_t hits_capacity
        size_t num_of_hits
        size_t next_hit

    ctypedef struct sw_aligner_t:
        aligner_t aligner
        sw_history_t history

    cdef sw_aligner_t *smith_waterman_new()
    cdef void smith_waterman_free(sw_aligner_t *sw_aligner)

    cdef void smith_waterman_align(const char *seq_a, const char *seq_b,
                              const scoring_t *scoring, sw_aligner_t *sw)
    cdef int smith_waterman_fetch(sw_aligner_t *sw, alignment_t *result);
