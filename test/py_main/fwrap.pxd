cimport numpy as np
from ISO_Fortran_binding cimport CFI_cdesc_t
from libc.stdlib cimport *
from libc.stdint cimport (
    int16_t,
    int32_t,
    int64_t,
)

cdef extern from "f_functions.h":
    ctypedef struct interoperable_t:
        int16_t i16
        int32_t i32
        int64_t i64
        float f32
        double d64
        int64_t i64array[5]
        double d64array[5]
        char txt[10]
    void init_interoperable_t(interoperable_t* ptr)
    void bai_interoperable_t(interoperable_t* ptr)
    void show_interoperable_t(interoperable_t* ptr)

    void* generate_uninteroperable_t_pointer(int* n, int* m)
    void* generate_uninteroperable_t_array_pointer(int* n_array, int* n, int* m)
    void dealloc_uninteroperable_t(void* ptr)
    void dealloc_uninteroperable_t_array(void* ptr, int* r)
    void c_show_uninteroperable_t(void* ptr)
    void c_uninteroperable_t_memoryview(void* ptr,
        int32_t* i32, double* d64, 
        CFI_cdesc_t* r64_1d, CFI_cdesc_t* r64_2d,
        CFI_cdesc_t* r64_1d_p, CFI_cdesc_t* r64_2d_p)
