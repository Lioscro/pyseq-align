from .alignment cimport aligner_t, alignment_t
from .alignment_scoring cimport scoring_t

cdef extern from '../seq-align/src/needleman_wunsch.h':
    ctypedef aligner_t nw_aligner_t

    cdef nw_aligner_t* needleman_wunsch_new()
    cdef void needleman_wunsch_free(nw_aligner_t *nw)

    cdef void needleman_wunsch_align(const char *a, const char *b,
                                const scoring_t *scoring,
                                nw_aligner_t *nw, alignment_t *result)
