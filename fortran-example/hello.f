            program circlearea
            real r, area, pi
            parameter (pi = 3.14159)
            print *, "this text is in a previous section"
!!!         @export area
            print *, "### @export area"
!        	This program computes the area of a circle
            r = 6
            area = pi * r ** 2
            print *, "area is", area
!!!         @end
            print *, "### @end"
            print *, "this text is in a later section"
            end
