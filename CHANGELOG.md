## [1.3.0] - 2026

Correctness release. The public API is unchanged (no member was removed, renamed or re-typed); the behaviour changes below are bug fixes.

### Behaviour changes
* `escapeRegExp()` puts a single backslash before each regular expression syntax character: `\ ^ $ . * + ? ( ) [ ] { } |`. `'a.b'.escapeRegExp()` is now `a\.b` (it was `a\\.b`, which never matched) and `RegExp(text.escapeRegExp())` matches `text` literally. Characters that are not regex syntax (`- ! < = : # ,`) are no longer escaped, so the result also compiles and matches literally with `RegExp(..., unicode: true)`. The output is meant for use outside a character class
* `unescapeRegExp()` (and the deprecated `unEscapeRegExp()`) is now the true inverse of `escapeRegExp()`: it removes one backslash from each backslash pair, so `\.` becomes `.` and `\\` becomes `\`. It previously stripped every backslash. A lone trailing backslash is kept
* `translate()` replaces in a single pass over the original string, so replacements no longer cascade (`'ab'.translate({'a': 'b', 'b': 'c'})` is `bc`, not `cc`). Matching is leftmost-longest: at each position the longest matching key wins, so the order of the map no longer matters. Empty keys are ignored
* `unescapeHtml()` decodes in a single pass, so `&amp;quot;` becomes `&quot;` instead of `"`
* `latinize()` maps `ß` to `ss` and `ẞ` to `SS` (`straße` was `strase`). `slugify()` benefits too. All other mappings are unchanged. In the exported `diacritics` map the `'s'` entry no longer contains `ß`, and there are new `'ss'` (`ß`) and `'SS'` (`ẞ`) keys
* `truncate()` no longer throws when `truncateLength` is shorter than `endString`; it returns `endString` cut to `truncateLength` (`'hello world'.truncate(2)` is `..`)
* `splice()` no longer throws when `deleteCount` runs past the end of the string; it deletes up to the end (`'hello'.splice(99, 0, 'X')` is `X`). A huge `deleteCount` no longer overflows
* `first()`, `last()`, `truncate()`, `prune()`, `insert()` and `splice()` never split a grapheme cluster (surrogate pairs, combining marks, ZWJ emoji, `\r\n`). Lengths and indices stay UTF-16 code unit based; a cut that would fall inside a cluster moves to the nearest cluster boundary that keeps the result within the requested length (`insert` puts the text before the cluster, `splice` widens the range to whole clusters). Results for text where every grapheme is one code unit are unchanged. A negative length in `first()`, `last()` and `prune()` returns an empty string instead of throwing
* `capitalize()` and `decapitalize()` operate on the first grapheme cluster instead of the first code unit, and so do `camelCase()` and `toPascalCase`, which use them. The `HELLO` to `Hello` versus `macBook` to `MacBook` rules are unchanged
* `words(pattern:)` uses a `RegExp` (or any other non-`String` `Pattern`) directly, so its flags are respected. A `String` pattern is still compiled with `RegExp(pattern)`. The default behaviour is unchanged
* `titleCase()` lowercases a contraction suffix: a word that directly follows an apostrophe (`'` or `’`) that directly follows a letter is lowercased when it is, ignoring case, one of `s`, `t`, `d`, `m`, `ll`, `re` or `ve`. So `it's` and `IT'S` become `It's`, `DON'T` becomes `Don't`, `we'll` becomes `We'll` and `they’ve` becomes `They’ve`. Every other apostrophe behaves as before, so `o'neil` is `O'Neil`, `l'été` is `L'Été` and `'tis` is `'Tis`. Input without apostrophes gives the same output as 1.2.2

### Bug Fixes
* `words(pattern: RegExp(r'\w+'))` returned an empty list because the pattern was rebuilt from `RegExp.toString()`

### Performance
* The default word regular expressions used by `words()`, `titleCase()` and the case conversions are compiled once instead of on every call
* `latinize()` returns pure ASCII strings as is, without allocating. The fast path is only taken when no ASCII character has a replacement in the lookup tables, so ASCII entries added to `diacritics` are still honoured
* Added a `benchmark/` script (excluded from the published package)

### Documentation
* Restructured the README: question-based sections, an API reference and a "Things to know" section describing the grapheme and code unit behaviour. Examples were checked against the code
* Updated the package description, added `repository`, `issue_tracker` and `topics` to `pubspec.yaml`, and refreshed the example

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
