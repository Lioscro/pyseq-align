from typing import Optional

from .alignment cimport Alignment
from .scoring cimport Scoring
from .wrappers.smith_waterman cimport *


cdef class SmithWaterman:
    """Python interface for the Smith-Waterman local alignment implementation.

    Arguments
    ---------
    match : int, default: 1
        match score
    mismatch : int, default: -2
        mismatch score
    substitution_matrix : dict, optional
        nested dictionary containing substitution scores. `match` and `mismatch`
        options are ignored if this is provided.
    gap_open : int, default: -4
        gap open score
    gap_extend : int, default: -1
        gap extend score
    no_start_gap_penalty : bool, default: False
        set this to `True` to remove gap penalties at the start of the alignment
    no_end_gap_penalty : bool, default: False
        set this to `True` to remove gap penalties at the end of the alignment
    no_gaps_in_a : bool, default: False
        disallow gaps in the first sequence
    no_gaps_in_b : bool, default: False
        disallow gaps in the second sequence
    no_mismatches : bool, default: False
        disallow mismatches. can not be used together with neither `no_gaps_in_a`
        nor `no_gaps_in_b`
    case_sensitive : bool, default: True
        characters are case-sensitive
    """
    cdef sw_aligner_t* _pointer
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
        self._pointer = smith_waterman_new()
        if not self._pointer:
            raise MemoryError('Failed to allocate memory')

    def __dealloc__(self):
        smith_waterman_free(self._pointer)

    def align(self, str a, str b):
        """Align two sequences.

        Arguments
        ---------
        a : str
            first sequence
        b : str
            second sequence

        Returns
        -------
        results : list of Alignment objects
            list of alignments
        """
        a_bytes = a.encode('UTF-8')
        b_bytes = b.encode('UTF-8')
        cdef char* a_chars = a_bytes
        cdef char* b_chars = b_bytes
        cdef scoring_t* scoring = self.scoring._pointer
        cdef sw_aligner_t* sw = self._pointer
        cdef Alignment result
        smith_waterman_align(a_chars, b_chars, scoring, sw)

        results = []
        while True:
            result = Alignment(len(a) + len(b))
            if smith_waterman_fetch(sw, result._pointer) == 0:
                break
            results.append(result)
        return results
