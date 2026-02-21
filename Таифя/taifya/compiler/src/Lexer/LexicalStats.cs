using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lexer
{
    public class LexicalStats
    {
        public static string CollectFromFile(string filePath)
        {
            if (!File.Exists(filePath))
                throw new FileNotFoundException($"File not found: {filePath}");

            string source = File.ReadAllText(filePath);
            return CollectFromSource(source);
        }

        public static string CollectFromSource(string source)
        {
            var lexer = new Lexer(source);

            int keywords = 0;
            int identifier = 0;
            int numberLiterals = 0;
            int stringLiterals = 0;
            int operators = 0;
            int otherLexemes = 0;

            Token token;
            do
            {
                token = lexer.ParseToken();
                if (token.Type == TokenType.EndOfFile)
                    continue;

                switch (token.Type)
                {
                    case TokenType.Var or TokenType.Const or TokenType.If or TokenType.Else
                        or TokenType.For or TokenType.While or TokenType.Function or TokenType.Return
                        or TokenType.Break or TokenType.Continue or TokenType.Print or TokenType.And or TokenType.Or:
                        keywords++;
                        break;

                    case TokenType.Identifier:
                        identifier++;
                        break;

                    case TokenType.Number:
                        numberLiterals++;
                        break;

                    case TokenType.String:
                        stringLiterals++;
                        break;

                    case TokenType.PlusSign or TokenType.MinusSign or TokenType.MultiplySign or TokenType.DivideSign
                        or TokenType.AssignThan or TokenType.EqualThan or TokenType.NotEqualThan
                        or TokenType.LessThan or TokenType.LessThanOrEqual or TokenType.GreaterThan or TokenType.GreaterThanOrEqual:
                        operators++;
                        break;

                    default:
                        otherLexemes++;
                        break;
                }
            }
            while (token.Type != TokenType.EndOfFile);

            return $"keywords: {keywords}\n" +
                   $"identifier: {identifier}\n" +
                   $"number literals: {numberLiterals}\n" +
                   $"string literals: {stringLiterals}\n" +
                   $"operators: {operators}\n" +
                   $"other lexemes: {otherLexemes}";
        }
    }
}
