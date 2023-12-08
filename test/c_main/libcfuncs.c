#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ISO_Fortran_binding.h>

void show_array(CFI_cdesc_t *desc)
{
    printf("base_addr: %p\n",desc->base_addr);
    printf("rank: %d\n",desc->rank);
    printf("elem_len: %ld\n",desc->elem_len);
    printf("versoin: %d\n",desc->version);
    printf("attribute: %d\n",desc->attribute);
    if(desc->attribute == CFI_attribute_allocatable){
        printf("  Allocatable fortran object\n");
    }
    printf("rank: %d\n",desc->rank);
    for(int i=0;i<desc->rank;i++){
        printf("dim[%d]:%ld,%ld,%ld\n",i,
            desc->dim[i].lower_bound,
            desc->dim[i].extent,
            desc->dim[i].sm
            );
    }
    if(desc->type == CFI_type_int64_t){
        printf("type:  int64_t\n");
    }

    typedef long weekinfo_t[7][3];
    weekinfo_t *array3d = (weekinfo_t*) desc -> base_addr;
    long *array1d = (long*) desc -> base_addr;
    for (int i=0;i<4;i++){
        printf("week=%d, print from C\n",i);
        for(int k=0;k<3;k++){
            for(int j=0;j<7;j++){
                printf("%5ld",array3d[i][j][k]);
            }
            printf("\n");
        }
        printf("\n");
    }
    for (int i=0;i<(4*7*3);i++){
        printf("%3ld",array1d[i]);
    }printf("\n");

    if(CFI_is_contiguous(desc)){
        printf("array is_contignuous\n");
    }
}

void get_home(CFI_cdesc_t *home)
{
    int r;
    char *homename =getenv("HOME");
    printf("HOME:%s\n",homename);
    printf(" base address of *home:%p\n",home->base_addr);
    if(home->base_addr){
        r = CFI_deallocate(home);
        if(r) return;
    }
    if(homename){
        size_t len = strlen(homename);
        const CFI_index_t lower[1] = {1};
        const CFI_index_t upper[1] = {len};
        printf("size of strings:%ld,%ld\n",len,sizeof(char));
        home->elem_len = 1;
        r = CFI_allocate(home,
            lower, upper ,1
        );
        printf("r=%d\n",r);
        if(r) return; /* failed */
        memcpy(home->base_addr,homename,len);
    }
}