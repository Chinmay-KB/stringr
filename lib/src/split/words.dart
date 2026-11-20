import 'package:characters/characters.dart';
import 'package:stringr/src/util/regex/const_regex.dart';

/// Extension function bundling all functionalities related to splitting a string
extension Words on String {
  /// Split a string into words. By default (empty [pattern]) it uses a Unicode
  /// aware word matcher, so `camelCase`, digits and non-Latin scripts are
  /// split into separate words.
  ///
  /// To use a custom matcher, pass either a `String` holding a regular
  /// expression source or a ready made `RegExp` to [pattern]. The matches of
  /// the pattern are returned. A `RegExp` is used as is, so its flags (for
  /// example `caseSensitive` or `unicode`) are respected.
  List<String> words({Pattern pattern = ""}) {
    final Pattern matcher;
    if (pattern is String) {
      matcher = pattern.isEmpty ? defaultWordRegExp(this) : RegExp(pattern);
    } else {
      matcher = pattern;
    }
    return matcher.allMatches(this).map((e) => e.group(0)!).toList();
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
