from .alignment_scoring cimport scoring_t

cdef extern from '../seq-align/src/alignment.h':
    ctypedef int score_t

    ctypedef struct aligner_t:
        const scoring_t scoring
        const char* seq_a
        const char* seq_b
        size_t score_width
        size_t score_height
        score_t* match_scores
        score_t* gap_a_scores
        score_t* gap_b_scores
        size_t capacity

    ctypedef struct alignment_t:
        char* result_a
        char* result_b
        size_t capacity
        size_t length
        size_t pos_a
        size_t pos_b
        size_t len_a
        size_t len_b
        score_t score

    cdef alignment_t* alignment_create(size_t capacity)
    cdef void alignment_free(alignment_t* result)
