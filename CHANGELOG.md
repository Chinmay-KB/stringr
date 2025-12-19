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

