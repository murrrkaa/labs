using System;
using System.Text;

namespace Lexer;

public class Lexer
{

    private static readonly Dictionary<string, TokenType> Keywords = new()
    {
        { "var", TokenType.Var },
        { "const", TokenType.Const },
        { "if", TokenType.If },
        { "else", TokenType.Else},
        { "for", TokenType.For },
        { "while", TokenType.While },
        { "function", TokenType.Function },
        { "return", TokenType.Return },
        { "break", TokenType.Break },
        { "continue", TokenType.Continue },
        { "print", TokenType.Print },
        { "and", TokenType.And },
        { "or", TokenType.Or }


    };
    private readonly TestScanner _scanner;
    public Lexer(string text)
    {
        _scanner = new TestScanner(text);
    }

    public Token ParseToken()
    {
        SkipWhiteSpacesAndComments();

        if(_scanner.IsEnd())
        {
            return new Token(TokenType.EndOfFile);
        }

        char ch = _scanner.Peek();

        if (char.IsLetter(ch))
        {
            return ParseIdentifierOrKeywords();
        }

        if (char.IsDigit(ch) || ch == '-')
        {
            if (ch == '-' && char.IsDigit(_scanner.Peek(1)))
            {
                return ParseNumericLiteral();
            }

            if(char.IsDigit(ch))
            {
                return ParseNumericLiteral();
            }
        }
        
        if(ch == '\'')
        {
            return ParseStringLiteral();
        }

        switch (ch)
        {
            case ';': 
                _scanner.Advance(); 
                return new Token(TokenType.Semicolon);
            case ',': 
                _scanner.Advance(); 
                return new Token(TokenType.Comma);
            case ':': 
                _scanner.Advance(); 
                return new Token(TokenType.Colon);
            case '{': 
                _scanner.Advance(); 
                return new Token(TokenType.OpenBrace);
            case '}': 
                _scanner.Advance(); 
                return new Token(TokenType.CloseBrace);
            case '(': 
                _scanner.Advance(); 
                return new Token(TokenType.OpenParenthesis);
            case ')': 
                _scanner.Advance(); 
                return new Token(TokenType.CloseParenthesis);
            case '[': 
                _scanner.Advance(); 
                return new Token(TokenType.OpenBracket);
            case ']': 
                _scanner.Advance(); 
                return new Token(TokenType.CloseBracket);
            case '+': 
                _scanner.Advance(); 
                return new Token(TokenType.PlusSign);
            case '*': 
                _scanner.Advance(); 
                return new Token(TokenType.MultiplySign);
            case '/': 
                _scanner.Advance(); 
                return new Token(TokenType.DivideSign);

            case '=':
                _scanner.Advance();
                if (_scanner.Peek() == '=')
                {
                    _scanner.Advance();
                    return new Token(TokenType.EqualThan);
                }
                return new Token(TokenType.AssignThan);

            case '!':
                _scanner.Advance();
                if (_scanner.Peek() == '=')
                {
                    _scanner.Advance();
                    return new Token(TokenType.NotEqualThan);
                }
                return new Token(TokenType.Error);

            case '<':
                _scanner.Advance();
                if (_scanner.Peek() == '=')
                {
                    _scanner.Advance();
                    return new Token(TokenType.LessThanOrEqual);
                }
                return new Token(TokenType.LessThan);

            case '>':
                _scanner.Advance();
                if (_scanner.Peek() == '=')
                {
                    _scanner.Advance();
                    return new Token(TokenType.GreaterThanOrEqual);
                }
                return new Token(TokenType.GreaterThan);

            case '-':
                _scanner.Advance();
                return new Token(TokenType.MinusSign);

        }

        _scanner.Advance();
        return new Token(TokenType.Error, new TokenValue(ch.ToString()));

    }

