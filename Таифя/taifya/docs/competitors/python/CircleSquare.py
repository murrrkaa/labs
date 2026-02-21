import math

def computeCircleArea(radius):
    return round(math.pi * radius ** 2, 3)

def isPositiveNumber(number):
    return isinstance(number, (int, float)) and number > 0

value = input("Введите радиус круга: ")

try:
    radius = float(value)
    if isPositiveNumber(radius):
        print(computeCircleArea(radius))
    else:
        print("Некорректный радиус!")
except ValueError:
    print("Некорректный радиус!")
