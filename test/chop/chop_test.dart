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
    expect(
        "Little Red Riding Hood".truncate(8, endString: "(more)"), "Li(more)");
  });

  test("truncate never throws when the length is smaller than endString", () {
    expect('hello world'.truncate(2), '..');
    expect('hello world'.truncate(0), '');
    expect('hello world'.truncate(-5), '');
    expect('hello world'.truncate(3), '...');
    expect('hello world'.truncate(4), 'h...');
    expect('hello world'.truncate(1, endString: 'abc'), 'a');
    expect('hello world'.truncate(5, endString: ''), 'hello');
    expect('hello world'.truncate(11), 'hello world');
    expect('hello world'.truncate(50), 'hello world');
    expect(''.truncate(0), '');
  });

  test("first and last never split a grapheme cluster", () {
    expect('😀abc'.first(1), '');
    expect('😀abc'.first(2), '😀');
    expect('😀abc'.first(3), '😀a');
    expect('abc😀'.last(1), '');
    expect('abc😀'.last(2), '😀');
    expect('abc😀'.last(3), 'c😀');
    expect('e\u0301abc'.first(1), '');
    expect('e\u0301abc'.first(2), 'e\u0301');
    expect('abce\u0301'.last(1), '');
    expect('abce\u0301'.last(2), 'e\u0301');
    expect('a👨‍👩‍👧b'.first(5), 'a');
    expect('a👨‍👩‍👧b'.first(9), 'a👨‍👩‍👧');
    expect('a👨‍👩‍👧b'.last(2), 'b');
    expect('a👨‍👩‍👧b'.last(9), '👨‍👩‍👧b');
    expect('a\r\nb'.first(2), 'a');
    expect('abc'.first(0), '');
    expect('abc'.first(-1), '');
    expect('abc'.last(0), '');
    expect('abc'.last(-1), '');
  });

  test("truncate never splits a grapheme cluster", () {
    expect('😀😀😀😀😀'.truncate(7), '😀😀...');
    expect('😀😀😀😀😀'.truncate(6), '😀...');
    expect('😀😀😀😀😀'.truncate(4), '...');
    expect('👨‍👩‍👧 family photo'.truncate(10), '...');
    expect('👨‍👩‍👧 family photo'.truncate(11), '👨‍👩‍👧...');
    expect('cafe\u0301 au lait'.truncate(7), 'caf...');
    expect('cafe\u0301 au lait'.truncate(8), 'cafe\u0301...');
    expect('ab😀'.truncate(3, endString: ''), 'ab');
    expect('😀😀'.truncate(2), '..');
  });

  test("prune never splits a grapheme cluster", () {
    expect('😀😀😀😀'.prune(3), '😀');
    expect('a 😀😀 b'.prune(4), 'a');
    expect('😀 hello'.prune(2), '😀');
    expect('cafe\u0301 au lait'.prune(4), 'caf');
    expect('cafe\u0301 au lait'.prune(5), 'cafe\u0301');
    expect('abc'.prune(-1), '');
    expect(''.prune(-1), '');
  });
}
