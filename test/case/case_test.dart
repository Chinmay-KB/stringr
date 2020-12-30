import 'package:test/test.dart';

import 'package:stringr/stringr.dart';

void main() {
  test("the string should be converted to camel case", () {
    expect("camel case".camelCase(), "camelCase");
    expect("Camel case is a Case closed in a Camel".camelCase(),
        "camelCaseIsACaseClosedInACamel");
    expect("this is HTML class".camelCase(), "thisIsHTMLClass");
    expect("HTML view".camelCase(preserveAcronym: true), "HTMLView");
    expect("21 jump street".camelCase(), "21JumpStreet");
    expect("42".camelCase(), "42");
  });
}
