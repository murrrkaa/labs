using Xunit;
using Lexer;

namespace Lexer.UnitTests;

public class LexerTests
{
    [Theory]
    [MemberData(nameof(GetTokenizeData))]
    public void Can_tokenize_source(string source, List<Token> expected)
    {
        List<Token> actual = Tokenize(source);
        Assert.Equal(expected, actual);
    }

    public static TheoryData<string, List<Token>> GetTokenizeData()
    {
        return new TheoryData<string, List<Token>>
        {
            {
                "var x = 10;",
                new List<Token>
                {
                    new Token(TokenType.Var),
                    new Token(TokenType.Identifier, new TokenValue("x")),
                    new Token(TokenType.AssignThan),
                    new Token(TokenType.Number, new TokenValue("10")),
                    new Token(TokenType.Semicolon),
                }
            },
            {
                "const name = 'Kate';",
                new List<Token>
                {
                    new Token(TokenType.Const),
                    new Token(TokenType.Identifier, new TokenValue("name")),
                    new Token(TokenType.AssignThan),
                    new Token(TokenType.String, new TokenValue("Kate")),
                    new Token(TokenType.Semicolon),
                }
            },
            {
                "if (x > 0) { } else { }",
                new List<Token>
                {
                    new Token(TokenType.If),
                    new Token(TokenType.OpenParenthesis),
                    new Token(TokenType.Identifier, new TokenValue("x")),
                    new Token(TokenType.GreaterThan),
                    new Token(TokenType.Number, new TokenValue("0")),
                    new Token(TokenType.CloseParenthesis),
                    new Token(TokenType.OpenBrace),
                    new Token(TokenType.CloseBrace),
                    new Token(TokenType.Else),
                    new Token(TokenType.OpenBrace),
                    new Token(TokenType.CloseBrace),
                }
            },
            {
                "while (x > 0) { }",
                new List<Token>
                {
                    new Token(TokenType.While),
                    new Token(TokenType.OpenParenthesis),
                    new Token(TokenType.Identifier, new TokenValue("x")),
                    new Token(TokenType.GreaterThan),
                    new Token(TokenType.Number, new TokenValue("0")),
                    new Token(TokenType.CloseParenthesis),
                    new Token(TokenType.OpenBrace),
                    new Token(TokenType.CloseBrace),
                }
            },
            {
                "for (i = 0; i < 5; i = i + 1) { }",
                new List<Token>
                {
                    new Token(TokenType.For),
                    new Token(TokenType.OpenParenthesis),
                    new Token(TokenType.Identifier, new TokenValue("i")),
                    new Token(TokenType.AssignThan),
                    new Token(TokenType.Number, new TokenValue("0")),
                    new Token(TokenType.Semicolon),
                    new Token(TokenType.Identifier, new TokenValue("i")),
                    new Token(TokenType.LessThan),
                    new Token(TokenType.Number, new TokenValue("5")),
                    new Token(TokenType.Semicolon),
                    new Token(TokenType.Identifier, new TokenValue("i")),
                    new Token(TokenType.AssignThan),
                    new Token(TokenType.Identifier, new TokenValue("i")),
                    new Token(TokenType.PlusSign),
                    new Token(TokenType.Number, new TokenValue("1")),
                    new Token(TokenType.CloseParenthesis),
                    new Token(TokenType.OpenBrace),
                    new Token(TokenType.CloseBrace),
                }
            },
            {
                "function add(a, b) { return a + b; }",
                new List<Token>
                {
                    new Token(TokenType.Function),
                    new Token(TokenType.Identifier, new TokenValue("add")),
                    new Token(TokenType.OpenParenthesis),
                    new Token(TokenType.Identifier, new TokenValue("a")),
                    new Token(TokenType.Comma),
                    new Token(TokenType.Identifier, new TokenValue("b")),
                    new Token(TokenType.CloseParenthesis),
                    new Token(TokenType.OpenBrace),
                    new Token(TokenType.Return),
                    new Token(TokenType.Identifier, new TokenValue("a")),
                    new Token(TokenType.PlusSign),
                    new Token(TokenType.Identifier, new TokenValue("b")),
                    new Token(TokenType.Semicolon),
                    new Token(TokenType.CloseBrace),
                }
            },
            {
                "for (;;) { break; continue; }",
                new List<Token>
                {
                    new Token(TokenType.For),
                    new Token(TokenType.OpenParenthesis),
                    new Token(TokenType.Semicolon),
                    new Token(TokenType.Semicolon),
                    new Token(TokenType.CloseParenthesis),
                    new Token(TokenType.OpenBrace),
                    new Token(TokenType.Break),
                    new Token(TokenType.Semicolon),
                    new Token(TokenType.Continue),
                    new Token(TokenType.Semicolon),
                    new Token(TokenType.CloseBrace),
                }
            },
            {
                "print('hello');",
                new List<Token>
                {
                    new Token(TokenType.Print),
                    new Token(TokenType.OpenParenthesis),
                    new Token(TokenType.String, new TokenValue("hello")),
                    new Token(TokenType.CloseParenthesis),
                    new Token(TokenType.Semicolon),
                }
            },
            {
                "if (x > 0 and y < 0 or z == 1) { }",
                new List<Token>
                {
                    new Token(TokenType.If),
                    new Token(TokenType.OpenParenthesis),
                    new Token(TokenType.Identifier, new TokenValue("x")),
                    new Token(TokenType.GreaterThan),
                    new Token(TokenType.Number, new TokenValue("0")),
                    new Token(TokenType.And),
                    new Token(TokenType.Identifier, new TokenValue("y")),
                    new Token(TokenType.LessThan),
                    new Token(TokenType.Number, new TokenValue("0")),
                    new Token(TokenType.Or),
                    new Token(TokenType.Identifier, new TokenValue("z")),
                    new Token(TokenType.EqualThan),
                    new Token(TokenType.Number, new TokenValue("1")),
                    new Token(TokenType.CloseParenthesis),
                    new Token(TokenType.OpenBrace),
                    new Token(TokenType.CloseBrace),
                }
            },
            {
                "var a = 42; var b = -3.14;",
                new List<Token>
                {
                    new Token(TokenType.Var),
                    new Token(TokenType.Identifier, new TokenValue("a")),
                    new Token(TokenType.AssignThan),
                    new Token(TokenType.Number, new TokenValue("42")),
                    new Token(TokenType.Semicolon),
                    new Token(TokenType.Var),
                    new Token(TokenType.Identifier, new TokenValue("b")),
                    new Token(TokenType.AssignThan),
                    new Token(TokenType.Number, new TokenValue("-3.14")),
                    new Token(TokenType.Semicolon),
                }
            },
            {
                "var s1 = 'hello'; var s2 = 'It\\'s ok';",
                new List<Token>
                {
                    new Token(TokenType.Var),
                    new Token(TokenType.Identifier, new TokenValue("s1")),
                    new Token(TokenType.AssignThan),
                    new Token(TokenType.String, new TokenValue("hello")),
                    new Token(TokenType.Semicolon),
                    new Token(TokenType.Var),
                    new Token(TokenType.Identifier, new TokenValue("s2")),
                    new Token(TokenType.AssignThan),
                    new Token(TokenType.String, new TokenValue("It's ok")),
                    new Token(TokenType.Semicolon),
                }
            },
            {
                "x + y",
                new List<Token>
                {
                    new Token(TokenType.Identifier, new TokenValue("x")),
                    new Token(TokenType.PlusSign),
                    new Token(TokenType.Identifier, new TokenValue("y")),
                }
            },
            {
                "x - y",
                new List<Token>
                {
                    new Token(TokenType.Identifier, new TokenValue("x")),
                    new Token(TokenType.MinusSign),
                    new Token(TokenType.Identifier, new TokenValue("y")),
                }
            },
            {
                "x * y",
                new List<Token>
                {
                    new Token(TokenType.Identifier, new TokenValue("x")),
                    new Token(TokenType.MultiplySign),
                    new Token(TokenType.Identifier, new TokenValue("y")),
                }
            },
            {
                "x / y",
                new List<Token>
                {
                    new Token(TokenType.Identifier, new TokenValue("x")),
                    new Token(TokenType.DivideSign),
                    new Token(TokenType.Identifier, new TokenValue("y")),
                }
            },
            {
                "a == b != c < d <= e > f >= g",
                new List<Token>
                {
                    new Token(TokenType.Identifier, new TokenValue("a")),
                    new Token(TokenType.EqualThan),
                    new Token(TokenType.Identifier, new TokenValue("b")),
                    new Token(TokenType.NotEqualThan),
                    new Token(TokenType.Identifier, new TokenValue("c")),
                    new Token(TokenType.LessThan),
                    new Token(TokenType.Identifier, new TokenValue("d")),
                    new Token(TokenType.LessThanOrEqual),
                    new Token(TokenType.Identifier, new TokenValue("e")),
                    new Token(TokenType.GreaterThan),
                    new Token(TokenType.Identifier, new TokenValue("f")),
                    new Token(TokenType.GreaterThanOrEqual),
                    new Token(TokenType.Identifier, new TokenValue("g")),
                }
            },
            {
                "{ ( [ ; , : } ) ]",
                new List<Token>
                {
                    new Token(TokenType.OpenBrace),
                    new Token(TokenType.OpenParenthesis),
                    new Token(TokenType.OpenBracket),
                    new Token(TokenType.Semicolon),
                    new Token(TokenType.Comma),
                    new Token(TokenType.Colon),
                    new Token(TokenType.CloseBrace),
                    new Token(TokenType.CloseParenthesis),
                    new Token(TokenType.CloseBracket),
                }
            },
            {
                """
                # однострочный комментарий
                var x = 1;
                """,
                new List<Token>
                {
                    new Token(TokenType.Var),
                    new Token(TokenType.Identifier, new TokenValue("x")),
                    new Token(TokenType.AssignThan),
                    new Token(TokenType.Number, new TokenValue("1")),
                    new Token(TokenType.Semicolon),
                }
            },
            {
                """
                /* многострочный
                   комментарий */
                var y = 2;
                """,
                new List<Token>
                { 
                    new Token(TokenType.Var),
                    new Token(TokenType.Identifier, new TokenValue("y")),
                    new Token(TokenType.AssignThan),
                    new Token(TokenType.Number, new TokenValue("2")),
                    new Token(TokenType.Semicolon),
                }

            },
        };
    }

    private List<Token> Tokenize(string source)
    {
        List<Token> results = [];
        Lexer lexer = new(source);

        for (Token token = lexer.ParseToken(); token.Type != TokenType.EndOfFile; token = lexer.ParseToken())
        {
            results.Add(token);
        }

        return results;
    }
}
