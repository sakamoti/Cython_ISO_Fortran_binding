#include <ISO_Fortran_binding.h>
#include <stdlib.h>

CFI_cdesc_t* CFI_CDESC_T_cwrap(int r)
{
    typedef CFI_CDESC_T(0) CFI_CDESC_T0;
    typedef CFI_CDESC_T(1) CFI_CDESC_T1;
    typedef CFI_CDESC_T(2) CFI_CDESC_T2;
    typedef CFI_CDESC_T(3) CFI_CDESC_T3;
    typedef CFI_CDESC_T(4) CFI_CDESC_T4;
    typedef CFI_CDESC_T(5) CFI_CDESC_T5;
    typedef CFI_CDESC_T(6) CFI_CDESC_T6;
    typedef CFI_CDESC_T(7) CFI_CDESC_T7;
    CFI_cdesc_t *array = NULL; 

    switch(r){
        case 0:
            CFI_CDESC_T0 *Fobject0;
            Fobject0 = (CFI_CDESC_T0*) malloc(sizeof(CFI_CDESC_T0));
            array = (CFI_cdesc_t*) Fobject0;
            break;
        case 1:
            CFI_CDESC_T1 *Fobject1;
            Fobject1 = (CFI_CDESC_T1*) malloc(sizeof(CFI_CDESC_T1));
            array = (CFI_cdesc_t*) Fobject1;
            break;
        case 2:
            CFI_CDESC_T2 *Fobject2;
            Fobject2 = (CFI_CDESC_T2*) malloc(sizeof(CFI_CDESC_T2));
            array = (CFI_cdesc_t*) Fobject2;
            break;
        case 3:
            CFI_CDESC_T3 *Fobject3;
            Fobject3 = (CFI_CDESC_T3*) malloc(sizeof(CFI_CDESC_T3));
            array = (CFI_cdesc_t*) Fobject3;
            break;
        case 4:
            CFI_CDESC_T4 *Fobject4;
            Fobject4 = (CFI_CDESC_T4*) malloc(sizeof(CFI_CDESC_T4));
            array = (CFI_cdesc_t*) Fobject4;
            break;
        case 5:
            CFI_CDESC_T5 *Fobject5;
            Fobject5 = (CFI_CDESC_T5*) malloc(sizeof(CFI_CDESC_T5));
            array = (CFI_cdesc_t*) Fobject5;
            break;
        case 6:
            CFI_CDESC_T6 *Fobject6;
            Fobject6 = (CFI_CDESC_T6*) malloc(sizeof(CFI_CDESC_T6));
            array = (CFI_cdesc_t*) Fobject6;
            break;
        case 7:
            CFI_CDESC_T7 *Fobject7;
            Fobject7 = (CFI_CDESC_T7*) malloc(sizeof(CFI_CDESC_T7));
            array = (CFI_cdesc_t*) Fobject7;
            break;
    }
    return array;
}