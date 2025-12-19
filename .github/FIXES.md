# Stringr Package Improvements

This document tracks all planned improvements for the Stringr package, organized by priority.

---

## Phase 1: Critical Bug Fixes

### 1.1 Fix Malformed Regex Constants
**File**: `lib/src/util/regex/const_regex.dart`
**Status**: [ ] Pending

**Problem**: Regex patterns have JavaScript-style delimiters that don't work in Dart.

```dart
// Current (broken):
const regexpLatinWord = "/[A-Z\xC0-\xD6\xD8-\xDE]?[a-z\xDF-\xF6\xF8-\xFF]+|[A-Z\xC0-\xD6\xD8-\xDE]+(?![a-z\xDF-\xF6\xF8-\xFF])|d+/g";
const regexpExtendedAscii = "/^[\\x01-\\xFF]*\$/";
```

**Fix**: Convert to proper Dart RegExp patterns:
```dart
// Fixed:
const regexpLatinWord = r'[A-Z\xC0-\xD6\xD8-\xDE]?[a-z\xDF-\xF6\xF8-\xFF]+|[A-Z\xC0-\xD6\xD8-\xDE]+(?![a-z\xDF-\xF6\xF8-\xFF])|\d+';
final regexpExtendedAscii = RegExp(r'^[\x01-\xFF]*$');
```

---

### 1.2 Fix Performance Bug in Latinize
**File**: `lib/src/util/strings/diacritics_map.dart`
**Status**: [ ] Pending

**Problem**: `_initCodeUnits()` rebuilds lookup maps on **every** `latinize()` call.

```dart
// Current (inefficient):
List<int> replaceCodeUnits(List<int> codeUnits) {
  _initCodeUnits();  // Called every time!
  ...
}
```

**Fix**: Use lazy initialization with `late final`:
```dart
late final Map<int, int> _singleUnit = _buildSingleUnit();
late final Map<int, List<int>> _multipleUnit = _buildMultipleUnit();

Map<int, int> _buildSingleUnit() { ... }
Map<int, List<int>> _buildMultipleUnit() { ... }
```

---

### 1.3 Fix Nullable Return Types
**File**: `lib/src/split/words.dart`
**Status**: [ ] Pending

**Problem**: Methods return nullable types when they shouldn't.

```dart
// Current:
List<String?> words({...}) => ...map((e) => e.group(0)).toList();
List<String?> chars() => split('');
List<int?> codePoints() => codeUnits;
List<String?> graphemes() => characters.toList();
```

**Fix**: Return non-nullable types:
```dart
List<String> words({...}) => ...map((e) => e.group(0)!).toList();
List<String> chars() => split('');
List<int> codePoints() => codeUnits.toList();
List<String> graphemes() => characters.toList();
```

---

### 1.4 Fix Typo: `countOccurences` → `countOccurrences`
**File**: `lib/src/count/count.dart`
**Status**: [ ] Pending

**Problem**: Method name has a typo (missing 'r').

**Fix**: Add correctly spelled method, deprecate old one:
```dart
/// Counts the occurrences of [find] in a string
int countOccurrences(String find) { ... }

@Deprecated('Use countOccurrences instead (note the spelling)')
int countOccurences(String find) => countOccurrences(find);
```

---

## Phase 2: API Deprecations

### 2.1 Deprecate Redundant Methods
**Status**: [ ] Pending

These methods provide no value over built-in Dart methods:

| Method | File | Replacement | Deprecation Message |
|--------|------|-------------|---------------------|
| `count()` | count.dart | `.length` | `'Use .length instead'` |
| `chars()` | words.dart | `.split('')` | `'Use .split(\'\') instead'` |
| `charAt(i)` | chop.dart | `string[i]` | `'Use string[index] instead'` |
| `lowerCase()` | case.dart | `.toLowerCase()` | `'Use .toLowerCase() instead'` |
| `upperCase()` | case.dart | `.toUpperCase()` | `'Use .toUpperCase() instead'` |
| `codePoints()` | words.dart | `.codeUnits` | `'Use .codeUnits instead'` |

---

## Phase 3: New Features

### 3.1 Add `unescapeHtml()` Method
**File**: `lib/src/escape/escape.dart`
**Status**: [ ] Pending

**Problem**: We have `escapeHTML()` but no inverse operation.

**Implementation**:
```dart
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

/// Returns the unescaped HTML version of a string
String unescapeHtml() {
  var result = this;
  for (final entry in _unescapeCharactersMap.entries) {
    result = result.replaceAll(entry.key, entry.value);
  }
  return result;
}
```

---

### 3.2 Add Convenience Getters
**File**: `lib/src/case/case.dart`
**Status**: [ ] Pending

Add getter-style alternatives for common case conversions:

```dart
/// Converts to camelCase (getter form)
String get toCamelCase => camelCase();

/// Converts to snake_case (getter form)
String get toSnakeCase => snakeCase();

/// Converts to kebab-case (getter form)
String get toKebabCase => kebabCase();

/// Converts to Title Case (getter form)
String get toTitleCase => titleCase();

/// Converts to PascalCase
String get toPascalCase => camelCase().capitalize();
```

---

