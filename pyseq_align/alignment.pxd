from .wrappers.alignment cimport *

cdef class Alignment:
    cdef alignment_t* _pointer

    @staticmethod
    cdef Alignment from_pointer(alignment_t* alignment)
