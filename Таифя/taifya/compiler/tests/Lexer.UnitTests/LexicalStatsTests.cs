using System.IO;
using Xunit;
using Lexer.UnitTests.Helpers;

namespace Lexer.UnitTests;

public class LexicalStatsTests
{
    [Fact]
    public void Collects_stats_for_simple_program()
    {
        string source = """
                var x = 10;
                const name = 'Kate';
                if (x > 0) {
                    print('Hello world');
                }
                """;

        string expected = """
                keywords: 4
                identifier: 3
                number literals: 2
                string literals: 2
                operators: 3
                other lexemes: 9
                """.Trim();
        using TempFile file = TempFile.Create(source);
        string actual = LexicalStats.CollectFromFile(file.Path);
        Assert.Equal(expected.Replace("\r\n", "\n"), actual);
    }

    [Fact]
    public void Handles_empty_file()
    {
        string expected = """
                keywords: 0
                identifier: 0
                number literals: 0
                string literals: 0
                operators: 0
                other lexemes: 0
                """.Trim();

        using TempFile file = TempFile.Create("");
        string actual = LexicalStats.CollectFromFile(file.Path);
        Assert.Equal(expected.ReplaceLineEndings("\n"), actual);
    }

    [Fact]
    public void Сomments()
    {
        string source = """
                var x = 10; # another comment 
                /* multi
                   line */
                print('ok');
                """;

        string expected = """
                keywords: 2
                identifier: 1
                number literals: 1
                string literals: 1
                operators: 1
                other lexemes: 4
                """.Trim();

        using TempFile file = TempFile.Create(source);
        string actual = LexicalStats.CollectFromFile(file.Path);
        Assert.Equal(expected.Replace("\r\n", "\n"), actual);
    }
}