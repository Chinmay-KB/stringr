import 'package:stringr/src/split/words.dart';
import 'package:stringr/src/util/object/extended_iterable.dart';
import 'package:stringr/src/util/regex/const_regex.dart';
import 'package:stringr/src/util/strings/strings.dart';

/// Extension bundling all functionalities related to case manipulation
extension Case on String {
  /// Changes a string into camelCase
  ///
  /// To prevent acronyms from being converted to upper or lowercase,
  /// [preserveAcronym] can be set to `true`.
  String camelCase({bool preserveAcronym = false}) => words()
      .mapIndex(
        (word, index) => index == 0
            ? preserveAcronym
                ? (word.isUpperCase() ? word : word.toLowerCase())
                : word.toLowerCase()
            : word.capitalize(),
      )
      .toList()
      .join();

  /// Capitalizes the first character of the string
  ///
  /// If [capitalizeAll] is set to `true`, the whole string is converted to
  /// uppercase. It is set to `false` by default
  String capitalize({bool capitalizeAll = false}) => switch (capitalizeAll) {
        true => toUpperCase(),
        false => isEmpty ? '' : this[0].toUpperCase() + substring(1),
      };

  /// Decapitalizes the first character of the string
  ///
  /// If [decapitalizeAll] is set to `true`, the whole string is converted to
  /// lowercase. It is set to `false` by default
  String decapitalize({bool decapitalizeAll = false}) =>
      switch (decapitalizeAll) {
        true => toLowerCase(),
        false => isEmpty ? '' : this[0].toLowerCase() + substring(1),
      };

  /// Converts a string to kebab-case
  String kebabCase() =>
      words().mapIndex((word, index) => word.toLowerCase()).join("-");

  /// Converts the whole string to lowercase
  @Deprecated('Use .toLowerCase() instead')
  String lowerCase() => toLowerCase();

  /// Converts the whole string to uppercase
  @Deprecated('Use .toUpperCase() instead')
  String upperCase() => toUpperCase();

  /// Converts string to snake_case
  String snakeCase() =>
      words().mapIndex((word, index) => word.toLowerCase()).join("_");

  /// Converts uppercase characters of a string to lowercase and vice versa
  String swapCase() {
    final buffer = StringBuffer();
    for (final char in runes) {
      final s = String.fromCharCode(char);
      buffer.write(s.isAlphabet()
          ? (s.isLowerCase() ? s.toUpperCase() : s.toLowerCase())
          : s);
    }
    return buffer.toString();
  }

  /// Capitalizes the first letter of each word
  String titleCase() {
    final wordsRegExp = RegExp(regexpExtendedAscii).hasMatch(this)
        ? regexpLatinWord
        : regexpWord;
    return replaceAllMapped(
        RegExp(wordsRegExp), (match) => match.group(0)!.capitalize());
  }

  // Convenience getters for common case conversions

  /// Converts to camelCase (getter form)
  String get toCamelCase => camelCase();

  /// Converts to snake_case (getter form)
  String get toSnakeCase => snakeCase();

  /// Converts to kebab-case (getter form)
  String get toKebabCase => kebabCase();

  /// Converts to Title Case (getter form)
  String get toTitleCase => titleCase();

  /// Converts to PascalCase (camelCase with first letter capitalized)
  String get toPascalCase => camelCase().capitalize();
}
