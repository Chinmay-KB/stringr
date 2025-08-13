import 'package:stringr/stringr.dart';
import 'package:test/test.dart';

void main() {
  test("camelCase", () {
    expect("camel case".camelCase(), "camelCase");
  });
}
