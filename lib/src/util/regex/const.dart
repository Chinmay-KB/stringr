/// A regular expression string matching digits
final digit = '\\d';

/// A regular expression string matching whitespace
final whitespace = '\\s\\uFEFF\\xA0';

/// A regular expression string matching high surrogate
final highSurrogate = '\\uD800-\\uDBFF';

/// A regular expression string matching low surrogate
final lowSurrogate = '\\uDC00-\\uDFFF';

/// A regular expression string matching diacritical mark
final diacriticalMark =
    '\\u0300-\\u036F\\u1AB0-\\u1AFF\\u1DC0-\\u1DFF\\u20D0-\\u20FF\\uFE20-\\uFE2F';

/// A regular expression to match the base character for a combining mark
final base =
    '\\0-\\u02FF\\u0370-\\u1AAF\\u1B00-\\u1DBF\\u1E00-\\u20CF\\u2100-\\uD7FF\\uE000-\\uFE1F\\uFE30-\\uFFFF';

/// Regular expression to match combining marks
final REGEXP_COMBINING_MARKS = new RegExp('([' +
    base +
    ']|[' +
    highSurrogate +
    '][' +
    lowSurrogate +
    ']|[' +
    highSurrogate +
    '](?![' +
    lowSurrogate +
    '])|(?:[^' +
    highSurrogate +
    ']|^)[' +
    lowSurrogate +
    '])([' +
    diacriticalMark +
    ']+)');

/// Regular expression to match surrogate pairs
///
/// @see http://www.unicode.org/faq/utf_bom.html#utf16-2
// final REGEXP_SURROGATE_PAIRS =
//     new RegExp('([' + highSurrogate + '])([' + lowSurrogate + '])', 'g');

/// Regular expression to match a unicode character
final REGEXP_UNICODE_CHARACTER = new RegExp('((?:[' +
    base +
    ']|[' +
    highSurrogate +
    '][' +
    lowSurrogate +
    ']|[' +
    highSurrogate +
    '](?![' +
    lowSurrogate +
    '])|(?:[^' +
    highSurrogate +
    ']|^)[' +
    lowSurrogate +
    '])(?:[' +
    diacriticalMark +
    ']+))|\([' +
    highSurrogate +
    '][' +
    lowSurrogate +
    '])|\([\\n\\r\\u2028\\u2029])|\(.)');

/// Regular expression to match whitespaces
final REGEXP_WHITESPACE = new RegExp('[' + whitespace + ']');

/// Regular expression to match whitespaces from the left side

final REGEXP_TRIM_LEFT = new RegExp('^[' + whitespace + ']+');

/// Regular expression to match whitespaces from the right side
final REGEXP_TRIM_RIGHT = new RegExp('[' + whitespace + ']+\$');

/// Regular expression to match digit characters
final REGEXP_DIGIT = new RegExp('^' + digit + '+\$');

/// Regular expression to match regular expression special characters
final REGEXP_SPECIAL_CHARACTERS = RegExp(r"[-[\]{}()*+!<=:?./\\^\$|#,]");

/// Regular expression to match not latin characters
final REGEXP_NON_LATIN = "/[^A-Za-z0-9]/g";

/// Regular expression to match HTML special characters.
final REGEXP_HTML_SPECIAL_CHARACTERS = RegExp(r'[<>&"'"'"'`]');

/// Regular expression to match sprintf format string
final REGEXP_CONVERSION_SPECIFICATION =
    "/(%{1,2})(?:(\d+)\$)?(\+)?([ 0]|'.{1})?(-)?(\d+)?(?:\.(\d+))?([bcdiouxXeEfgGs])?/g";

/// Regular expression to match trailing zeros in a number
final REGEXP_TRAILING_ZEROS = "/\.?0+\$/g";

/// Regular expression to match flags from a regular expression.
final REGEXP_FLAGS = "/[gimuy]*\$/";

/// Regular expression to match a list of tags.
///
/// @see https://html.spec.whatwg.org/multipage/syntax.html#syntax-tag-name
final REGEXP_TAG_LIST = "/<([A-Za-z0-9]+)>/g";