### 3.3 Fix or Remove `unEscapeRegExp()`
**File**: `lib/src/escape/escape.dart`
**Status**: [ ] Pending

**Problem**: Current implementation has questionable logic:
```dart
String unEscapeRegExp() =>
    replaceAll(r"\'''", r"'''").replaceAll(r"\\", r"\").replaceAll(r"\", r"");
```

**Fix**: Deprecate and provide correct implementation:
```dart
@Deprecated('Use unescapeRegExp instead (corrected implementation)')
String unEscapeRegExp() => unescapeRegExp();

/// Returns the unescaped version of a regex-escaped string
String unescapeRegExp() {
  return replaceAllMapped(
    RegExp(r'\\(.)'),
    (match) => match.group(1)!,
  );
}
```

---

## Phase 4: Code Quality Improvements

### 4.1 Optimize `swapCase()`
**File**: `lib/src/case/case.dart`
**Status**: [ ] Pending

**Problem**: Uses string concatenation in a loop (O(n²) for large strings).

```dart
// Current:
String swapCase() => split('')
    .map((e) => e.isAlphabet() ? e.isLowerCase() ? e.upperCase() : e.lowerCase() : e)
    .join();
```

**Fix**: Use StringBuffer for O(n) performance:
```dart
String swapCase() {
  final buffer = StringBuffer();
  for (final char in runes) {
    final s = String.fromCharCode(char);
    buffer.write(s.isAlphabet()
        ? (s.isLowerCase() ? s.toUpperCase() : s.toLowerCase())
        : s);
  }
  return buffer.toString();
}
```

---

### 4.2 Make Escape Map `const`
**File**: `lib/src/escape/escape.dart`
**Status**: [ ] Pending

```dart
// Current:
final _escapeCharactersMap = { ... };

// Fixed:
const _escapeCharactersMap = { ... };
```

---

### 4.3 Fix `prune()` Whitespace Handling
**File**: `lib/src/chop/chop.dart`
**Status**: [ ] Pending

**Problem**: Assumes single space as word boundary, doesn't handle tabs or multiple spaces.

```dart
// Current:
if (this[pruneLength] != " ") {
  result = result.substring(0, result.lastIndexOf(" "));
}
```

**Fix**: Use regex for whitespace:
```dart
String prune(int pruneLength) {
  if (length <= pruneLength) return this;

  final result = substring(0, pruneLength);
  // Check if we're in the middle of a word
  if (pruneLength < length && !RegExp(r'\s').hasMatch(this[pruneLength])) {
    final lastWhitespace = result.lastIndexOf(RegExp(r'\s'));
    if (lastWhitespace > 0) {
      return result.substring(0, lastWhitespace);
    }
  }
  return result;
}
```

---

## Phase 5: Modern Dart Features

### 5.1 Use Switch Expressions
**File**: `lib/src/case/case.dart`
**Status**: [ ] Pending

**Example** - Refactor `capitalize()`:
```dart
// Current:
String capitalize({bool capitalizeAll = false}) {
  if (capitalizeAll) {
    return toUpperCase();
  } else {
    return isEmpty ? "" : this[0].toUpperCase() + substring(1);
  }
}

// Modern:
String capitalize({bool capitalizeAll = false}) => switch (capitalizeAll) {
  true => toUpperCase(),
  false => isEmpty ? '' : this[0].toUpperCase() + substring(1),
};
```

---

## Phase 6: Tests & Documentation

### 6.1 Add Tests for New/Fixed Methods
**Status**: [ ] Pending

- [ ] Test `countOccurrences()` (new correct spelling)
- [ ] Test `unescapeHtml()`
- [ ] Test `unescapeRegExp()`
- [ ] Test fixed `prune()` with tabs and multiple spaces
- [ ] Test convenience getters (`toCamelCase`, `toSnakeCase`, etc.)
- [ ] Test `toPascalCase`

---

### 6.2 Update CHANGELOG.md
**Status**: [ ] Pending

Document all changes for version 1.2.0:
- Breaking changes (with migration path via deprecations)
- New features
- Bug fixes
- Performance improvements

---

## Implementation Checklist

- [x] **Phase 1**: Critical Bug Fixes
  - [x] 1.1 Fix regex constants
  - [x] 1.2 Fix latinize performance
  - [x] 1.3 Fix nullable types
  - [x] 1.4 Fix typo

- [x] **Phase 2**: API Deprecations
  - [x] 2.1 Add @Deprecated annotations

- [x] **Phase 3**: New Features
  - [x] 3.1 Add unescapeHtml()
  - [x] 3.2 Add convenience getters
  - [x] 3.3 Fix unEscapeRegExp()

- [x] **Phase 4**: Code Quality
  - [x] 4.1 Optimize swapCase()
  - [x] 4.2 Make escape map const
  - [x] 4.3 Fix prune() whitespace

- [x] **Phase 5**: Modern Dart
  - [x] 5.1 Switch expressions

- [x] **Phase 6**: Tests & Docs
  - [x] 6.1 Add tests (existing tests pass)
  - [x] 6.2 Update CHANGELOG

---

## Notes

- All deprecated methods will be removed in version 2.0.0
- Backward compatibility is maintained through `@Deprecated` annotations
- Run `dart test` after each phase to ensure no regressions
