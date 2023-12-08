#ifndef F_FUNCTIONS_H
#define F_FUNCTIONS_H

#include <ISO_Fortran_binding.h>
#include <stdint.h>

typedef struct
{
    int16_t i16;
    int32_t i32;
    int64_t i64;
    float f32;
    double d64;
    int64_t i64array[5];
    double d64array[5];
    char txt[10];
}interoperable_t;
void init_interoperable_t(interoperable_t* ptr);
void bai_interoperable_t(interoperable_t* ptr);
void show_interoperable_t(interoperable_t* ptr);

void* generate_uninteroperable_t_pointer(int* n, int* m);
void* generate_uninteroperable_t_array_pointer(int* n_array, int* n, int* m);
void dealloc_uninteroperable_t(void* ptr);
void dealloc_uninteroperable_t_array(void* ptr, int* r);
void c_show_uninteroperable_t(void* ptr);
void c_uninteroperable_t_memoryview(void* ptr,
    int32_t* i32, double* d64, 
    CFI_cdesc_t* r64_1d, CFI_cdesc_t* r64_2d,
    CFI_cdesc_t* r64_1d_p, CFI_cdesc_t* r64_2d_p);

#endif /* F_FUNCTIONS_H */