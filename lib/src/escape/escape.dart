import 'package:stringr/src/util/regex/const.dart';

const _escapeCharactersMap = {
  '<': '&lt;',
  '>': '&gt;',
  '&': '&amp;',
  '"': '&quot;',
  "'": '&#x27;',
  '`': '&#x60;',
};

const _unescapeCharactersMap = {
  '&lt;': '<',
  '&gt;': '>',
  '&amp;': '&',
  '&quot;': '"',
  '&#x27;': "'",
  '&#39;': "'",
  '&#x60;': '`',
  '&apos;': "'",
};

final _htmlEntity =
    RegExp(_unescapeCharactersMap.keys.map(RegExp.escape).join('|'));

final _backslashEscape = RegExp(r'\\([\s\S])');

/// Bundles all kinds of string escape conversions
extension Escape on String {
  /// Return the HTML escaped version of a string
  String escapeHtml() => split('')
      .map((e) =>
          regexpHtmlSpecialCharacters.hasMatch(e) ? _escapeCharactersMap[e] : e)
      .join();

  /// Return the HTML escaped version of a string
  @Deprecated('Use escapeHtml instead (camelCase naming)')
  String escapeHTML() => escapeHtml();

  /// Return the unescaped HTML version of a string
  ///
  /// Entities are decoded in a single pass, so an escaped entity is decoded
  /// only once: `&amp;quot;` becomes `&quot;`, not `"`.
  String unescapeHtml() => replaceAllMapped(
      _htmlEntity, (match) => _unescapeCharactersMap[match[0]]!);

  /// Return the RegExp escaped version of a string
  ///
  /// Every regular expression special character gets a single leading
  /// backslash, so `RegExp(text.escapeRegExp())` matches `text` literally:
  /// `'a.b'.escapeRegExp()` is `a\.b`. The escaped characters are
  /// `- [ ] { } ( ) * + ! < = : ? . \ ^ $ | # ,`. The result is meant for
  /// Dart's default (non unicode) `RegExp` mode.
  String escapeRegExp() =>
      replaceAllMapped(regexpSpecialCharacters, (match) => '\\${match[0]}');

  /// Return the unescaped version of a regex-escaped string
  ///
  /// The inverse of [escapeRegExp]: removes one leading backslash from every
  /// backslash pair, so `\.` becomes `.` and `\\` becomes `\`. A trailing
  /// lone backslash is kept.
  String unescapeRegExp() =>
      replaceAllMapped(_backslashEscape, (match) => match[1]!);

  /// Return the un-escaped version of a regex
  @Deprecated('Use unescapeRegExp instead (corrected implementation)')
  String unEscapeRegExp() => unescapeRegExp();
}
