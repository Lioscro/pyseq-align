from .wrappers.alignment_scoring cimport *

cdef class Scoring:
    cdef scoring_t* _pointer

    @staticmethod
    cdef Scoring from_pointer(scoring_t* scoring)
