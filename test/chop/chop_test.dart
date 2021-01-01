import 'package:stringr/stringr.dart';
import 'package:test/test.dart';

void main() {
  test("should return unicode of the character at the index", () {
    expect("Gudguda".codePointAt(0), 0x0047);
    expect("man\u0303ana".codePointAt(2), 0x006e);
    expect("\uD835\uDC00\uD835\uDC01".codePointAt(0), 0x1d400);
    expect("\uD835\uDC00\uD835\uDC01".codePointAt(1), 0xdc00);
    expect("\uD835\uDC00\uD835\uDC01".codePointAt(2), 0x1d401);
    expect("\uD835\uDC00\uD835\uDC01".codePointAt(3), 0xdc01);
    expect(
        "foo\uD834\uDF06\u0303\u035C\u035D\u035Ebar\uD834\uDF06\u0303\u035C\u035D"
            .codePointAt(3),
        0x1d306);
    expect(
        "foo\uD834\uDF06\u0303\u035C\u035D\u035Ebar\uD834\uDF06\u0303\u035C\u035D"
            .codePointAt(12),
        0x1d306);
    expect(
        "foo\uD834\uDF06\u0303\u035C\u035D\u035Ebar\uD834\uDF06\u0303\u035C\u035D"
            .codePointAt(13),
        0xdf06);
  });

  test("should return the user perceived character(grapheme) by index", () {
    expect("Good day".graphemeAt(1), "o");
    expect("cafe\u0301".graphemeAt(3), "e\u0301");
    expect("\uD835\uDC00\uD835\uDC01".graphemeAt(1), "\uD835\uDC01");
    expect(
        "foo\uD834\uDF06\u0303\u035C\u035D\u035Ebar\uD834\uDF06\u0303\u035C\u035D"
            .graphemeAt(3),
        "\uD834\uDF06\u0303\u035C\u035D\u035E");
  });

  test("should prune a given string without breaking a word in between", () {
    expect("What is the problem is the".prune(10), "What is");
    expect("Привет как дела".prune(10), "Привет как");
    expect(
        "La variété la plus fréquente est la blanche".prune(12), "La variété");
    expect("in delhi".prune(20), "in delhi");
  });

  test("should return the character at the index", () {
    expect("What is the".charAt(0), "W");
  });

  test("should return the first some part of the string", () {
    expect("What is the problem is the".first(10), "What is th");
    expect(
        "What is the problem is the".first(1000), "What is the problem is the");
  });

  test("should return the last some part of the string", () {
    expect("What is the problem is the".last(10), "lem is the");
    expect(
        "What is the problem is the".last(1000), "What is the problem is the");
  });

  test("should slice a string", () {
    expect("infinite loop".slice(9), "loop");
    expect("infinite loop".slice(9, 12), "loo");
  });

  test("truncate a string to a given length", () {
    expect("Is this where you wanna go".truncate(10), "Is this...");
    expect(
        "Is this where you wanna go, how much you wanna miss"
            .truncate(10, endString: "noi"),
        "Is thisnoi");
    expect("Little Red Riding Hood".truncate(8, endString: "(more)"), "Li(more)");
  });
}
