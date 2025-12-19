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
  String unescapeHtml() {
    var result = this;
    for (final entry in _unescapeCharactersMap.entries) {
      result = result.replaceAll(entry.key, entry.value);
    }
    return result;
  }

  /// Return the RegExp escaped version of a string
  String escapeRegExp() => split('')
      .map((e) => regexpSpecialCharacters.hasMatch(e) ? r'\\' + e : e)
      .join();

  /// Return the unescaped version of a regex-escaped string
  ///
  /// Removes escape sequences: `\\x` becomes `x`
  String unescapeRegExp() =>
      replaceAll(r'\\', r'\').replaceAll(r'\', '');

  /// Return the un-escaped version of a regex
  @Deprecated('Use unescapeRegExp instead (corrected implementation)')
  String unEscapeRegExp() => unescapeRegExp();
}
