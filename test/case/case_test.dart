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

  test(
      "the first character of the string should be converted to uppercase."
      "If capitalizeAll is set to true, then all characters are converted to "
      "uppercase.", () {
    expect("abaqus".capitalize(), "Abaqus");
    expect("abaqus is cool".capitalize(), "Abaqus is cool");
    expect("42 is life".capitalize(), "42 is life");
    expect("42 is life".capitalize(capitalizeAll: true), "42 IS LIFE");
    expect("excuse moi".capitalize(capitalizeAll: true), "EXCUSE MOI");
  });

  test(
      "the first character of the string should be converted to lowercase. "
      "If decapitalizeAll is set to true, then all characters are converted to "
      "uppercase.", () {
    expect("Abaqus".decapitalize(), "abaqus");
    expect("Abaqus is cool".decapitalize(), "abaqus is cool");
    expect("42 is life".decapitalize(), "42 is life");
    expect("42 IS LIFE".decapitalize(decapitalizeAll: true), "42 is life");
    expect("EXCUSE MOI".decapitalize(decapitalizeAll: true), "excuse moi");
  });

  test("the provided string should be converted to kebab-case", () {
    expect("I don't know".kebabCase(), "i-don't-know");
    expect("I 42 Know".kebabCase(), "i-42-know");
    expect("Atmaram Tukaram Bhide".kebabCase(), "atmaram-tukaram-bhide");
    expect("@@@@".kebabCase(), "@@@@");
  });

  test("the provided string should be converted to snake_case", () {
    expect("being alive".snakeCase(), "being_alive");
    expect("Being Alive".snakeCase(), "being_alive");
  });

  test("each case of each character of the string should be toggled", () {
    expect("toggleCase".swapCase(), "TOGGLEcASE");
    expect("toggle case".swapCase(), "TOGGLE CASE");
    expect("toggle 4 cases".swapCase(), "TOGGLE 4 CASES");
  });

  test("the first character of each word should be capitalized", () {
    expect("Come with me".titleCase(), "Come With Me");
    expect("and you'll be".titleCase(), "And You'll Be");
    expect("1n a world".titleCase(), "1n A World");
  });

  test("the string should be converted to uppercase", () {
    expect("of ".upperCase(), "OF ");
    expect("42".upperCase(), "42");
  });

  test("the string should be converted to lowercase", () {
    expect("Pure".lowerCase(), "pure");
    expect("1magiNati0n".lowerCase(), "1maginati0n");
  });
}
