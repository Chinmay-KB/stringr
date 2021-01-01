import 'package:test/test.dart';
import 'package:stringr/stringr.dart';

void main() {
  test("should count characters in a string", () {
    expect("a year without rain".count(), 19);
    expect("".count(), 0);
    expect("232".count(), 3);
  });

  test("should return number of graphemes (observable characters) in a string",
      () {
    expect("a year without rain".countGrapheme(), 19);
    expect("".countGrapheme(), 0);
    expect("232".countGrapheme(), 3);
    expect("\uD835\uDC00\uD835\uDC01".countGrapheme(), 2);
    expect("cafe\u0301".countGrapheme(), 4);
    expect("foo\uD834\uDF06\u0303\u035C\u035D\u035Ebar".countGrapheme(), 7);
  });

  test("should return the number of occurences of a substring in a string", () {
    expect("to be or not to be".countOccurences("to"), 2);
    expect("*******".countOccurences("**"), 3);
    expect("2647484".countOccurences("4"), 3);
  });

  test(
      "should return number of characters in a string when conditions are satisfied",
      () {
    expect("aBCdeFgH".countWhere((character) => character.isAlphabet()), 8);
    expect("aBCdeFgH".countWhere((character) => character.isUpperCase()), 4);
    expect("aBCdeFgH".countWhere((character) => character.isLowerCase()), 4);
  });

  test("should return the words in a string", () {
    expect("123123".countWords(), 1);
    expect("1/1/2021".countWords(), 3);
    expect("    juan    ".countWords(), 1);
    expect("reality can be whatever I want".countWords(), 6);
    expect("reality can be whatever I want".kebabCase().countWords(), 6);
    expect("NewDelhi".countWords(), 2);
    expect("clasificación biológica".countWords(), 2);
    //expect("123456".countWords(pattern: "/\d/g"), 6);
  });
}
