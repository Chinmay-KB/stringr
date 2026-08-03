# stringr

[![pub package](https://img.shields.io/pub/v/stringr.svg)](https://pub.dev/packages/stringr)
[![codecov](https://codecov.io/gh/Chinmay-KB/stringr/branch/master/graph/badge.svg?token=UIWY4OF2TE)](https://codecov.io/gh/Chinmay-KB/stringr)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A comprehensive string manipulation library for Dart and Flutter. Inspired by [VocaJS](https://vocajs.com/), stringr provides powerful string operations that work seamlessly with Latin, non-Latin, and Unicode strings.

## Features

- **Case Conversion** - camelCase, snake_case, kebab-case, Title Case, PascalCase
- **Unicode Support** - Full support for non-Latin scripts, diacritics, and grapheme clusters
- **Smart Word Detection** - Uses regex patterns instead of simple whitespace splitting
- **Null Safety** - Fully null-safe and compatible with Dart 3.0+
- **Zero Dependencies** - Only depends on the `characters` package for grapheme support

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  stringr: ^1.2.2
```

## Quick Start

```dart
import 'package:stringr/stringr.dart';

void main() {
  // Case conversions
  print('hello world'.toCamelCase);        // helloWorld
  print('hello world'.toSnakeCase);        // hello_world
  print('hello world'.toKebabCase);        // hello-world
  print('hello world'.toPascalCase);       // HelloWorld

  // Smart word extraction
  print('XMLHttpRequest'.camelCase());     // xmlHttpRequest
  print('/path/to/file'.camelCase());      // pathToFile
  print('2infinity&beyond'.words());       // [2, infinity, beyond]
}
```

## Unicode & Non-Latin Support

stringr shines with complex Unicode strings:

```dart
// Non-Latin scripts
print('полет птицы'.kebabCase());          // полет-птицы
print('La variété française'.prune(12));   // La variété

// Diacritics and latinization
print('café'.latinize());                  // cafe
print('anglikonų šiurkščios'.latinize());  // anglikonu siurkscios

// Grapheme-aware operations
print('cafe\u0301'.countGrapheme());       // 4
print('👨‍👩‍👧‍👦'.reverse());                      // 👨‍👩‍👧‍👦 (family emoji stays intact)
```

## API Overview

### Case Manipulation
| Method | Description | Example |
|--------|-------------|---------|
| `camelCase()` | Convert to camelCase | `'foo bar'` → `'fooBar'` |
| `snakeCase()` | Convert to snake_case | `'foo bar'` → `'foo_bar'` |
| `kebabCase()` | Convert to kebab-case | `'foo bar'` → `'foo-bar'` |
| `titleCase()` | Capitalize each word | `'foo bar'` → `'Foo Bar'` |
| `capitalize()` | Capitalize first char | `'foo'` → `'Foo'` |
| `swapCase()` | Toggle case | `'FoO'` → `'fOo'` |

### String Chopping
| Method | Description | Example |
|--------|-------------|---------|
| `truncate(n)` | Truncate to n chars | `'hello world'` → `'hello...'` |
| `prune(n)` | Truncate without breaking words | `'hello world'` → `'hello'` |
| `first(n)` | Get first n chars | `'hello'` → `'hel'` |
| `last(n)` | Get last n chars | `'hello'` → `'llo'` |
| `slice(start, end)` | Extract substring | `'hello'` → `'ell'` |

### Counting
| Method | Description | Example |
|--------|-------------|---------|
| `countGrapheme()` | Count visible characters | `'café'` → `4` |
| `countOccurrences(s)` | Count substring occurrences | `'banana'.countOccurrences('a')` → `3` |
| `countWords()` | Count words | `'hello world'` → `2` |
| `countWhere(fn)` | Count matching chars | Custom predicate |

### Manipulation
| Method | Description | Example |
|--------|-------------|---------|
| `reverse()` | Reverse (grapheme-aware) | `'hello'` → `'olleh'` |
| `slugify()` | URL-friendly slug | `'Hello World!'` → `'hello-world'` |
| `latinize()` | Remove diacritics | `'café'` → `'cafe'` |
| `insert(s, i)` | Insert at position | `'hllo'.insert('e', 1)` → `'hello'` |

### Escaping
| Method | Description |
|--------|-------------|
| `escapeHtml()` | Escape HTML entities |
| `unescapeHtml()` | Unescape HTML entities |
| `escapeRegExp()` | Escape regex special chars |

## Why stringr?

Most string libraries fail with complex Unicode. stringr handles:

- **Grapheme clusters**: `'café'` is 4 characters, not 5
- **Combining marks**: `'cafe\u0301'` is treated as 4 graphemes, not 5 code points
- **Surrogate pairs**: Emoji and special symbols work correctly
- **Non-Latin scripts**: Cyrillic, Greek, accented Latin, and more
- **Smart word detection**: `'XMLHttpRequest'` → `['XML', 'Http', 'Request']`

Read more in the [Unicode Behavior Guide](docs/unicode-behavior.md).

## Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) for details.

## Project Health

- [Contributing Guide](CONTRIBUTING.md)
- [Code of Conduct](CODE_OF_CONDUCT.md)
- [Security Policy](SECURITY.md)
- [Support Guide](SUPPORT.md)

## License

MIT License - see [LICENSE](LICENSE) for details.
