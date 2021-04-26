# pyseq-align
Python interface for the [seq-align](https://github.com/noporpoise/seq-align) C library, written by Isaac Turner (@noporpoise).

## Installation
```
pip install pyseq-align
```

To install directly from GitHub,
```
git clone https://github.com/Lioscro/pyseq-align.git --recursive
cd pyseq-align
pip install .
```

## Usage
Two alignment algorithms are provided: Needleman-Wunsch and Smith-Waterman.

```python
from pyseq_align import NeedlemanWunsch

nw = NeedlemanWunsch()
al = nw.align('ACGT', 'ACGTC')
print(al.result_a)  # ACGT-
print(al.result_b)  # ACGTC
print(al.score)
```

```python
from pyseq_align import SmithWaterman

sw = SmithWaterman()
als = sw.align('ACGT', 'ACGTC')  # unlike above, this is a list of Alignment's
for al in als:
    print(al.result_a, al.pos_a)  # ACGT, 0
    print(al.result_b, al.pos_b)  # ACGT, 0
    print(al.score)
```
