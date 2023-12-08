from libc.stdint cimport *
from libc.stddef cimport *

cdef extern from "<ISO_Fortran_binding.h>" nogil:
    #/* Constants, defined as macros. */
    int CFI_VERSION
    int CFI_MAX_RANK

    #/* Attributes. */
    int CFI_attribute_pointer
    int CFI_attribute_allocatable
    int CFI_attribute_other

    #/* Error codes.
    #CFI_INVALID_STRIDE should be defined in the standard because they are useful to the implementation of the functions.
    #*/
    int CFI_SUCCESS
    int CFI_FAILURE
    int CFI_ERROR_BASE_ADDR_NULL
    int CFI_ERROR_BASE_ADDR_NOT_NULL
    int CFI_INVALID_ELEM_LEN
    int CFI_INVALID_RANK
    int CFI_INVALID_TYPE
    int CFI_INVALID_ATTRIBUTE
    int CFI_INVALID_EXTENT
    int CFI_INVALID_STRIDE
    int CFI_INVALID_DESCRIPTOR
    int CFI_ERROR_MEM_ALLOCATION
    int CFI_ERROR_OUT_OF_BOUNDS

    #/* CFI type definitions. */
    ctypedef ptrdiff_t CFI_index_t
    ctypedef int8_t CFI_rank_t
    ctypedef int8_t CFI_attribute_t
    ctypedef int16_t CFI_type_t

    #/* CFI_dim_t. */
    ctypedef struct CFI_dim_t:
        CFI_index_t lower_bound
        CFI_index_t extent
        CFI_index_t sm

    ctypedef struct CFI_cdesc_t:
        void *base_addr
        size_t elem_len
        int version
        CFI_rank_t rank
        CFI_attribute_t attribute
        CFI_type_t type
        CFI_dim_t dim[]

    #CFI_cdesc_t* CFI_CDESC_T_cwrap(int r)

    #/* CFI function declarations. */
    void *CFI_address (const CFI_cdesc_t *, const CFI_index_t [])
    int CFI_allocate (CFI_cdesc_t *, const CFI_index_t [], const CFI_index_t [],
         size_t)
    int CFI_deallocate (CFI_cdesc_t *)
    int CFI_establish (CFI_cdesc_t *, void *, CFI_attribute_t, CFI_type_t, size_t,
         CFI_rank_t, const CFI_index_t [])
    int CFI_is_contiguous (const CFI_cdesc_t *)
    int CFI_section (CFI_cdesc_t *, const CFI_cdesc_t *, const CFI_index_t [],
         const CFI_index_t [], const CFI_index_t [])
    int CFI_select_part (CFI_cdesc_t *, const CFI_cdesc_t *, size_t, size_t)
    int CFI_setpointer (CFI_cdesc_t *, CFI_cdesc_t *, const CFI_index_t [])

    #define CFI_type_mask 0xFF
    int CFI_type_kind_shift

    #/* intrinsic types. Their kind number defines their storage size. */
    int CFI_type_Integer
    int CFI_type_Logical
    int CFI_type_Real
    int CFI_type_Complex
    int CFI_type_Character

    #/* Types with no kind. */
    int CFI_type_struct
    int CFI_type_cptr
    int CFI_type_cfunptr
    int CFI_type_other

    int CFI_type_signed_char
    int CFI_type_short
    int CFI_type_int
    int CFI_type_long
    int CFI_type_long_long
    int CFI_type_size_t
    int CFI_type_int8_t
    int CFI_type_int16_t
    int CFI_type_int32_t
    int CFI_type_int64_t
    int CFI_type_int_least8_t
    int CFI_type_int_least16_t
    int CFI_type_int_least32_t
    int CFI_type_int_least64_t
    int CFI_type_int_fast8_t
    int CFI_type_int_fast16_t
    int CFI_type_int_fast32_t
    int CFI_type_int_fast64_t
    int CFI_type_intmax_t
    int CFI_type_intptr_t
    int CFI_type_ptrdiff_t
    int CFI_type_int128_t
    int CFI_type_int_least128_t
    int CFI_type_int_fast128_t
    int CFI_type_Bool
    int CFI_type_float
    int CFI_type_double
    int CFI_type_long_double
    int CFI_type_float128
    int CFI_type_float_Complex
    int CFI_type_double_Complex
    int CFI_type_long_double_Complex
    int CFI_type_float128_Complex