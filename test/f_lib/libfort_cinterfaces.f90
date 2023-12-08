module ISO_Fortran_binding_test_cinterface
    use ISO_Fortran_binding_test
    implicit none
    public
    contains
        function generate_uninteroperable_t_pointer(n,m) bind(c) result(ptr)
            use iso_fortran_env
            integer(c_int) :: n,m
            type(c_ptr) :: ptr
            type(uninteroperable_t),pointer :: fobj
            allocate(fobj, source=uninteroperable_t(n,m))
            ptr = c_loc(fobj)
            print*,"fortran uninteroperable_t pointer"
            print '(1x,A,Z12,",",I15,A)',"c_ptr address is 0x",transfer(c_loc(fobj),0_int64), &
                   transfer(c_loc(fobj),0_int64),"(from fortran)"
        end function
        function generate_uninteroperable_t_array_pointer(narray,n,m) bind(c) result(ptr)
            use iso_fortran_env
            integer(c_int) :: narray,n,m
            type(c_ptr) :: ptr
            type(uninteroperable_t),pointer :: fobj(:)
            integer :: i
            allocate(fobj(narray))
            do i = 1,narray
                fobj(i) = uninteroperable_t(n,m)
            end do
            ptr = c_loc(fobj)
            print*,"fortran uninteroperable_t pointer (array version)"
            print '(1x,A,Z12,",",I15,A)',"c_ptr address is 0x",transfer(c_loc(fobj),0_int64), &
                   transfer(c_loc(fobj),0_int64),"(from fortran)"
        end function
        subroutine dealloc_uninteroperable_t(cptr) bind(c)
            type(c_ptr),intent(in),value :: cptr
            type(uninteroperable_t),pointer :: fptr => null()
            call c_f_pointer(cptr, fptr)
            if(associated(fptr))then
                deallocate(fptr)
                print*,"dealloc_uninteroperable_t from fortran"
            end if
        end subroutine
        subroutine dealloc_uninteroperable_t_array(cptr, r) bind(c)
            type(c_ptr),intent(in),value :: cptr
            type(uninteroperable_t),pointer :: fptr(:) => null()
            integer :: r(1)
            call c_f_pointer(cptr, fptr, r)
            if(associated(fptr))then
                deallocate(fptr)
                print*,"dealloc_uninteroperable_t from fortran"
            end if
        end subroutine

        subroutine c_show_uninteroperable_t(cptr) bind(c)
            type(c_ptr),intent(in),value :: cptr
            type(uninteroperable_t),pointer :: fptr => null()
            call c_f_pointer(cptr, fptr)
            call fptr%show_uninteroperable_t()
        end subroutine

        subroutine c_uninteroperable_t_memoryview(cptr, &
            & i32, d64, r64_1d, r64_2d, r64_1d_p, r64_2d_p) bind(c)
            type(c_ptr),intent(in),value :: cptr
            type(uninteroperable_t),pointer :: fptr => null()
            integer(int32) :: i32
            real(real64) :: d64
            real(real64),pointer :: r64_1d(:), r64_2d(:,:)
            real(real64),pointer :: r64_1d_p(:), r64_2d_p(:,:)
            call c_f_pointer(cptr, fptr)
            i32 = fptr%i32
            d64 = fptr%d64
            r64_1d => fptr%r64_1d
            r64_2d => fptr%r64_2d
            r64_1d_p => fptr%r64_1d_p
            r64_2d_p => fptr%r64_2d_p
        end subroutine
end module