    private Token ParseIdentifierOrKeywords()
    {
        StringBuilder value = new StringBuilder(); 
        value.Append(_scanner.Peek());
        _scanner.Advance();

        while (!_scanner.IsEnd())
        {
            char ch = _scanner.Peek();
            if(char.IsLetterOrDigit(ch))
            {
                value.Append(ch);
                _scanner.Advance();
            }
            else
            {
                break;
            }
        }

        string text = value.ToString();
        if(Keywords.TryGetValue(text, out TokenType type))
        {
            return new Token(type);
        }
        return new Token(TokenType.Identifier, new TokenValue(text));
    }

    private Token ParseStringLiteral()
    {
        _scanner.Advance(); 
        StringBuilder contents = new StringBuilder();

        while (!_scanner.IsEnd() && _scanner.Peek() != '\'')
        {
            if (_scanner.Peek() == '\\')
            {
                _scanner.Advance(); 
                if (_scanner.IsEnd())
                {
                    return new Token(TokenType.Error);
                }

                char next = _scanner.Peek();

                switch (next)
                {
                    case '\'':
                        contents.Append('\'');
                        _scanner.Advance();
                        break;
                    case '\\':
                        contents.Append('\\');
                        _scanner.Advance();
                        break;
                    case 'n':
                        contents.Append('\n');
                        _scanner.Advance();
                        break;
                    default:
                        return new Token(TokenType.Error);
                }
            }
            else
            {
                contents.Append(_scanner.Peek());
                _scanner.Advance();
            }
        }

        if (_scanner.IsEnd())
        {
            return new Token(TokenType.Error);
        }

        _scanner.Advance(); 
        return new Token(TokenType.String, new TokenValue(contents.ToString()));
    }

    private Token ParseNumericLiteral()
    {
        StringBuilder value = new StringBuilder();
        if (_scanner.Peek() == '-')
        {
            value.Append('-');
            _scanner.Advance();
        }

        while (!_scanner.IsEnd() && char.IsDigit(_scanner.Peek()))
        {
            value.Append(_scanner.Peek());
            _scanner.Advance();
        }

        if (value.Length == 0 || value.ToString() == "-")
        {
            return new Token(TokenType.Error, new TokenValue(value.ToString()));
        }

        if (!_scanner.IsEnd() && _scanner.Peek() == '.')
        {
            value.Append('.');
            _scanner.Advance();

            int fractionStart = value.Length; 

            while (!_scanner.IsEnd() && char.IsDigit(_scanner.Peek()))
            {
                value.Append(_scanner.Peek());
                _scanner.Advance();
            }

            if (value.Length == fractionStart)
            {
                return new Token(TokenType.Error, new TokenValue(value.ToString()));
            }
        }

        string numberText = value.ToString();
        return new Token(TokenType.Number, new TokenValue(numberText));
    }

    private void SkipWhiteSpacesAndComments()
    {
        do
        {
            SkipWhiteSpaces();
        }
        while (TryParseMultilineComment() || TryParseSingleLineComment());
    }

    private void SkipWhiteSpaces()
    {
        while (!_scanner.IsEnd() && char.IsWhiteSpace(_scanner.Peek()))
        {
            _scanner.Advance();
        }
    }
    private bool TryParseMultilineComment()
    {
        if(_scanner.Peek() == '/' && _scanner.Peek(1) == '*')
        {
            _scanner.Advance();
            _scanner.Advance(); 
            while (!_scanner.IsEnd())
            {
                if(_scanner.Peek() == '*' && _scanner.Peek(1) == '/')
                {
                    _scanner.Advance();
                    _scanner.Advance();
                    return true;
                }
                _scanner.Advance();
            }
            return true;
        }
        return false;
    }
    private bool TryParseSingleLineComment()
    {
        if(_scanner.Peek() == '#')
        {
            while(!_scanner.IsEnd() && _scanner.Peek() != '\n')
            {
                _scanner.Advance();
            }
            return true;
        }
        return false;
    }
}
