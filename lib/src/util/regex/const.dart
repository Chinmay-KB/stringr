/// A regular expression string matching digits
const digit = '0-9';

/// A regular expression string matching whitespace
const whitespace = 's\uFEFF\xA0';

/// A regular expression string matching high surrogate
const highSurrogate = '\uD800-\uDBFF';

/// A regular expression string matching low surrogate
const lowSurrogate = '\uDC00-\uDFFF';

/// A regular expression string matching diacritical mark
const diacriticalMark =
    '\u0300-\u036F\u1AB0-\u1AFF\u1DC0-\u1DFF\u20D0-\u20FF\uFE20-\uFE2F';

/// A regular expression to match the base character for a combining mark
const base =
    '0-\u02FF\u0370-\u1AAF\u1B00-\u1DBF\u1E00-\u20CF\u2100-\uD7FF\uE000-\uFE1F\uFE30-\uFFFF';

/// Regular expression to match combining marks
final regexpCombiningMarks = RegExp(
    '([$base]|[$highSurrogate][$lowSurrogate]|[$highSurrogate](?![$lowSurrogate])|(?:[^$highSurrogate]|^)[$lowSurrogate])([$diacriticalMark]+)');

/// Regular expression to match surrogate pairs
///
/// @see http://www.unicode.org/faq/utf_bom.html#utf16-2
// final regexpSurrogatePairs =
//     new RegExp('([' + highSurrogate + '])([' + lowSurrogate + '])', 'g');

/// Regular expression to match a unicode character
final regexpUnicodeCharacter = RegExp(
    '((?:[$base]|[$highSurrogate][$lowSurrogate]|[$highSurrogate](?![$lowSurrogate])|(?:[^$highSurrogate]|^)[$lowSurrogate])(?:[$diacriticalMark]+))|([$highSurrogate][$lowSurrogate])|([\n\r\u2028\u2029])|(.)');

/// Regular expression to match whitespaces
final regexpWhitespace = RegExp('[$whitespace]');

/// Regular expression to match whitespaces from the left side

final regexpTrimLeft = RegExp('^[$whitespace]+');

/// Regular expression to match whitespaces from the right side
final regexpTrimRight = RegExp('[$whitespace]+\$');

/// Regular expression to match digit characters
final regexpDigit = RegExp('^$digit+\$');

/// Regular expression to match regular expression special characters
final regexpSpecialCharacters = RegExp(r"[-\[\]{}()*+!<=:?.\\^$|#,]");

/// Regular expression to match not latin characters
const regexpNonLatin = "[^A-Za-z0-9]";

/// Regular expression to match HTML special characters.
final regexpHtmlSpecialCharacters = RegExp(r'[<>&"' "'" '`]');

/// Regular expression to match sprintf format string
const regexpConversionSpecification =
    "/(%{1,2})(?:(d+)\$)?(+)?([ 0]|'.{1})?(-)?(d+)?(?:.(d+))?([bcdiouxXeEfgGs])?/g";

/// Regular expression to match trailing zeros in a number
const regexpTrailingZeros = "/.?0+\$/g";

/// Regular expression to match flags from a regular expression.
const regexpFlags = "/[gimuy]*\$/";

/// Regular expression to match a list of tags.
///
/// @see https://html.spec.whatwg.org/multipage/syntax.html#syntax-tag-name
const regexpTagList = "/<([A-Za-z0-9]+)>/g";
