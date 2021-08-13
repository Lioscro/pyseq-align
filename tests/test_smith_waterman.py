from unittest import TestCase

from pyseq_align import smith_waterman

from tests.mixins import TestMixin


class TestSmithWaterman(TestMixin, TestCase):

    def test_align(self):
        sw = smith_waterman.SmithWaterman(
            substitution_matrix=self.substitution_matrix,
            gap_open=self.gap_open,
            gap_extend=self.gap_extend,
        )
        als = sw.align(self.ref, self.seq, n=10)
        self.assertEqual(10, len(als))
        self.assertEqual(1114, als[0].score)
        self.assertEqual(0, als[0].pos_a)
        self.assertEqual(0, als[0].pos_b)
