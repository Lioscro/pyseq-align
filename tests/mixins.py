import os
import shutil
import tempfile
from unittest import TestCase


class TestMixin(TestCase):

    def setUp(self):
        self.temp_dir = tempfile.mkdtemp()

    def tearDown(self):
        shutil.rmtree(self.temp_dir, ignore_errors=True)

    @classmethod
    def setUpClass(cls):
        cls.base_dir = os.path.dirname(os.path.abspath(__file__))

        cls.ref = (
            'AATCCAGCTAGCTGTGCAGCNNNNNNNNNNNNNNATTCAACTGCAGTAATGCTACCTCGTACTCAC'
            'GCTTTCCAAGTGCTTGGCGTCGCATCTCGGTCCTTTGTACGCCGAAAAATGGCCTGACAACTAAGC'
            'TACGGCACGCTGCCATGTTGGGTCATAACGATATCTCTGGTTCATCCGTGACCGAACATGTCATGG'
            'AGTAGCAGGAGCTATTAATTCGCGGAGGACAATGCGGTTCGTAGTCACTGTCTTCCGCAATCGTCC'
            'ATCGCTCCTGCAGGTGGCCTAGAGGG'
        )
        cls.seq = (
            'AATCCAGCTAGCTGTGCAGCCGATTGGTCACTTAATTCAACTGCAGTAATGCTACCTCGTACTCAC'
            'GCTTTCCAAGTGCTTGGCGTCGCATCTCGGTCCTTTGTACGCCGAAAAAATGGCCTGACAACTAAG'
            'CTACGGCACGCTGCCATGTTGGGTCATAACGATTCATCCGTGACCGAACATGTCATGGAGTAGCAG'
            'GAGCTATTAATAGGACAATGCGGTTCGTAGTCACTGTCTTCCGCAATCGTCCATC'
        )

        cls.substitution_matrix = {
            "A": {
                "A": 5,
                "T": -4,
                "C": -4,
                "G": -4,
                "Z": 0,
                "N": 0
            },
            "T": {
                "A": -4,
                "T": 5,
                "C": -4,
                "G": -4,
                "Z": 0,
                "N": 0
            },
            "C": {
                "A": -4,
                "T": -4,
                "C": 5,
                "G": -4,
                "Z": 0,
                "N": 0
            },
            "G": {
                "A": -4,
                "T": -4,
                "C": -4,
                "G": 5,
                "Z": 0,
                "N": 0
            },
            "Z": {
                "A": 0,
                "T": 0,
                "C": 0,
                "G": 0,
                "Z": 0,
                "N": 0
            },
            "N": {
                "A": 0,
                "T": 0,
                "C": 0,
                "G": 0,
                "Z": 0,
                "N": 0
            },
        }
        cls.gap_open = -20
        cls.gap_extend = -1
