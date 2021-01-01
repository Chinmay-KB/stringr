import 'package:test/test.dart';
import 'package:stringr/stringr.dart';

void main() {
  test("should split the string into words", () {
    expect("2650".words(), ["2650"]);
    expect("07/10/98".words(), ["07", "10", "98"]);
    expect("  juan  ".words(), ["juan"]);
    expect("2infinity*@#@AND93beyond".words(),
        ["2", "infinity", "AND", "93", "beyond"]);
    expect("foo\u0303\u035C\u035D\u035E bar".words(),
        ['foo\u0303\u035C\u035D\u035E', 'bar']);
    // expect("1234567890".words(pattern: "/\d/g"),
    //     ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']);
  });
}
