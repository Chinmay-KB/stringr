import '../util/regex/const_regex.dart';
import 'package:characters/characters.dart';

/// Extension function bundling all functionalities related to splitting a string
extension Words on String {
  /// Split a string according to a given pattern/regex. Splits on [" "] by
  /// default. To split according to a regex, pass the regex pattern string to
  /// [regex] parameter
  List<String?> words({Pattern pattern = ""}) {
    Pattern patternRegExp;
    if (pattern == "")
      patternRegExp = RegExp(REGEXP_EXTENDED_ASCII).hasMatch(this)
          ? REGEXP_LATIN_WORD
          : REGEXP_WORD;
    else
      patternRegExp = pattern;
    return RegExp(patternRegExp.toString())
        .allMatches(this)
        .map((e) => e.group(0))
        .toList();
  }

  /// Splits a string into list of single characters
  List<String?> chars() => this.split('');

  /// Returns an array of unicode code point values
  List<int?> codePoints() => this.codeUnits;

  /// Returns an array of graphemes of the string
  List<String?> graphemes() => this.characters.toList();
}
