import 'package:stringr/stringr.dart';
import 'package:test/test.dart';

void main() {
  test("the string should be converted to camel case", () {
    expect("camel case".camelCase(), "camelCase");
    expect("Camel case is a Case closed in a Camel".camelCase(),
        "camelCaseIsACaseClosedInACamel");
    expect("this is HTML class".camelCase(), "thisIsHTMLClass");
    expect("HTML view".camelCase(preserveAcronym: true), "HTMLView");
    expect("21 jump street".camelCase(), "21JumpStreet");
    expect("42".camelCase(), "42");
    expect("XMLHttpRequest".camelCase(), "xmlHttpRequest");
    expect("XMLHttpRequest".camelCase(preserveAcronym: true), "XMLHttpRequest");
    expect("/home/Kb/code/stringr".camelCase(), "homeKbCodeStringr");
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
    expect("".capitalize(), "");
    expect("macBook".capitalize(), "MacBook");
    expect("яблоко".capitalize(), "Яблоко");
    expect("420".capitalize(), "420");
    expect("".capitalize(), "");
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
    expect("".decapitalize(), "");
  });

  test("the provided string should be converted to kebab-case", () {
    expect("I 42 Know".kebabCase(), "i-42-know");
    expect("Atmaram Tukaram Bhide".kebabCase(), "atmaram-tukaram-bhide");
    expect("@@@@".kebabCase(), "");
    expect("_____To____Be__".kebabCase(), "to-be");
    expect("ProjectStringr".kebabCase(), "project-stringr");
    expect("\n\n\n\n   ***\t\t".kebabCase(), "");
    expect("полет птицы".kebabCase(), "полет-птицы");
    expect(
        "skrzydło ptaka składa się".kebabCase(), "skrzydło-ptaka-składa-się");
  });

  test("the provided string should be converted to snake_case", () {
    expect("being alive".snakeCase(), "being_alive");
    expect("Being Alive".snakeCase(), "being_alive");
    expect("I 42 Know".snakeCase(), "i_42_know");
    expect("Atmaram Tukaram Bhide".snakeCase(), "atmaram_tukaram_bhide");
    expect("@@@@".snakeCase(), "");
    expect("_____To____Be__".snakeCase(), "to_be");
    expect("ProjectStringr".snakeCase(), "project_stringr");
    expect("\n\n\n\n   ***\t\t".snakeCase(), "");
    expect("полет птицы".snakeCase(), "полет_птицы");
    expect(
        "skrzydło ptaka składa się".snakeCase(), "skrzydło_ptaka_składa_się");
  });

  test("each case of each character of the string should be toggled", () {
    expect("toggleCase".swapCase(), "TOGGLEcASE");
    expect("toggle case".swapCase(), "TOGGLE CASE");
    expect("toggle 4 cases".swapCase(), "TOGGLE 4 CASES");
    expect("/home/Kb/code/stringr".swapCase(), "/HOME/kB/CODE/STRINGR");
    expect("XMLHttpRequest".swapCase(), "xmlhTTPrEQUEST");
  });

  test("the first character of each word should be capitalized", () {
    expect("Come with me".titleCase(), "Come With Me");
    expect("and you will be".titleCase(), "And You Will Be");
    expect("1n a world".titleCase(), "1N A World");
    expect("/home/Kb/code/stringr".titleCase(), "/Home/Kb/Code/Stringr");
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
