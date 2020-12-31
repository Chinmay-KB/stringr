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
    expect("Happy new year".graphemeAt(1), "a");
    expect("cafe\u0301".graphemeAt(3), "e\u0301");
    expect("\uD835\uDC00\uD835\uDC01".graphemeAt(1), "\uD835\uDC01");
  });
}
