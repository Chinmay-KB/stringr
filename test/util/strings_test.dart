import 'package:stringr/stringr.dart';
import 'package:test/test.dart';

void main() {
  test(
      "if a string which contains only alphabet characters, it should return true, else false",
      () {
    expect("hakunamatata".isAlphabet(), true);
    expect("hakunamat0t0".isAlphabet(), false);
    expect("42".isAlphabet(), false);
    expect("hakuna matata".isAlphabet(), false);
  });
}
