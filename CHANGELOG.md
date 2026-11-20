## [1.3.0] - 2026

### Behaviour changes
* `escapeRegExp()` now prefixes special characters with a single backslash, so `'a.b'.escapeRegExp()` is `a\.b` and `RegExp(text.escapeRegExp())` matches `text` literally. It previously produced two backslashes (`a\\.b`), which never matched
* `unescapeRegExp()` (and the deprecated `unEscapeRegExp()`) is now the true inverse of `escapeRegExp()`: `\.` becomes `.` and `\\` becomes `\`. It previously stripped every backslash
* `translate()` now replaces in a single pass, so replacements no longer cascade (`'ab'.translate({'a': 'b', 'b': 'c'})` is `bc`, not `cc`). When several keys match at the same position the longest key wins, and empty keys are ignored
* `unescapeHtml()` now decodes in a single pass, so `&amp;quot;` becomes `&quot;` instead of `"`
* `latinize()` now maps `ß` to `ss` and `ẞ` to `SS` (it previously dropped one `s`: `straße` gave `strase`). `slugify()` benefits too. All other mappings are unchanged
* `truncate()` no longer throws when `truncateLength` is shorter than `endString`; it returns `endString` clipped to `truncateLength` (`'hello world'.truncate(2)` is `..`)
* `first()`, `last()`, `truncate()`, `prune()`, `insert()` and `splice()` never split a grapheme cluster (surrogate pairs, combining marks, ZWJ emoji, `\r\n`). Lengths and indices stay UTF-16 code unit based; a cut that would fall inside a cluster moves to the nearest cluster boundary that keeps the result within the requested length. Results for text where every grapheme is one code unit are unchanged. A negative length now returns an empty string instead of throwing
* `capitalize()` and `decapitalize()` operate on the first grapheme cluster instead of the first code unit. The `HELLO` to `Hello` versus `macBook` to `MacBook` rules are unchanged

### Bug Fixes
* `words()` now accepts both `String` and `RegExp` patterns (`'a-b c'.words(pattern: RegExp(r'\w+'))` was `[]`). The default behaviour is unchanged
* `titleCase()` keeps apostrophes inside a word: `it's` becomes `It's` instead of `It'S`

### Performance
* The default word regular expressions used by `words()`, `titleCase()` and the case conversions are compiled once instead of on every call
* `latinize()` returns pure ASCII strings as is, without allocating
* Added a `benchmark/` script (excluded from the published package)

### Tests
* Added regression tests for every fix above

## [1.2.2] - 2026

### Bug Fixes
* Fixed `capitalize()` to normalize already-capitalized and all-uppercase inputs like `HELLO` and `HeLLo` to `Hello`
* Preserved acronym tokens in `camelCase()` while fixing `capitalize()` behavior

### Tests
* Added regression coverage for uppercase and mixed-case `capitalize()` inputs

## [1.2.1] - 2025

### Documentation
* Revamped README with cleaner structure and API tables
* Added CONTRIBUTING.md for contributors
* Removed codemagic badge

### Code Quality
* Code formatting improvements across source files

## [1.2.0] - 2025

### New Features
* Added `unescapeHtml()` method to unescape HTML entities
* Added `escapeHtml()` as the new camelCase version of `escapeHTML()`
* Added `countOccurrences()` with correct spelling
* Added convenience getters: `toCamelCase`, `toSnakeCase`, `toKebabCase`, `toTitleCase`, `toPascalCase`

### Bug Fixes
* Fixed malformed regex patterns in `const_regex.dart` (JS-style delimiters removed)
* Fixed performance bug in `latinize()` - maps are now lazily initialized instead of rebuilt on every call
* Fixed `prune()` to handle tabs and other whitespace, not just spaces
* Fixed nullable return types in `words()`, `chars()`, `codePoints()`, `graphemes()`

### Deprecations (will be removed in 2.0.0)
* `escapeHTML()` - use `escapeHtml()` instead
* `unEscapeRegExp()` - use `unescapeRegExp()` instead
* `countOccurences()` - use `countOccurrences()` instead (typo fix)
* `count()` - use `.length` instead
* `chars()` - use `.split('')` instead
* `codePoints()` - use `.codeUnits` instead
* `charAt()` - use `string[index]` instead
* `lowerCase()` - use `.toLowerCase()` instead
* `upperCase()` - use `.toUpperCase()` instead

### Code Quality
* Optimized `swapCase()` using `StringBuffer` for O(n) performance
* Made escape character maps `const` for compile-time optimization
* Added modern Dart 3.0+ switch expressions in case methods
* Improved code documentation

## [1.1.0] - 2025

* Updated to Dart 3.0+ with modern SDK constraints (>=3.0.0 <4.0.0)
* Added `unescapeRegExp()` method to unescape regex strings
* Code refactoring and improved maintainability
* Updated dependencies to latest compatible versions

## [1.0.0] - 2021

* First stable release
* All string manipulation features from prerelease now stable

## [0.0.1-prerelease] - 04/01/2021

* Added functionalities either missing from String class.
* Functionalities are inspired from Voca JS.
* escapeRegEx() is not working for certain RegEx strings.

## [0.0.2-prerelease] - 04/01/2021

* Trying to get full pub score
