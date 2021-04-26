from typing import Optional

from cpython.mem cimport PyMem_Malloc, PyMem_Free

from .wrappers.alignment_scoring cimport *

cdef class Scoring:
    def __init__(
        self,
        match: int = 1,
        mismatch: int = -2,
        substitution_matrix: Optional[dict[str, dict[str, int]]] = None,
        gap_open: int = -4,
        gap_extend: int = -1,
        no_start_gap_penalty: bool = False,
        no_end_gap_penalty: bool = False,
        no_gaps_in_a: bool = False,
        no_gaps_in_b: bool = False,
        no_mismatches: bool = False,
        case_sensitive: bool = True,
    ):
        # no_mismatches can not be used with no_gaps_in_a or no_gaps_in_b
        if no_mismatches and (no_gaps_in_a or no_gaps_in_b):
            raise Exception('`no_mismatches` can not be used with `no_gaps_in_a` or `no_gaps_in_b`')

        scoring_init(
            <scoring_t*>(self._pointer), match, mismatch, gap_open, gap_extend,
            no_start_gap_penalty, no_end_gap_penalty, no_gaps_in_a, no_gaps_in_b,
            no_mismatches, case_sensitive
        )

        # If substitution matrix was given, update the scoring using scoring_add_mutation
        if substitution_matrix:
            characters = sorted(substitution_matrix.keys())
            for c1 in substitution_matrix:
                if len(c1) != 1:
                    raise Exception(f'All characters in substitution matrix must be length 1, but found `{c1}`')

                for c2, score in substitution_matrix[c1].items():
                    if len(c2) != 1:
                        raise Exception(f'All characters in substitution matrix must be length 1, but found `{c2}`')

                    scoring_add_mutation(
                        <scoring_t*>(self._pointer),
                        c1.encode('UTF-8')[0],
                        c2.encode('UTF-8')[0],
                        score
                    )

    def __cinit__(self, *args, **kwargs):
        self._pointer = <scoring_t*>PyMem_Malloc(sizeof(scoring_t))
        if not self._pointer:
            raise MemoryError('Failed to allocate memory')

    def __dealloc__(self):
        PyMem_Free(self._pointer)

    @staticmethod
    cdef Scoring from_pointer(scoring_t* scoring):
        obj = <Scoring>Scoring.__new__(Scoring)
        obj._pointer = scoring
        return obj

    @property
    def gap_open(self): return self._pointer.gap_open

    @property
    def gap_extend(self): return self._pointer.gap_extend

    @property
    def no_start_gap_penalty(self): return self._pointer.no_start_gap_penalty

    @property
    def no_end_gap_penalty(self): return self._pointer.no_end_gap_penalty

    @property
    def no_gaps_in_a(self): return self._pointer.no_gaps_in_a

    @property
    def no_gaps_in_b(self): return self._pointer.no_gaps_in_b

    @property
    def no_mismatches(self): return self._pointer.no_mismatches

    @property
    def use_match_mismatch(self): return self._pointer.use_match_mismatch

    @property
    def match(self): return self._pointer.match

    @property
    def mismatch(self): return self._pointer.mismatch

    @property
    def case_sensitive(self): return self._pointer.case_sensitive

    # TODO: fix
    # @property
    # def wildcards(self): return self._pointer.wildcards
    #
    # @property
    # def swap_set(self): return self._pointer.swap_set

    @property
    def wildscores(self): return self._pointer.wildscores

    @property
    def swap_scores(self): return self._pointer.swap_scores

    @property
    def min_penalty(self): return self._pointer.min_penalty

    @property
    def max_penalty(self): return self._pointer.max_penalty
