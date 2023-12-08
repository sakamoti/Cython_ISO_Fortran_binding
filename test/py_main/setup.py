import numpy as np
from distutils.core import setup, Extension
from Cython.Build import cythonize

ext = Extension(
    "fwrap",
    sources=['fwrap.pyx','../../src_ISO_Fortran_binding/cy_futils.c'],
    language='c',
    define_macros=[('NPY_NO_DEPRECATED_API','NPY_1_7_API_VERSION')],
    include_dirs=['../../src_ISO_Fortran_binding/','../f_lib/',np.get_include()],
    extra_link_args=["../f_lib/libfort.a","-lgfortran"],
)

setup(
    name='fwrap',
    ext_modules=cythonize(
        ext,
        language_level='3str',
        include_path=[".","../../src_ISO_Fortran_binding/","../f_lib/"],
        annotate=True,
    )
)