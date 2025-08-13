import 'package:stringr/src/util/regex/const.dart';

final _escapeCharactersMap = {
  '<': '&lt;',
  '>': '&gt;',
  '&': '&amp;',
  '"': '&quot;',
  "'": '&#x27;',
  '`': '&#x60;',
};

/// Bundles all kinds of string escape conversions
extension Escape on String {
  /// Return the HTML escaped version of a string
  String escapeHTML() => split('')
      .map((e) =>
          regexpHtmlSpecialCharacters.hasMatch(e) ? _escapeCharactersMap[e] : e)
      .join();

  /// Return the HTML escaped version of a string
  String escapeRegExp() => split('')
      .map((e) => regexpSpecialCharacters.hasMatch(e) ? r'\\' + e : e)
      .join();

  /// Return the un-escaped version of a regex
  String unEscapeRegExp() =>
      replaceAll(r"\'''", r"'''").replaceAll(r"\\", r"\").replaceAll(r"\", r"");
}
