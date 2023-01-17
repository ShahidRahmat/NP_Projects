import math
pi = math.pi
radius = float(input("What is the radius of the cylinder?: "))
height = float(input("What is the height of the cylinder?: "))
surface_area = 2*pi*radius*height + 2*pi*(radius**2)
print("The surface area of the cylinder is " + str(surface_area))
