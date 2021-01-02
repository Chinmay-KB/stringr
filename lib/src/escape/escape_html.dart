import '../util/regex/const.dart';

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
  String escapeHTML() => this
      .split('')
      .map((e) => REGEXP_HTML_SPECIAL_CHARACTERS.hasMatch(e)
          ? _escapeCharactersMap[e]
          : e)
      .join();
  
  /// Return the HTML escaped version of a string
  String escapeRegExp() => this
      .split('')
      .map((e) => REGEXP_SPECIAL_CHARACTERS.hasMatch(e)
          ? r'\\'+e
          : e)
      .join();
}
