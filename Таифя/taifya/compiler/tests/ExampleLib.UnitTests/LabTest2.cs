using ExampleLib.UnitTests.Helpers;

using Xunit;

namespace ExampleLib.UnitTests;

public class Lab2Test1
{
    public static TheoryData<int, string> EasternArabicTestData =>
        new()
        {
            { 0, "٠" },
            { 1, "١" },
            { 2, "٢" },
            { 3, "٣" },
            { 4, "٤" },
            { 5, "٥" },
            { 6, "٦" },
            { 7, "٧" },
            { 8, "٨" },
            { 9, "٩" },
            { 2025, "٢٠٢٥" },
            { -12500, "-١٢٥٠٠" },
            { int.MaxValue, "٢١٤٧٤٨٣٦٤٧" },
            { int.MinValue, "-٢١٤٧٤٨٣٦٤٨" },
        };

    [Theory]
    [MemberData(nameof(EasternArabicTestData))]
    public void CanFormatEasternArabic(int input, string expected)
    {
        string actual = Lab2.FormatEasternArabic(input);
        Assert.Equal(expected, actual);
    }
}