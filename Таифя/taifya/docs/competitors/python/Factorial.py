def isPositiveNumber(number):
    return isinstance(number, (int, float)) and number >= 0

def factorial(number: int) -> int:
    if number in (0, 1):
        return 1
    return number * factorial(number - 1)

value = input("Введите целое число: ")

try:
    number = int(value)
    if isPositiveNumber(number):
        print(factorial(number))
    else:
        print("Некорректный ввод!")
except ValueError:
    print("Некорректный ввод!")
