from ISO_Fortran_binding cimport *

cdef extern from "cy_futils.h" nogil:
    CFI_cdesc_t* CFI_CDESC_T_cwrap(int r)