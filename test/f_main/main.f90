program main
    use ISO_Fortran_binding_test
    implicit none
    call interoperable_t_test()
    call uninteroperable_t_scaler_test()
    call uninteroperable_t_array_test()
    contains
    subroutine interoperable_t_test()
        type(interoperable_t) :: interoperable_type
        integer :: i
        character(len=:),allocatable :: local_txt
        print *, "!=== INTEROPERABLE_T_TEST"
        local_txt = "test"
        do i = 1,4
            interoperable_type%txt(i) = local_txt(i:i)
        end do
        interoperable_type%txt(5) = c_null_char
        call show_interoperable_t(interoperable_type)
    end subroutine 
    subroutine uninteroperable_t_scaler_test()
        type(uninteroperable_t) :: uninteroperable_type
        print '(/,A)', "!=== UNINTEROPERABLE_T_SCALER_TEST"
        uninteroperable_type = uninteroperable_t(2,3)
        call uninteroperable_type%show_uninteroperable_t()
    end subroutine 
    subroutine uninteroperable_t_array_test()
        type(uninteroperable_t),allocatable :: uninteroperable_type(:)
        integer :: i,n
        print '(/,A)', "!=== UNINTEROPERABLE_T_ARRAY_TEST"
        n = 3
        allocate(uninteroperable_type(n))
        do i=1,n !concurrent(i=1:n)
          uninteroperable_type(i) = uninteroperable_t(2,3)
        end do
        call uninteroperable_type%show_uninteroperable_t()
    end subroutine 
end program