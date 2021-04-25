from .wrappers.alignment cimport *

cdef class Alignment:
    def __cinit__(self, capacity: int):
        self._pointer = alignment_create(capacity)
        if not self._pointer:
            raise MemoryError('Failed to allocate memory')

    def __dealloc__(self):
        alignment_free(self._pointer)

    @staticmethod
    cdef Alignment from_pointer(alignment_t* alignment):
        cdef Alignment obj = <Alignment>Alignment.__new__(Alignment)
        obj._pointer = alignment
        return obj

    @property
    def result_a(self): return self._pointer.result_a.decode('UTF-8')

    @property
    def result_b(self): return self._pointer.result_b.decode('UTF-8')

    @property
    def capacity(self): return self._pointer.capacity

    @property
    def length(self): return self._pointer.length

    @property
    def pos_a(self): return self._pointer.pos_a

    @property
    def pos_b(self): return self._pointer.pos_b

    @property
    def len_a(self): return self._pointer.len_a

    @property
    def len_b(self): return self._pointer.len_b

    @property
    def score(self): return self._pointer.score
