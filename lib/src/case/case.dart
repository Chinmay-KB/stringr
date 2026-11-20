import 'package:stringr/src/split/words.dart';
import 'package:stringr/src/util/object/extended_iterable.dart';
import 'package:stringr/src/util/regex/const_regex.dart';
import 'package:stringr/src/util/strings/grapheme_boundary.dart';
import 'package:stringr/src/util/strings/strings.dart';
import 'package:stringr/src/util/strings/surrogate_pair.dart';

const _apostrophes = {"'", '\u2019'};
const _contractionSuffixes = {'s', 't', 'd', 'm', 'll', 're', 've'};
final _letter = RegExp(r'\p{L}', unicode: true);
final _mark = RegExp(r'\p{M}', unicode: true);

/// Whether the text before [end] ends with a letter, optionally followed by
/// combining marks. Handles astral (surrogate pair) letters.
bool _endsWithLetter(String text, int end) {
  var index = end;
  while (index > 0) {
    var start = index - 1;
    if (start > 0 &&
        text.codeUnitAt(start).isLowSurrogate() &&
        text.codeUnitAt(start - 1).isHighSurrogate()) {
      start--;
    }
    final character = text.substring(start, index);
    if (_mark.hasMatch(character)) {
      index = start;
      continue;
    }
    return _letter.hasMatch(character);
  }
  return false;
}

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
            : word.isUpperCase()
                ? word
                : word.capitalize(),
      )
      .toList()
      .join();

  /// Capitalizes the first character of the string
  ///
  /// The "first character" is the first grapheme cluster, so a leading
  /// surrogate pair or a base letter with combining marks is never split.
  ///
  /// If the first character is already uppercase (or has no case, like a
  /// digit) the rest of the string is lowercased (`HELLO` becomes `Hello`);
  /// otherwise the rest of the string is kept as is (`macBook` becomes
  /// `MacBook`).
  ///
  /// If [capitalizeAll] is set to `true`, the whole string is converted to
  /// uppercase. It is set to `false` by default
  String capitalize({bool capitalizeAll = false}) {
    if (capitalizeAll) {
      return toUpperCase();
    }
    if (isEmpty) {
      return '';
    }
    final end = graphemeCeil(this, 1);
    final head = substring(0, end);
    final upperHead = head.toUpperCase();
    return head == upperHead
        ? upperHead + substring(end).toLowerCase()
        : upperHead + substring(end);
  }

  /// Decapitalizes the first character of the string
  ///
  /// The "first character" is the first grapheme cluster, so a leading
  /// surrogate pair or a base letter with combining marks is never split.
  ///
  /// If [decapitalizeAll] is set to `true`, the whole string is converted to
  /// lowercase. It is set to `false` by default
  String decapitalize({bool decapitalizeAll = false}) {
    if (decapitalizeAll) {
      return toLowerCase();
    }
    if (isEmpty) {
      return '';
    }
    final end = graphemeCeil(this, 1);
    return substring(0, end).toLowerCase() + substring(end);
  }

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
  ///
  /// A word that directly follows an apostrophe (`'` or `\u2019`) which itself
  /// directly follows a letter is treated as a contraction suffix when it is,
  /// ignoring case, one of `s`, `t`, `d`, `m`, `ll`, `re` or `ve`. Such a
  /// suffix is lowercased instead of capitalized: `it's` and `IT'S` become
  /// `It's`, `we'll` becomes `We'll`. Every other apostrophe is treated like
  /// any other punctuation, so `o'neil` becomes `O'Neil` and `l'été` becomes
  /// `L'Été`.
  String titleCase() => replaceAllMapped(defaultWordRegExp(this), (match) {
        final word = match.group(0)!;
        final start = match.start;
        if (start >= 2 &&
            _apostrophes.contains(this[start - 1]) &&
            _contractionSuffixes.contains(word.toLowerCase()) &&
            _endsWithLetter(this, start - 1)) {
          return word.toLowerCase();
        }
        return word.capitalize();
      });

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
