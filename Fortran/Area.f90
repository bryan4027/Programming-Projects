Module everything
implicit none
    type point
        real    :: x,y
        end type point

    type rectangle
        type(point) :: a,b

            end type rectangle

    type(rectangle) :: inputrectangle
    contains
    real(4) function area(inputrectangle)
    implicit none
            type(rectangle),intent(in) :: inputrectangle
            area =  ABS((inputrectangle%b%x-inputrectangle%a%x) * (inputrect\
angle%b%y-inputrectangle%a%y))
            end function area
end Module everything

program coe_areaf
    use everything
    implicit none
    read *, inputrectangle%a%x,inputrectangle%a%y
    read *, inputrectangle%b%x,inputrectangle%b%y
    print *, area(inputrectangle)
    end program coe_areaf
