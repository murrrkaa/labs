namespace Lexer
{
    public enum TokenType
    {
        /// <summary>
        ///  Ключевое слово VAR.
        /// </summary>
        Var,

        /// <summary>
        ///  Ключевое слово CONST.
        /// </summary>
        Const,

        /// <summary>
        ///  Ключевое слово IF.
        /// </summary>
        If,

        /// <summary>
        ///  Ключевое слово ELSE.
        /// </summary>
        Else,

        /// <summary>
        ///  Ключевое слово FOR.
        /// </summary>
        For,

        /// <summary>
        ///  Ключевое слово WHILE.
        /// </summary>
        While,

        /// <summary>
        ///  Ключевое слово FUNCTION.
        /// </summary>
        Function,

        /// <summary>
        ///  Ключевое слово RETURN.
        /// </summary>
        Return,

        /// <summary>
        ///  Ключевое слово BREAK.
        /// </summary>
        Break,

        /// <summary>
        ///  Ключевое слово CONTINUE.
        /// </summary>
        Continue,

        /// <summary>
        ///  Ключевое слово PRINT.
        /// </summary>
        Print,

        /// <summary>
        ///  Ключевое слово AND.
        /// </summary>
        And,

        /// <summary>
        ///  Ключевое слово OR.
        /// </summary>
        Or,

        /// <summary>
        ///  Идентификатор (имя символа).
        /// </summary>
        Identifier,

        /// <summary>
        ///  Литерал числа.
        /// </summary>
        Number,

        /// <summary>
        ///  Литерал строки.
        /// </summary>
        String,
        /// <summary>
        ///  Оператор сложения.
        /// </summary>
        PlusSign,

        /// <summary>
        ///  Оператор вычитания.
        /// </summary>
        MinusSign,

        /// <summary>
        ///  Оператор умножения.
        /// </summary>
        MultiplySign,

        /// <summary>
        ///  Оператор деления.
        /// </summary>
        DivideSign,

        /// <summary>
        ///  Ключевое слово "=".
        /// </summary>
        AssignThan,

        /// <summary>
        ///  Ключевое слово "==".
        /// </summary>
        EqualThan,

        /// <summary>
        ///  Ключевое слово "!=".
        /// </summary>
        NotEqualThan,

        /// <summary>
        ///  Оператор сравнения "меньше".
        /// </summary>
        LessThan,

        /// <summary>
        ///  Оператор сравнения "меньше или равно".
        /// </summary>
        LessThanOrEqual,

        /// <summary>
        ///  Оператор сравнения "больше".
        /// </summary>
        GreaterThan,

        /// <summary>
        ///  Оператор сравнения "больше или равно".
        /// </summary>
        GreaterThanOrEqual,

        /// <summary>
        ///  Открывающая круглая скобка '('.
        /// </summary>
        OpenParenthesis,

        /// <summary>
        ///  Закрывающая круглая скобка ')'.
        /// </summary>
        CloseParenthesis,

        /// <summary>
        ///  Открывающая круглая скобка '{'.
        /// </summary>
        OpenBrace,

        /// <summary>
        ///  Закрывающая круглая скобка '}'.
        /// </summary>
        CloseBrace,

        /// <summary>
        ///  Открывающая круглая скобка '['.
        /// </summary>
        OpenBracket,

        /// <summary>
        ///  Закрывающая круглая скобка ']'.
        /// </summary>
        CloseBracket,

        /// <summary>
        ///  Запятая ','
        /// </summary>
        Comma,

        /// <summary>
        ///  Разделитель ';'
        /// </summary>
        Semicolon,

        /// <summary>
        ///  Разделитель ':'
        /// </summary>
        Colon,

        /// <summary>
        ///  Конец файла.
        /// </summary>
        EndOfFile,

        /// <summary>
        ///  Недопустимая лексема.
        /// </summary>
        Error,

    }
}
