import 'package:stringr/stringr.dart';
import 'package:test/test.dart';

void main() {
  test(
      "should insert a provided string into the parent string at a provided index",
      () {
    expect("there".insert("Hullo ", 0), "Hullo there");
    expect("there".insert("hullo", 1), "thullohere");
    expect("there".insert("Hullo", 400), "there");
    expect("".insert("Hullo", 0), "Hullo");
  });

  test("should return the latinizes version of the string", () {
    expect("cafe\u0301".latinize(), 'cafe');
    expect("man\u0303ana".latinize(), 'manana');
    expect("anglikonų šiurkščios užrašinėti".latinize(),
        'anglikonu siurkscios uzrasineti');
    expect('Există peste 13.800 de localități în România'.latinize(),
        'Exista peste 13.800 de localitati in Romania');
  });

  test("should return reversed string", () {
    expect("Happy is sad".reverse(), "das si yppaH");
    expect("𝌆 bar mañana mañana".reverse(), 'anañam anañam rab 𝌆');
    expect('foo\uD834\uDF06\u0303\u035C\u035D\u035Ebar'.reverse(),
        'rab\uD834\uDF06\u0303\u035C\u035D\u035Eoof');
    expect('foo\u0303\u035C\u035D\u035Ebar'.reverse(),
        'rabo\u0303\u035C\u035D\u035Eof');
  });

  test("should return the slug of a string", () {
    expect('BirdFlight'.slugify(), 'bird-flight');
    expect('__BIRD___FLIGHT___'.slugify(), 'bird-flight');
    expect('zborul păsării'.slugify(), 'zborul-pasarii');
    expect('Україна розташована в південно-східній частині Європи'.slugify(),
        'ukrayina-roztashovana-v-pivdenno-shidnij-chastini-yevropi');
    expect('foo\u0303\u035C\u035D\u035E bar'.slugify(), 'foo-bar');
  });

  test(
      'should splice the string at a given position, number of characters and addition string',
      () {
    expect('sting like a bee'.splice(0, 0, 'you should '),
        'you should sting like a bee');
    expect('sting like a bee'.splice(4, 6, 'as'), 'sting as a bee');
    expect('sting like a bee'.splice(16, 0, 'float like a butterfly'),
        'float like a butterfly');
    expect('make the days count'.splice(19, -100, 'matter'), 'matter');
  });

  test("shoudl translate a string according to translations provided", () {
    expect("help".translate({"elp": "ola"}), "hola");
    expect("I am groot".translate({"I": "Me", "groot": "Yoda"}), "Me am Yoda");
  });

  test("translate replaces in a single pass without cascading", () {
    expect('ab'.translate({'a': 'b', 'b': 'c'}), 'bc');
    expect('abc'.translate({'a': 'b', 'b': 'a'}), 'bac');
    expect('aaa'.translate({'a': 'aa'}), 'aaaaaa');
  });

  test("translate prefers the longest key at a position", () {
    expect('abc'.translate({'a': 'X', 'ab': 'Y'}), 'Yc');
    expect('abc'.translate({'ab': 'Y', 'a': 'X'}), 'Yc');
    expect('abcd'.translate({'a': '1', 'abc': '3', 'ab': '2'}), '3d');
  });

  test("translate ignores empty keys and treats keys literally", () {
    expect('abc'.translate({'': 'X'}), 'abc');
    expect('abc'.translate({'': 'X', 'b': 'B'}), 'aBc');
    expect(''.translate({'a': 'b'}), '');
    expect('abc'.translate({}), 'abc');
    expect('a.c abc'.translate({'.': '!'}), 'a!c abc');
    expect(
        r'1+1 (a)'.translate({'+': 'plus', '(': '[', ')': ']'}), '1plus1 [a]');
  });

  test("latinize converts sharp s to ss", () {
    expect('straße'.latinize(), 'strasse');
    expect('Straße'.latinize(), 'Strasse');
    expect('STRAßE'.latinize(), 'STRAssE');
    expect('\u1E9E'.latinize(), 'SS');
    expect('café'.latinize(), 'cafe');
    expect('Hello, World 123'.latinize(), 'Hello, World 123');
    expect(''.latinize(), '');
    expect('straße'.slugify(), 'strasse');
  });

  test("insert never splits a grapheme cluster", () {
    expect('a😀b'.insert('X', 1), 'aX😀b');
    expect('a😀b'.insert('X', 2), 'aX😀b');
    expect('a😀b'.insert('X', 3), 'a😀Xb');
    expect('e\u0301a'.insert('X', 1), 'Xe\u0301a');
    expect('a\r\nb'.insert('X', 2), 'aX\r\nb');
    expect('👨‍👩‍👧'.insert('X', 4), 'X👨‍👩‍👧');
  });

  test("splice never splits a grapheme cluster", () {
    // splice(deleteCount, startPosition, replacement)
    expect('a😀b'.splice(0, 2, 'X'), 'aX😀b');
    expect('a😀b'.splice(1, 1, 'X'), 'aXb');
    expect('a😀b'.splice(1, 2, 'X'), 'aXb');
    expect('a😀b'.splice(2, 1, 'X'), 'aXb');
    expect('a😀b'.splice(1, 3, 'X'), 'a😀X');
    expect('a😀b'.splice(3, 1, 'X'), 'aX');
    expect('e\u0301a'.splice(1, 1, 'X'), 'Xa');
    expect('a😀b'.splice(0, -100, 'X'), 'Xa😀b');
  });

  test("splice clamps deleteCount to the end of the string", () {
    const huge = 0x7FFFFFFFFFFFFFFF;
    expect('hello'.splice(huge, 1, 'X'), 'hX');
    expect('hello'.splice(huge, 0, 'X'), 'X');
    expect('hello'.splice(99, 0, 'X'), 'X');
    expect('hello'.splice(99, 5, 'X'), 'helloX');
    expect('hello'.splice(99, 4, 'X'), 'hellX');
    expect('hello'.splice(5, 3, 'X'), 'helX');
    expect('hello'.splice(huge, -huge, 'X'), 'X');
    expect('hello'.splice(huge, 1 << 62, 'X'), 'helloX');
    expect('a😀b'.splice(huge, 1, 'X'), 'aX');
    expect('a😀b'.splice(huge, 2, 'X'), 'aX');
    expect('a😀b'.splice(huge, 3, 'X'), 'a😀X');
    expect('😀😀'.splice(huge, 2, 'X'), '😀X');
    expect('😀😀'.splice(huge, 0, 'X'), 'X');
    expect(''.splice(huge, 0, 'X'), 'X');
    expect(''.splice(3, 2, 'X'), 'X');
  });
}
