#include <stdio.h>
#include <ISO_Fortran_binding.h>
#include "f_functions.h"

void interoperable_t_test(void)
{
    interoperable_t fstruct;
    printf("\n/* INTEROPERABLE_T_TEST */ \n");
    init_interoperable_t(&fstruct);
    show_interoperable_t(&fstruct);
    bai_interoperable_t(&fstruct);
    show_interoperable_t(&fstruct);
};

void show_array(CFI_cdesc_t *array)
{
    long shape[5]={0,0,0,0,0};
    int nrank = array->rank;
    printf("!--- Write fortran array from C program\n");
    printf("rank=%d,elem_len=%ld,shape=[",nrank, array->elem_len);
    for(int i=0;i<nrank;i++){
        shape[i] = array->dim[i].extent;
        printf("%ld,",shape[i]);
    }
    printf("], address=%p\n",array->base_addr);
    if(array->type== CFI_type_double)
    {
        if(nrank==1){
            double *array_cptr;
            array_cptr = (double*) array->base_addr;
            for(int i=0;i<shape[0];i++){
                printf("%f,",array_cptr[i]);
            }
            printf("\n");
        }else if(nrank==2){
            typedef double carray[shape[0]];
            carray *array2d_cptr;
            array2d_cptr = (carray*) array->base_addr;
            for(int i=0;i<shape[0];i++){
                for(int j=0;j<shape[1];j++){
                    printf("%f,",array2d_cptr[j][i]);
                }
                printf("\n");
            }
        }
    }
};

void uninteroperable_t_scaler_test(void)
{
    void* uninteroperable_t_fptr;
    int n=2;
    int m=3;
    int32_t i32;
    double d64;
    CFI_CDESC_T(1) Fobj1d;
    CFI_CDESC_T(2) Fobj2d;
    CFI_cdesc_t* r64_1d = (CFI_cdesc_t*) &Fobj1d;
    CFI_cdesc_t* r64_2d = (CFI_cdesc_t*) &Fobj2d;
    CFI_cdesc_t* r64_1d_p = (CFI_cdesc_t*) &Fobj1d;
    CFI_cdesc_t* r64_2d_p = (CFI_cdesc_t*) &Fobj2d;
    //CFI_index_t arrayshape1[1] = {0};
    //CFI_index_t arrayshape2[2] = {0,0};
    int stat,rank;
    printf("\n/* UNINTEROPERABLE_T_SCALER_TEST */ \n");
    rank = 1;
    stat = CFI_establish(r64_1d,NULL,CFI_attribute_allocatable,
        CFI_type_double,8,rank,NULL);
    stat = CFI_establish(r64_1d_p,NULL,CFI_attribute_pointer,
        CFI_type_double,8,rank,NULL);
    rank = 2;
    stat = CFI_establish(r64_2d,NULL,CFI_attribute_allocatable,
        CFI_type_double,8,rank,NULL);
    stat = CFI_establish(r64_2d_p,NULL,CFI_attribute_pointer,
        CFI_type_double,8,rank,NULL);
    uninteroperable_t_fptr = generate_uninteroperable_t_pointer(&n, &m); 
    c_show_uninteroperable_t(uninteroperable_t_fptr);
    c_uninteroperable_t_memoryview(uninteroperable_t_fptr,
        &i32, &d64, r64_1d, r64_2d, r64_1d_p, r64_2d_p);
    printf("i32=%d, d64=%f\n",i32,d64);
    show_array(r64_1d);
    show_array(r64_2d);
    show_array(r64_1d_p);
    show_array(r64_2d_p);
    dealloc_uninteroperable_t(uninteroperable_t_fptr);
};

void uninteroperable_t_array_test(void)
{
    int i,n_array,n,m;
    n_array=5;
    n=2;
    m=3;
    void* uninteroperable_t_fptr;
    printf("\n/* UNINTEROPERABLE_T_ARRAY_TEST */ \n");
    uninteroperable_t_fptr = generate_uninteroperable_t_array_pointer(&n_array,&n, &m); 
    //c_show_uninteroperable_t(uninteroperable_t_fptr);
    dealloc_uninteroperable_t_array(uninteroperable_t_fptr, &n_array);
};

int main(void)
{
    interoperable_t_test();
    uninteroperable_t_scaler_test();
    uninteroperable_t_array_test();
}