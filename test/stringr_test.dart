import 'package:test/test.dart';

import 'package:stringr/stringr.dart';

void main() {
  test("camelCase", () {
    expect("camel case".camelCase(), "camelCase");
  });
}
