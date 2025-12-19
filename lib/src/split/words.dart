import 'package:characters/characters.dart';
import 'package:stringr/src/util/regex/const_regex.dart';

/// Extension function bundling all functionalities related to splitting a string
extension Words on String {
  /// Split a string according to a given pattern/regex. Splits on [" "] by
  /// default. To split according to a regex, pass the regex pattern string to
  /// [pattern] parameter
  List<String> words({Pattern pattern = ""}) {
    Pattern patternRegExp;
    if (pattern == "") {
      patternRegExp = RegExp(regexpExtendedAscii).hasMatch(this)
          ? regexpLatinWord
          : regexpWord;
    } else {
      patternRegExp = pattern;
    }
    return RegExp(patternRegExp.toString())
        .allMatches(this)
        .map((e) => e.group(0)!)
        .toList();
  }

  /// Splits a string into list of single characters
  @Deprecated('Use .split(\'\') instead')
  List<String> chars() => split('');

  /// Returns an array of unicode code point values
  @Deprecated('Use .codeUnits instead')
  List<int> codePoints() => codeUnits.toList();

  /// Returns an array of graphemes of the string
  List<String> graphemes() => characters.toList();
}
