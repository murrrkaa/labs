// src/Lexer/TokenValue.cs
using System.Globalization;

namespace Lexer;

public class TokenValue
{
    private readonly object _value;

    public TokenValue(string value)
    {
        _value = value ?? throw new ArgumentNullException(nameof(value));
    }

    public TokenValue(decimal value)
    {
        _value = value;
    }

    public override string ToString()
    {
        return _value switch
        {
            string s => s,
            decimal d => d.ToString(CultureInfo.InvariantCulture),
            _ => throw new NotImplementedException()
        };
    }

    public decimal ToDecimal()
    {
        return _value switch
        {
            string s => decimal.Parse(s, CultureInfo.InvariantCulture),
            decimal d => d,
            _ => throw new NotImplementedException()
        };
    }

    public override bool Equals(object? obj)
    {
        if (obj is TokenValue other)
        {
            return _value switch
            {
                string s => other._value is string os && s == os,
                decimal d => other._value is decimal od && d == od,
                _ => false
            };
        }
        return false;
    }

    public override int GetHashCode()
    {
        return _value?.GetHashCode() ?? 0;
    }
}