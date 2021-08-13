from setuptools import find_packages, Extension, setup
from Cython.Build import cythonize


def read(path):
    with open(path, 'r') as f:
        return f.read()


long_description = read('README.md')

include_dirs = ['pyseq_align/seq-align/src', 'pyseq_align/seq-align/libs']
extra_compile_args = [
    '-Wno-strict-prototypes', '-Wno-unused-variable', '-Wno-unused-function'
]
to_cythonize = [
    Extension(
        'pyseq_align.needleman_wunsch',
        [
            'pyseq_align/needleman_wunsch.pyx',
            'pyseq_align/seq-align/src/alignment.c',
            'pyseq_align/seq-align/src/alignment_scoring.c',
            'pyseq_align/seq-align/src/needleman_wunsch.c',
        ],
        include_dirs=include_dirs,
        extra_compile_args=extra_compile_args,
    ),
    Extension(
        'pyseq_align.smith_waterman',
        [
            'pyseq_align/smith_waterman.pyx',
            'pyseq_align/seq-align/src/alignment.c',
            'pyseq_align/seq-align/src/alignment_scoring.c',
            'pyseq_align/seq-align/src/smith_waterman.c',
        ],
        include_dirs=include_dirs,
        extra_compile_args=extra_compile_args,
    ),
    Extension(
        'pyseq_align.alignment',
        [
            'pyseq_align/alignment.pyx',
            'pyseq_align/seq-align/src/alignment.c',
            'pyseq_align/seq-align/src/alignment_scoring.c',
        ],
        include_dirs=include_dirs,
        extra_compile_args=extra_compile_args,
    ),
    Extension(
        'pyseq_align.scoring',
        [
            'pyseq_align/scoring.pyx',
            'pyseq_align/seq-align/src/alignment_scoring.c',
        ],
        include_dirs=include_dirs,
        extra_compile_args=extra_compile_args,
    ),
]

setup(
    name='pyseq-align',
    version='1.0.2',
    url='https://github.com/Lioscro/pyseq-align',
    author='Kyung Hoi (Joseph) Min',
    author_email='phoenixter96@gmail.com',
    description='',  # noqa
    long_description=long_description,
    long_description_content_type='text/markdown',
    keywords='',
    python_requires='>=3.6',
    license='MIT',
    packages=find_packages(exclude=('tests', 'docs')),
    zip_safe=False,
    include_package_data=True,
    setup_requires=['cython'],
    install_requires=read('requirements.txt').strip().split('\n'),
    ext_modules=cythonize(to_cythonize, language_level='3'),
    classifiers=[
        'Intended Audience :: Science/Research',
        'License :: OSI Approved :: MIT License',
        'Operating System :: OS Independent',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
        'Programming Language :: Cython',
        'Topic :: Scientific/Engineering :: Bio-Informatics',
    ],
)
