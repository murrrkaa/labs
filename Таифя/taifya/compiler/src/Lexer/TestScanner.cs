using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lexer
{
    public class TestScanner
    {
        private readonly string _text;
        private int _position;
        public TestScanner(string text)
        {
            _text = text ?? throw new ArgumentNullException(nameof(text));
            _position = 0;
        }

        public char Peek(int n = 0)
        {
            int position = _position + n;
            return position >= _text.Length ? '\0' : _text[position];
        }

        public void Advance()
        {
            _position++;
        }

        public bool IsEnd()
        {
            return _position >= _text.Length;
        }
    }
}
