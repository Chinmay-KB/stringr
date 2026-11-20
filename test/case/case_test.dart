import 'dart:math';

import 'package:characters/characters.dart';
import 'package:stringr/src/util/regex/const_regex.dart';
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
    expect("HELLO".capitalize(), "Hello");
    expect("HeLLo".capitalize(), "Hello");
    expect("яблоко".capitalize(), "Яблоко");
    expect("420".capitalize(), "420");
    expect("".capitalize(), "");
  });

  test("capitalize and decapitalize never split a surrogate pair or grapheme",
      () {
    // Deseret small letter long i (astral, has an uppercase form)
    expect("\u{10428}abc".capitalize(), "\u{10400}abc");
    expect("\u{10400}ABC".decapitalize(), "\u{10428}ABC");
    expect("\u{10400}ABC".capitalize(), "\u{10400}abc");
    expect("😀abc".capitalize(), "😀abc");
    expect("😀ABC".capitalize(), "😀abc");
    expect("😀ABC".decapitalize(), "😀ABC");
    expect("e\u0301abc".capitalize(), "E\u0301abc");
    expect("E\u0301ABC".decapitalize(), "e\u0301ABC");
    expect("\u{10428}".capitalize(), "\u{10400}");
    expect("é".capitalize(), "É");
    expect("a".capitalize(), "A");
    expect("A".decapitalize(), "a");
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

  test("titleCase keeps contraction suffixes lowercase", () {
    expect("it's a dog-friendly café".titleCase(), "It's A Dog-Friendly Café");
    expect("it\u2019s a dog".titleCase(), "It\u2019s A Dog");
    expect("IT'S".titleCase(), "It's");
    expect("DON'T".titleCase(), "Don't");
    expect("we'll".titleCase(), "We'll");
    expect("they\u2019ve".titleCase(), "They\u2019ve");
    expect("I'M YOU'RE HE'D WE'VE".titleCase(), "I'm You're He'd We've");
    expect("don't STOP believin'".titleCase(), "Don't Stop Believin'");
    expect("e\u0301's".titleCase(), "E\u0301's");
    expect("é's".titleCase(), "É's");
    expect("\u{10428}'s".titleCase(), "\u{10400}'s");
    expect("dog-friendly".titleCase(), "Dog-Friendly");
  });

  test("titleCase treats every other apostrophe like any other punctuation",
      () {
    expect("o'neil".titleCase(), "O'Neil");
    expect("d'angelo".titleCase(), "D'Angelo");
    expect("o\u2019brien".titleCase(), "O\u2019Brien");
    expect("l'été".titleCase(), "L'Été");
    expect("a'b'c".titleCase(), "A'B'C");
    expect("'hello'".titleCase(), "'Hello'");
    expect("rock 'n' roll".titleCase(), "Rock 'N' Roll");
    expect("'tis the season".titleCase(), "'Tis The Season");
    expect("it'sa".titleCase(), "It'Sa");
    expect("5's".titleCase(), "5'S");
  });

  test(
      "titleCase output equals the previous implementation without apostrophes",
      () {
    // Reference: the implementation before contraction handling.
    String reference(String text) {
      final words = RegExp(r'^[\x01-\xFF]*$').hasMatch(text)
          ? regexpLatinWord
          : regexpWord;
      return text.replaceAllMapped(
          RegExp(words), (match) => match.group(0)!.capitalize());
    }

    final random = Random(7);
    const alphabet = 'abcXYZ 019-_.é\u00DFÉяЯ中\u0301😀/\t\n';
    final characters = alphabet.characters.toList();
    for (var i = 0; i < 3000; i++) {
      final text = List.generate(random.nextInt(16),
          (_) => characters[random.nextInt(characters.length)]).join();
      expect(text.titleCase(), reference(text), reason: 'text "$text"');
    }
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
