import '../util/strings/strings.dart';
import '../util/object/extended_iterable.dart';
import '../split/words.dart';

/// Extension function bundling all functionalities related to case manipulation
/// [camelCase()]
extension Case on String {
  ///Changes a string into camelCase
  ///
  ///To prevent acronyms from being converted to upper or lowercase,
  ///[preserveAcronym] can be set to `true`.
  String camelCase({bool preserveAcronym = false}) => this
      .words()
      .mapIndex(
        (word, index) => index == 0
            ? (preserveAcronym)
                ? (word.isUpperCase() ? word : word.lowerCase())
                : word.lowerCase()
            : word.capitalize(capitalizeAll: false),
      )
      .toList()
      .join();

  ///Capitalizes the first character of the string
  ///
  ///If [capitalizeAll] is set to `true`, the whole string is converted to
  ///uppercase. It is set to `false` by default
  String capitalize({bool capitalizeAll = false}) {
    if (capitalizeAll) {
      return this.upperCase();
    } else {
      if (this.length == 0)
        return this.upperCase();
      else
        return this[0].upperCase() + this.substring(1);
    }
  }

  ///Decapitalizes the first character of the string
  ///
  ///If [decapitalizeAll] is set to `true`, the whole string is converted to
  ///uppercase. It is set to `false` by default
  String decapitalize({bool decapitalizeAll = false}) {
    if (decapitalizeAll) {
      return this.lowerCase();
    } else {
      if (this.length == 0)
        return this.upperCase();
      else
        return this[0].lowerCase() + this.substring(1);
    }
  }

  ///Converts a string to kebab-case
  String kebabCase() =>
      this.words().mapIndex((word, index) => word.lowerCase()).join("-");

  ///Converts the whole string to lowercase
  String lowerCase() => this.toLowerCase();

  ///Converts the whole string to uppercase
  String upperCase() => this.toUpperCase();

  ///Converts string to snake_case
  String snakeCase() =>
      this.words().mapIndex((word, index) => word.lowerCase()).join("_");

  ///Converts uppercase characters of a string to lowercase and vice versa
  String swapCase() => this
      .split('')
      .map((e) => e.isAlphabet()
          ? e.isLowerCase()
              ? e.upperCase()
              : e.lowerCase()
          : e)
      .join();

  ///Capitalizes the first letter of each word
  String titleCase() => this.words().map((e) => e.capitalize()).join(" ");
}
