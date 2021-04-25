from typing import Optional

from .alignment cimport Alignment
from .scoring cimport Scoring
from .wrappers.needleman_wunsch cimport *


cdef class NeedlemanWunsch:
    cdef nw_aligner_t* _pointer
    cdef public Scoring scoring

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
        self.scoring = Scoring(
            match, mismatch, substitution_matrix, gap_open, gap_extend,
            no_start_gap_penalty, no_end_gap_penalty, no_gaps_in_a, no_gaps_in_b,
            no_mismatches, case_sensitive
        )

    def __cinit__(self, *args, **kwargs):
        self._pointer = needleman_wunsch_new()
        if not self._pointer:
            raise MemoryError('Failed to allocate memory')

    def __dealloc__(self):
        needleman_wunsch_free(self._pointer)

    def align(self, str a, str b):
        a_bytes = a.encode('UTF-8')
        b_bytes = b.encode('UTF-8')
        cdef char* a_chars = a_bytes
        cdef char* b_chars = b_bytes
        cdef scoring_t* scoring = self.scoring._pointer
        cdef nw_aligner_t* nw = self._pointer
        cdef Alignment result = Alignment(len(a) + len(b))
        needleman_wunsch_align(a_chars, b_chars, scoring, nw, result._pointer)
        return result
