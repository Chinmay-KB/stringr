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
                ? (word!.isUpperCase() ? word : word.lowerCase())
                : word!.lowerCase()
            : word!.capitalize(),
      )
      .toList()
      .join();

  /// Capitalizes the first character of the string
  ///
  /// If [capitalizeAll] is set to `true`, the whole string is converted to
  /// uppercase. It is set to `false` by default
  String capitalize({bool capitalizeAll = false}) {
    if (capitalizeAll) {
      return upperCase();
    } else {
      return isEmpty ? "" : this[0].upperCase() + substring(1);
    }
  }

  /// Decapitalizes the first character of the string
  ///
  /// If [decapitalizeAll] is set to `true`, the whole string is converted to
  /// uppercase. It is set to `false` by default
  String decapitalize({bool decapitalizeAll = false}) {
    if (decapitalizeAll) {
      return lowerCase();
    } else {
      return isEmpty ? "" : this[0].lowerCase() + substring(1);
    }
  }

  /// Converts a string to kebab-case
  String kebabCase() =>
      words().mapIndex((word, index) => word!.lowerCase()).join("-");

  /// Converts the whole string to lowercase
  String lowerCase() => toLowerCase();

  /// Converts the whole string to uppercase
  String upperCase() => toUpperCase();

  /// Converts string to snake_case
  String snakeCase() =>
      words().mapIndex((word, index) => word!.lowerCase()).join("_");

  /// Converts uppercase characters of a string to lowercase and vice versa
  String swapCase() => split('')
      .map((e) => e.isAlphabet()
          ? e.isLowerCase()
              ? e.upperCase()
              : e.lowerCase()
          : e)
      .join();

  /// Capitalizes the first letter of each word
  String titleCase() {
    final wordsRegExp = RegExp(regexpExtendedAscii).hasMatch(this)
        ? regexpLatinWord
        : regexpWord;
    return replaceAllMapped(
        RegExp(wordsRegExp), (match) => match.group(0)!.capitalize());
  }
}
