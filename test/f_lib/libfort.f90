module ISO_Fortran_binding_test
    use iso_c_binding
    use iso_fortran_env
    implicit none
    public
    type, bind(c) :: interoperable_t
        integer(c_int16_t) :: i16 = 16 
        integer(c_int32_t) :: i32 = 32
        integer(c_int64_t) :: i64 = 64
        real(c_float) :: f32 = 32.0_c_float
        real(c_double) :: d64 = 64.0_c_double
        integer(c_int64_t) :: i64array(5) = 1_c_int64_t
        real(c_double) :: d64array(5) = 1.0_c_double
        character(len=1,kind=c_char) :: txt(10) = ""//c_null_char
    end type
    type :: base_t
        integer :: i32 = 32
        real(real64) :: d64 = 64.0_real64
    end type
    type, extends(base_t) :: uninteroperable_t
        real(real64),allocatable :: r64_1d(:), r64_2d(:,:)
        real(real64),pointer :: r64_1d_p(:) => null(), r64_2d_p(:,:) => null()
        contains
          final :: final_uniteroperable_t
          procedure :: show_uninteroperable_t
    end type
    interface uninteroperable_t
        module procedure :: uninteroperable_t__init__
    end interface
    contains
        subroutine init_interoperable_t(self) bind(c)
            type(interoperable_t), intent(inout) :: self
            self = interoperable_t()
        end subroutine
        subroutine bai_interoperable_t(self) bind(c)
            type(interoperable_t), intent(inout) :: self
            self%i16 = self%i16 * 2_c_int16_t
            self%i32 = self%i32 * 2_c_int32_t
            self%i64 = self%i64 * 2_c_int64_t
            self%f32 = self%f32 * 2.0_c_float
            self%d64 = self%d64 * 2.0_c_double
            self%i64array = self%i64array * 2_c_int64_t
            self%d64array = self%d64array * 2.0_c_double
        end subroutine
        subroutine show_interoperable_t(self) bind(c)
            type(interoperable_t), intent(in) :: self
            character(len=:),allocatable :: fmt
            integer :: i
            write(output_unit,'(1x,a)') "!--show_inteoperable_t fromFortran----"
            fmt = "(1x,3i10,2f11.3)"
            write(output_unit,fmt) self%i16,self%i32,self%i64,self%f32,self%d64
            fmt = "(1x,'i64array:',5i11)"
            write(output_unit,fmt) self%i64array
            fmt = "(1x,'d64array:',5f11.3)"
            write(output_unit,fmt) self%d64array
            write(output_unit,'(1x,"txt:")',advance='no')
            do i = 1,10
                if(self%txt(i) == c_null_char) then
                    exit
                end if
                write(output_unit,'(a)',advance='no') self%txt(i)
            end do
            write(output_unit,'(/,1x,a)') "!--end show_inteoperable_t fromFortran----"
        end subroutine

        !------------------------------------------------------------
        impure elemental subroutine final_uniteroperable_t(self)
            type(uninteroperable_t),intent(inout) :: self
            if(associated(self%r64_1d_p))then
                deallocate(self%r64_1d_p)
            endif
            if(associated(self%r64_2d_p))then
                deallocate(self%r64_2d_p)
            endif
            print*, "__final__uniteroperable_t"
        end subroutine
        impure elemental function uninteroperable_t__init__(n,m) result(res)
            integer, intent(in) :: n,m
            type(uninteroperable_t) :: res
            print*, "__init__uniteroperable_t"
            if(.not.allocated(res%r64_1d))then
                res%r64_1d = arange_r64_allocatable(n) 
            end if
            if(.not.allocated(res%r64_2d))then
                res%r64_2d = reshape(arange_r64_allocatable(n*m),[n,m])
            end if
            if(.not.associated(res%r64_1d_p))then
                !allocate(res%r64_1d_p(n),source=1d0)
                res%r64_1d_p => arange_r64_pointer(n) 
            end if
            if(.not.associated(res%r64_2d_p))then
                !allocate(res%r64_2d_p(n,m),source=1d0)
                res%r64_2d_p => reshape_pointer_1dto2d(n,m,arange_r64_pointer(n*m)) 
            end if
        end function
        impure elemental subroutine show_uninteroperable_t(self)
            class(uninteroperable_t),intent(in) :: self
            integer,allocatable :: array_shape(:)
            write(output_unit,'(1x,a)') "!--show_uninteoperable_t fromFortran----"
            write(output_unit,'("i32=",i3)') self%i32
            write(output_unit,'("d64=",f5.1)') self%d64
            array_shape = shape(self%r64_1d)
            write(output_unit,'("r64_1d:shape=(",i0,")")') array_shape
            call showarray1d(array_shape,self%r64_1d)
            array_shape = shape(self%r64_2d)
            write(output_unit,'("r64_2d:shape=(",i0,",",i0,")")') array_shape
            call showarray2d(array_shape,self%r64_2d)
            array_shape = shape(self%r64_1d_p)
            write(output_unit,'("r64_1d_p:shape=(",i0,")")') array_shape
            call showarray1d(array_shape,self%r64_1d_p)
            array_shape = shape(self%r64_2d_p)
            write(output_unit,'("r64_2d_p:shape=(",i0,",",i0,")")') array_shape
            call showarray2d(array_shape,self%r64_2d_p)
            write(output_unit,'(1x,a)') "!--end show_uninteoperable_t fromFortran----"
            contains
            subroutine showarray1d(ashape,array)
              integer :: ashape(:)
              real(real64) :: array(:)
              integer :: i
              do i = 1,ashape(1)
                write(output_unit,'(g10.3)',advance="no")array(i)
              end do
              write(output_unit,'(1x)',advance="yes")
            end subroutine
            subroutine showarray2d(ashape,array)
              integer :: ashape(:)
              real(real64) :: array(:,:)
              integer :: i,j
              do j = 1,ashape(1)
                do i = 1,ashape(2)
                    write(output_unit,'(g10.3)',advance="no")array(j,i)
                end do
                write(output_unit,'(1x)',advance="yes")
              end do
            end subroutine
        end subroutine
        !------------------------------------------------------------
        function arange_r64_allocatable(n) result(res)
            integer,intent(in) :: n
            real(real64),allocatable :: res(:)
            integer :: i
            allocate(res(n))
            do i = 1,n
                res(i) = i
            end do
        end function
        function arange_r64_pointer(n) result(res)
            integer,intent(in) :: n
            real(real64),pointer :: res(:)
            integer :: i
            allocate(res(n))
            do i = 1,n
                res(i) = i
            end do
        end function
        function reshape_pointer_1dto2d(n,m,pp) result(res)
            integer,intent(in) :: n,m
            real(real64),pointer :: pp(:)
            real(real64),pointer :: res(:,:)
            res(1:n,1:m) => pp(1:n*m)
        end function
end module