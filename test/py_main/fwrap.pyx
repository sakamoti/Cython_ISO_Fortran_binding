import numpy as np
from cy_futils cimport CFI_CDESC_T_cwrap
from ISO_Fortran_binding cimport (
    CFI_attribute_allocatable,
    CFI_attribute_pointer,
    CFI_establish,
    CFI_type_double,
)

cdef class f_interoperable_t:
    cdef interoperable_t *_thisptr
    def __cinit__(self):
        self._thisptr = <interoperable_t*> malloc(sizeof(interoperable_t))

    def __dealloc__(self):
        if self._thisptr != NULL:
            free(self._thisptr)

    cpdef init_interoperable_t(self):
        init_interoperable_t(self._thisptr)

    cpdef bai_interoperable_t(self):
        bai_interoperable_t(self._thisptr)

    cpdef show_interoperable_t(self):
        show_interoperable_t(self._thisptr)

cdef class f_uninteroperable_t:
    cdef void *_thisptr
    cdef public int32_t i32
    cdef public double d64
    cdef public double[:] r64_1d
    cdef public double[::1,:] r64_2d
    cdef public double[:] r64_1d_p
    cdef public double[::1,:] r64_2d_p

    def __cinit__(self, int n, int m):
        self._thisptr = <void*> generate_uninteroperable_t_pointer(&n, &m)
        cdef CFI_cdesc_t* c_r64_1d = CFI_CDESC_T_cwrap(1)
        cdef CFI_cdesc_t* c_r64_2d = CFI_CDESC_T_cwrap(2)
        cdef CFI_cdesc_t* c_r64_1d_p = CFI_CDESC_T_cwrap(1)
        cdef CFI_cdesc_t* c_r64_2d_p = CFI_CDESC_T_cwrap(2)
        CFI_establish(c_r64_1d, NULL, CFI_attribute_pointer,CFI_type_double,8,1,NULL)
        CFI_establish(c_r64_2d, NULL, CFI_attribute_pointer,CFI_type_double,8,2,NULL)
        CFI_establish(c_r64_1d_p, NULL, CFI_attribute_pointer,CFI_type_double,8,1,NULL)
        CFI_establish(c_r64_2d_p, NULL, CFI_attribute_pointer,CFI_type_double,8,2,NULL)
        c_uninteroperable_t_memoryview(self._thisptr,&self.i32,&self.d64,c_r64_1d,c_r64_2d,c_r64_1d_p,c_r64_2d_p)
        self.r64_1d = <double[:c_r64_1d.dim[0].extent]> c_r64_1d.base_addr
        self.r64_2d = (<double[:c_r64_2d.dim[1].extent,:c_r64_2d.dim[0].extent]> c_r64_2d.base_addr).T
        self.r64_1d_p = <double[:c_r64_1d_p.dim[0].extent]> c_r64_1d_p.base_addr
        self.r64_2d_p = (<double[:c_r64_2d_p.dim[1].extent,:c_r64_2d.dim[0].extent]> c_r64_2d_p.base_addr).T

    def __dealloc__(self):
        if self._thisptr != NULL:
            dealloc_uninteroperable_t(self._thisptr)

    cpdef show(self):
        c_show_uninteroperable_t(self._thisptr)
