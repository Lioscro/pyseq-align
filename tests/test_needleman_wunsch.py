from unittest import TestCase

from pyseq_align import needleman_wunsch

from tests.mixins import TestMixin


class TestNeedlemanWunsch(TestMixin, TestCase):

    def test_align(self):
        nw = needleman_wunsch.NeedlemanWunsch(
            substitution_matrix=self.substitution_matrix,
            gap_open=self.gap_open,
            gap_extend=self.gap_extend,
            no_end_gap_penalty=True,
        )
        al = nw.align(self.ref, self.seq)
        self.assertEqual(1114, al.score)
        self.assertEqual(0, al.pos_a)
        self.assertEqual(0, al.pos_b)
