# Спецификация грамматики верхнего уровня языка программирования

## Примеры кода

```
// --- Объявление переменных и констант ---
var x: int = 10;
var y: int = -3;
const z: int = 80;

// --- Присваивание и использование выражений ---
var z: int = x + y;
print(z);

// --- Ввод числа с клавиатуры и вывод результата ---
var a: int = readInt();
print(a * a);

// --- Определение пользовательской функции ---
function add(p: int, q: int) {
  return p + q;
}

// --- Вызов пользовательской функции ---
var sum: int = add(x, y);
print(sum);

```

## Ключевые особенности

* Поддерживаются последовательное выполнение инструкций и ввод/вывод через встроенные функции `print` и `readInt`.
* Язык поддерживает глобальную и локальную область видимости внутри функций.
* Аргументы функции вычисляются слева направо, один за другим. Это гарантирует корректный порядок побочных эффектов, например при вложенных вызовах функций с вводом: sum(readInt(), readInt()).

## Семантические правила

1. Все переменные и константы должны быть объявлены перед использованием.
2. Константы не могут изменяться после инициализации.
3. Повторное объявление переменной или константы с тем же именем в одной области действия запрещено.
4. Использование переменной вне области видимости является ошибкой.
5. Функции должны быть объявлены перед вызовом с помощью ключевого слова `function`.
6. Константа (const) должна быть немедленно инициализирована значением в момент объявления.
7. Язык императивный: ветвления и циклы — это **инструкции (statements)**, а не выражения.

## Решение проблемы *висячего else*
Для разрешения неоднозначности конструкций типа
```
if (cond1)
      if (cond2)
         stmt1;
   else
      stmt2;
```
используется приём: грамматика разделяет инструкции на *matched* (с балансовыми `if`…`else`) и *unmatched* (т.е. `if` без соответствующего `else`). 
Правило «`else` всегда принадлежит ближайшему предыдущему `if`, у которого ещё нет `else`».

## Грамматика верхнего уровня

```ebnf
(* Программа находится в одном файле *)
program = top_level_statement, { top_level_statement } ;

(* Типы данных для переменных и функций *)
type = "int" | "float" | "string" | "bool" ;
return_type = type | "void" ;

(* Верхнеуровневая инструкция *)
top_level_statement =
      function_definition
    | simple_statement, ";" 
    | matched_if_statement
    | unmatched_if_statement ;

(* Объявление функции с типами *)
function_definition =
    "function", identifier, "(", [ typed_parameter_list ], ")", 
    [ ":", return_type ],
    "{", { function_statement }, "}" ;

(* Параметры функции с типами *)
typed_parameter_list = typed_parameter, { ",", typed_parameter } ;
typed_parameter = identifier, ":", type ;

(* Инструкции внутри функций *)
function_statement =
      simple_statement, ";"
    | matched_if_statement
    | unmatched_if_statement
    | return_statement
    | while_statement
    | for_statement ;

(* Return только внутри функций *)
return_statement = "return", [ expression ], ";" ;

(* Инструкции *)
statement =
      simple_statement, ";"
    | matched_if_statement
    | unmatched_if_statement
    | while_statement
    | for_statement 
    | function_definition ;

simple_statement =
      assignment_statement
    | function_call_statement
    | variable_declaration
    | constant_declaration
    | print_statement ;
    
(* Объявление переменной *)
variable_declaration = "var", identifier, ":", type, "=", expression ;

(* Объявление константы *)
constant_declaration = "const", identifier, ":", type, "=", expression ;

(* Присваивание *)
assignment_statement = identifier, "=", expression ;
           
(* Вызов функции *)
function_call_statement = (built_in_function | identifier), "(", [ expression_list ], ")" ;

(* Вывод *)
print_statement = "print", "(", [ expression_list ], ")" ;

(* Блок инструкций *)
block = "{", { statement }, "}" ;

(* Конструкция if с else *)
matched_if_statement =
      "if", "(", expression, ")", block, "else", block ;   
       
(* Конструкция if без else *)
unmatched_if_statement =
      "if", "(", expression, ")", block
    | "if", "(", expression, ")", matched_if_statement, "else", unmatched_if_statement ;
    
(* Инструкция break *)
break_statement = "break" ;

(* Инструкция continue *)
continue_statement = "continue" ;

(* Блок инструкций для циклов (может содержать break/continue) *)
loop_block = "{", { loop_statement }, "}" ;

(* Инструкции внутри циклов *)
loop_statement =
    simple_statement, ";"
    | continue_statement, ";"
    | break_statement, ";"
    | matched_if_statement
    | unmatched_if_statement
    | while_statement
    | for_statement 
    | function_definition ;
    
(* Цикл while *)
while_statement = "while", "(", expression, ")", loop_block ;
      
(* Цикл for *)
for_statement = "for", "(", assignment_statement, ";", expression, ";", assignment_statement, ")", loop_block ;
```

## Примеры программ

### SumNumbers

```
    var x: int = readInt();
    var y: int = readInt();
    var result: int = x + y;
    print(result);
```

### CircleSquare

```
    var radius: int = readInt();
    var area: float = Pi * radius * radius;
    print(area); 
```

### FahrenheitToCelsius

```
    var fahrenheit: int = readInt();
    var celsius: int = (fahrenheit - 32) * 5 / 9;
    print(celsius);
```

### Factorial
```
function factorial(n: int)
{
    var result: int = 1;
    var i: int = 1;

    for (i = 1; i <= n; i = i + 1)
    {
        result = result * i;
    }

    return result;
}

var number: int = readInt();
var fact: int = factorial(number);

print(fact);
```

### SumDigits
```
var n: int = readInt();
var sum: int = 0;

while (n != 0)
{
    var digit: int = n - (n / 10) * 10;
    sum = sum + digit;
    n = n / 10;
}

print(sum);
```

### IsPrime
```
var n: int = readInt();
var isPrime: int = 1;
var i: int = 2;

if (n <= 1)
{
    isPrime = 0;
}
else
{
    while (i * i <= n and isPrime == 1)
    {
        if (n - (n / i) * i == 0) 
        {
            isPrime = 0;
        }
        i = i + 1;
    }
}

print(isPrime);
```