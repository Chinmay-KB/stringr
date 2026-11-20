# stringr

[![pub package](https://img.shields.io/pub/v/stringr.svg)](https://pub.dev/packages/stringr)
[![codecov](https://codecov.io/gh/Chinmay-KB/stringr/branch/master/graph/badge.svg?token=UIWY4OF2TE)](https://codecov.io/gh/Chinmay-KB/stringr)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/Chinmay-KB/stringr/blob/master/LICENSE)

stringr is a Dart and Flutter package of `String` extension methods for case conversion (camelCase, snake_case, kebab-case, Title Case), URL slugs, removing diacritics, truncation, counting, word splitting and HTML escaping. It is for developers who need word splitting, case conversion and diacritic removal to work on accented and non-Latin text, and character counting and reversing to work on emoji, not only on plain ASCII. It is inspired by [VocaJS](https://vocajs.com/).

## Install

```sh
dart pub add stringr
```

For a Flutter project, run `flutter pub add stringr` instead. Then import it:

```dart
import 'package:stringr/stringr.dart';
```

stringr is pure Dart (its only dependency is [`characters`](https://pub.dev/packages/characters)) and requires Dart 3.0 or newer.

## Quick start

```dart
import 'package:stringr/stringr.dart';

void main() {
  print('XMLHttpRequest'.snakeCase()); // xml_http_request
  print('hello world'.toPascalCase); // HelloWorld
  print('Crème Brûlée & Café'.slugify()); // creme-brulee-cafe
  print('anglikonų šiurkščios'.latinize()); // anglikonu siurkscios
  print('The quick brown fox jumps'.prune(15)); // The quick brown
  print('café'.countGrapheme()); // 4
  print('ab👨‍👩‍👧‍👦c'.reverse()); // c👨‍👩‍👧‍👦ba
}
```

Every function is an extension method on `String`, so there is nothing to instantiate.

## How do I...

### Convert a string to camelCase, snake_case, kebab-case or Title Case in Dart?

Use `camelCase()`, `snakeCase()`, `kebabCase()` and `titleCase()`. Each also has a getter form (`toCamelCase`, `toSnakeCase`, `toKebabCase`, `toTitleCase`), and `toPascalCase` gives PascalCase. Input can be in any of these styles or a mix, because the string is split into words first.

```dart
print('XMLHttpRequest'.camelCase()); // xmlHttpRequest
print('XMLHttpRequest'.snakeCase()); // xml_http_request
print('XMLHttpRequest'.kebabCase()); // xml-http-request
print('user_first-name'.camelCase()); // userFirstName
print('fooBarBaz'.snakeCase()); // foo_bar_baz
print('the quick brown fox'.titleCase()); // The Quick Brown Fox
print('hello world'.toPascalCase); // HelloWorld
print('XMLHttpRequest'.camelCase(preserveAcronym: true)); // XMLHttpRequest
```

Non-Latin text works the same way:

```dart
print('Привет мир'.kebabCase()); // привет-мир
```

### Split a string into words in Dart?

`words()` splits on case changes, digits and punctuation, not only on spaces.

```dart
print('XMLHttpRequest'.words()); // [XML, Http, Request]
print('foo_bar-baz qux'.words()); // [foo, bar, baz, qux]
print('Hello, world! 2infinity&beyond'.words()); // [Hello, world, 2, infinity, beyond]
```

### Create a URL slug from a string in Dart?

`slugify()` removes diacritics, replaces anything that is not a letter or digit with a hyphen, and lowercases the result. Because it ends with `kebabCase()`, it also splits at case changes and between letters and digits, so `'JavaScript'` becomes `java-script`.

```dart
print('Hello World!'.slugify()); // hello-world
print('Crème Brûlée & Café au Lait'.slugify()); // creme-brulee-cafe-au-lait
print('  Dart: 10 Tips & Tricks!  '.slugify()); // dart-10-tips-tricks
print('Привет мир'.slugify()); // privet-mir
print('JavaScript'.slugify()); // java-script
print('abc123def'.slugify()); // abc-123-def
```

### Remove accents and diacritics from a string in Dart (latinize)?

`latinize()` replaces accented and some non-Latin letters with their closest Latin letters and drops combining diacritical marks.

```dart
print('café'.latinize()); // cafe
print('Crème Brûlée'.latinize()); // Creme Brulee
print('Åre Zürich Łódź'.latinize()); // Are Zurich Lodz
print('café'.latinize()); // cafe
print('Привет'.latinize()); // Privet
```

### Truncate a string without cutting a word in Dart?

`prune(length)` returns at most `length` characters and cuts at the last whitespace before that point. `truncate(length)` cuts at exactly `length` characters in total, including the ending string (default `...`).

```dart
print('The quick brown fox jumps'.prune(15)); // The quick brown
print('Привет как дела'.prune(10)); // Привет как
print('The quick brown fox jumps'.truncate(15)); // The quick br...
print('The quick brown fox jumps'.truncate(15, endString: '…')); // The quick brow…
```

### Count the words in a string in Dart?

```dart
print('Hello, how are you today?'.countWords()); // 5
print('camelCaseString'.countWords()); // 3
```

### Count occurrences of a substring in Dart?

```dart
print('banana'.countOccurrences('a')); // 3
print('banana'.countOccurrences('ana')); // 1
```

### Get the real length of a string with emoji or accents (count graphemes)?

`String.length` counts UTF-16 code units, so an emoji or a letter plus a combining accent can count as several. `countGrapheme()` counts what a reader sees as one character.

```dart
print('café'.length); // 5
print('café'.countGrapheme()); // 4
print('👨‍👩‍👧‍👦'.length); // 11
print('👨‍👩‍👧‍👦'.countGrapheme()); // 1
print('a👍🏽b'.graphemes()); // [a, 👍🏽, b]
print('ab👨‍👩‍👧‍👦c'.graphemeAt(2)); // 👨‍👩‍👧‍👦
```

### Reverse a string that contains emoji in Dart?

`reverse()` reverses by grapheme, so emoji and combined characters stay intact.

```dart
print('hello'.reverse()); // olleh
print('ab👨‍👩‍👧‍👦c'.reverse()); // c👨‍👩‍👧‍👦ba
print('a👍🏽b'.reverse()); // b👍🏽a
```

### Escape and unescape HTML in Dart?

`escapeHtml()` replaces `<`, `>`, `&`, `"`, `'` and `` ` `` with entities. `unescapeHtml()` reverses it.

```dart
print('<a href="x">Tom & Jerry</a>'.escapeHtml()); // &lt;a href=&quot;x&quot;&gt;Tom &amp; Jerry&lt;/a&gt;
print('&lt;p&gt;Tom &amp; Jerry&lt;/p&gt;'.unescapeHtml()); // <p>Tom & Jerry</p>
```

### Capitalize, decapitalize or swap the case of a string in Dart?

```dart
print('hello'.capitalize()); // Hello
print('hello'.capitalize(capitalizeAll: true)); // HELLO
print('Hello'.decapitalize()); // hello
print('Hello World'.swapCase()); // hELLO wORLD
```

### Insert text into a string at a position in Dart?

```dart
print('hllo'.insert('e', 1)); // hello
```

### Replace several substrings at once in Dart?

`translate()` replaces each map key with its value.

```dart
print('Hello world'.translate({'ell': 'ipp'})); // Hippo world
```

## Things to know

- **Grapheme-aware members.** `countGrapheme`, `graphemes`, `graphemeAt` and `reverse` work on graphemes (user-perceived characters). Other members index by UTF-16 code unit, as `String.length` does, so check the results on text with emoji or combining marks.
- **Word splitting.** The case-conversion methods, `words()` and `countWords()` use a regular expression that understands upper and lower case Latin letters (including accented ones), digits and punctuation. Text that is only in the Latin-1 range uses a Latin-specific pattern; other text uses a general Unicode pattern.
- **Extension methods.** Members live in extensions named `Case`, `Chop`, `Count`, `Escape`, `Manipulate`, `Words`, `Strings`, `Surrogates` and `ExtendedIterable`. If another package defines a clashing method, import only what you need, for example `import 'package:stringr/stringr.dart' show Case;`, or use `hide`.

## API reference

All members below are extension members on `String` unless noted. The source is in [`lib/src`](https://github.com/Chinmay-KB/stringr/tree/master/lib/src); full generated docs are on [pub.dev](https://pub.dev/documentation/stringr/latest/).

### Case (`extension Case on String`)

| Member | Returns | Description |
|---|---|---|
| `camelCase({bool preserveAcronym = false})` | `String` | Converts to camelCase. With `preserveAcronym: true`, an all-uppercase first word stays uppercase. |
| `snakeCase()` | `String` | Converts to snake_case. |
| `kebabCase()` | `String` | Converts to kebab-case. |
| `titleCase()` | `String` | Capitalizes the first letter of each word. |
| `capitalize({bool capitalizeAll = false})` | `String` | Uppercases the first character. With `capitalizeAll: true`, uppercases the whole string. |
| `decapitalize({bool decapitalizeAll = false})` | `String` | Lowercases the first character. With `decapitalizeAll: true`, lowercases the whole string. |
| `swapCase()` | `String` | Converts uppercase letters to lowercase and lowercase letters to uppercase. |
| `toCamelCase` | `String` (getter) | Same as `camelCase()`. |
| `toSnakeCase` | `String` (getter) | Same as `snakeCase()`. |
| `toKebabCase` | `String` (getter) | Same as `kebabCase()`. |
| `toTitleCase` | `String` (getter) | Same as `titleCase()`. |
| `toPascalCase` | `String` (getter) | PascalCase: `camelCase()` with the first letter capitalized. |

### Chop (`extension Chop on String`)

| Member | Returns | Description |
|---|---|---|
| `first(int length)` | `String` | The first `length` characters, or the whole string if it is shorter. |
| `last(int length)` | `String` | The last `length` characters, or the whole string if it is shorter. |
| `slice(int start, [int? end])` | `String` | Substring from `start` to `end` (to the end of the string if omitted). |
| `truncate(int truncateLength, {String endString = "..."})` | `String` | Shortens to `truncateLength` characters in total, ending with `endString`. Returns the string unchanged if it already fits. |
| `prune(int pruneLength)` | `String` | Shortens to at most `pruneLength` characters, cutting at the last whitespace before that point where there is one. No ending string is added. |
| `codePointAt(int index)` | `int` | Unicode code point at the UTF-16 `index`, combining a surrogate pair into one value. |
| `graphemeAt(int index)` | `String` | The grapheme (user-perceived character) at `index`. |

### Count (`extension Count on String`)

| Member | Returns | Description |
|---|---|---|
| `countGrapheme()` | `int` | Number of graphemes. |
| `countOccurrences(String find)` | `int` | Number of non-overlapping occurrences of `find`. Returns 0 if either string is empty. |
| `countWhere(bool Function(String character) predicate)` | `int` | Number of code points for which `predicate` returns `true`. |
| `countWords({String pattern = ""})` | `int` | Number of items returned by `words(pattern: pattern)`. |

### Escape (`extension Escape on String`)

| Member | Returns | Description |
|---|---|---|
| `escapeHtml()` | `String` | Replaces `<`, `>`, `&`, `"`, `'` and `` ` `` with HTML entities. |
| `unescapeHtml()` | `String` | Replaces the entities for those characters (plus `&#39;` and `&apos;`) with the characters. |
| `escapeRegExp()` | `String` | Escapes RegExp special characters. |
| `unescapeRegExp()` | `String` | Removes backslash escape sequences. |

### Manipulate (`extension Manipulate on String`)

| Member | Returns | Description |
|---|---|---|
| `insert(String toInsert, int position)` | `String` | Inserts `toInsert` at `position`. Returns the string unchanged if `position` is out of range or `toInsert` is empty. |
| `latinize()` | `String` | Replaces accented and some non-Latin letters with Latin letters and drops combining diacritical marks. |
| `reverse()` | `String` | Reverses the string by grapheme. |
| `slugify()` | `String` | Latinizes, replaces characters other than `A-Z`, `a-z` and `0-9` with hyphens, then applies `kebabCase()`, so it also splits at case changes and between letters and digits (`'JavaScript'` becomes `java-script`). |
| `splice(int deleteCount, int startPosition, String replacement)` | `String` | Deletes `deleteCount` characters from `startPosition` and puts `replacement` there. Note the argument order. |
| `translate(Map<String, String> translations)` | `String` | Replaces every occurrence of each map key with its value. |

### Split (`extension Words on String`)

| Member | Returns | Description |
|---|---|---|
| `words({Pattern pattern = ""})` | `List<String>` | Splits into words on case changes, digits and punctuation. A non-empty `pattern` replaces the default word pattern. |
| `graphemes()` | `List<String>` | The graphemes of the string as a list. |

### Util

| Member | Returns | Description |
|---|---|---|
| `String.isUpperCase()` (`extension Strings`) | `bool` | `true` if `toUpperCase()` leaves the string unchanged. Characters without case, such as spaces and digits, do not affect the result. |
| `String.isLowerCase()` (`extension Strings`) | `bool` | `true` if `toLowerCase()` leaves the string unchanged. |
| `String.isAlphabet()` (`extension Strings`) | `bool` | `true` if the whole string consists of Latin letters (with optional combining marks). |
| `int.isHighSurrogate()` (`extension Surrogates on int`) | `bool` | `true` for a UTF-16 high surrogate (0xD800 to 0xDBFF). |
| `int.isLowSurrogate()` (`extension Surrogates on int`) | `bool` | `true` for a UTF-16 low surrogate (0xDC00 to 0xDFFF). |
| `getAstralNumberFromSurrogatePair(int highSurrogate, int lowSurrogate)` | `int` | Top-level function. Combines a surrogate pair into one code point. |
| `Iterable<E>.mapIndex<T>(T Function(E e, int i) f)` (`extension ExtendedIterable`) | `Iterable<T>` | Like `map`, with the index as the second argument. |
| `Iterable<E>.forEachIndex(void Function(E e, int i) f)` (`extension ExtendedIterable`) | `void` | Like `forEach`, with the index as the second argument. |
| `diacritics` | `Map<String, String>` | Top-level variable. Maps each replacement (such as `'e'` or `'sh'`) to a string of the characters that `latinize()` replaces with it. |
| `diacriticsMap` | `Map<String, String>` | Top-level variable. Exported, empty by default and not read by `latinize()`. |
| `replaceCodeUnits(List<int> codeUnits)` | `List<int>` | Top-level function. The code-unit replacement step used by `latinize()`. |

### Deprecated members

These still work but are marked `@Deprecated`. Use the replacement.

| Deprecated | Use instead |
|---|---|
| `count()` | `.length` |
| `countOccurences(find)` | `countOccurrences(find)` |
| `charAt(index)` | `string[index]` |
| `chars()` | `.split('')` |
| `codePoints()` | `.codeUnits` |
| `lowerCase()` | `.toLowerCase()` |
| `upperCase()` | `.toUpperCase()` |
| `escapeHTML()` | `escapeHtml()` |
| `unEscapeRegExp()` | `unescapeRegExp()` |

## Contributing and support

Bug reports and pull requests are welcome. See the [contributing guide](https://github.com/Chinmay-KB/stringr/blob/master/CONTRIBUTING.md), [code of conduct](https://github.com/Chinmay-KB/stringr/blob/master/CODE_OF_CONDUCT.md), [security policy](https://github.com/Chinmay-KB/stringr/blob/master/SECURITY.md) and [support guide](https://github.com/Chinmay-KB/stringr/blob/master/SUPPORT.md). Release notes are in the [changelog](https://github.com/Chinmay-KB/stringr/blob/master/CHANGELOG.md).

## License

MIT. See [LICENSE](https://github.com/Chinmay-KB/stringr/blob/master/LICENSE).
