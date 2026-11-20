import 'package:stringr/stringr.dart';
import 'package:test/test.dart';

void main() {
  test("should split the string into words", () {
    expect("2650".words(), ["2650"]);
    expect("07/10/98".words(), ["07", "10", "98"]);
    expect("  juan  ".words(), ["juan"]);
    expect("2infinity*@#@AND93beyond".words(),
        ["2", "infinity", "AND", "93", "beyond"]);
    expect("foo\u0303\u035C\u035D\u035E bar".words(),
        ['foo\u0303\u035C\u035D\u035E', 'bar']);
    expect("1234567890".words(pattern: r"\d"),
        ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']);
    expect("gravity".words(pattern: r"\w{1,2}"), ['gr', 'av', 'it', 'y']);
    expect("gravity can cross dimensions".words(pattern: r"\w+(?=\s?)"), [
      'gravity',
      'can',
      'cross',
      'dimensions',
    ]);
  });

  test("should accept both String and RegExp patterns", () {
    expect('a-b c'.words(pattern: RegExp(r'\w+')), ['a', 'b', 'c']);
    expect('a-b c'.words(pattern: r'\w+'), ['a', 'b', 'c']);
    expect('Ab-cD'.words(pattern: RegExp('[a-z]+')), ['b', 'c']);
    expect('Ab-cD'.words(pattern: RegExp('[a-z]+', caseSensitive: false)),
        ['Ab', 'cD']);
    expect('1234567890'.words(pattern: RegExp(r'\d{1,3}')),
        ['123', '456', '789', '0']);
    expect('a-b c'.countWords(pattern: r'\w+'), 3);
  });

  test("an empty pattern keeps the default word splitting", () {
    expect('hello big-world'.words(), ['hello', 'big', 'world']);
    expect('XMLHttpRequest'.words(), ['XML', 'Http', 'Request']);
  });

  test("should split a string into characters", () {
    expect("vada pav".chars(), ['v', 'a', 'd', 'a', ' ', 'p', 'a', 'v']);
    expect('1971'.chars(), ['1', '9', '7', '1']);
  });

  test("should split a string into code points", () {
    expect("stellar bomb".codePoints(), [
      0x73,
      0x74,
      0x65,
      0x6c,
      0x6c,
      0x61,
      0x72,
      0x20,
      0x62,
      0x6f,
      0x6d,
      0x62,
    ]);
    expect('\n\t'.codePoints(), [0xa, 0x9]);
    expect('man\u0303ana'.codePoints(),
        [0x6d, 0x61, 0x6e, 0x303, 0x61, 0x6e, 0x61]);
  });

  test("should return user perceived characters", () {
    expect('man\u0303ana'.graphemes(), ['m', 'a', 'n\u0303', 'a', 'n', 'a']);
    expect('foo\u0303\u035C\u035D\u035Ebar'.graphemes(), [
      'f',
      'o',
      'o\u0303\u035C\u035D\u035E',
      'b',
      'a',
      'r',
    ]);
  });
}
