from libc.stdint cimport uint32_t
from libcpp cimport bool

cdef extern from '../seq-align/src/alignment_scoring.h':
    ctypedef int score_t

    ctypedef struct scoring_t:
        int gap_open
        int gap_extend
        bool no_start_gap_penalty
        bool no_end_gap_penalty
        bool no_gaps_in_a
        bool no_gaps_in_b
        bool no_mismatches
        bool use_match_mismatch
        int match
        int mismatch
        bool case_sensitive
        uint32_t wildcards[256//32]
        uint32_t swap_set[256][256//32]
        score_t wildscores[256]
        score_t swap_scores[256][256]
        int min_penalty
        int max_penalty

    cdef void scoring_init(scoring_t* scoring, int match, int mismatch,
                      int gap_open, int gap_extend,
                      bool no_start_gap_penalty, bool no_end_gap_penalty,
                      bool no_gaps_in_a, bool no_gaps_in_b,
                      bool no_mismatches, bool case_sensitive)

    cdef void scoring_add_wildcard(scoring_t* scoring, char c, int s);
    cdef void scoring_add_mutation(scoring_t* scoring, char a, char b, int score);
    cdef void scoring_print(const scoring_t* scoring);
    cdef void scoring_lookup(const scoring_t* scoring, char a, char b,
                      int *score, bool *is_match);

    cdef void scoring_system_PAM30(scoring_t *scoring);
    cdef void scoring_system_PAM70(scoring_t *scoring);
    cdef void scoring_system_BLOSUM80(scoring_t *scoring);
    cdef void scoring_system_BLOSUM62(scoring_t *scoring);
    cdef void scoring_system_DNA_hybridization(scoring_t *scoring);
    cdef void scoring_system_default(scoring_t *scoring);
