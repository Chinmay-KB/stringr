# Unicode Behavior Guide

`stringr` is designed to behave well on more than plain ASCII. This guide documents current behavior for Unicode-heavy inputs so users know what to expect and contributors can preserve those guarantees.

## Why this matters

String manipulation gets tricky once text includes:

- combining marks
- emoji joined with zero-width joiners
- accented Latin text
- non-Latin scripts
- mixed-case identifiers with acronyms

Naive operations often split visible characters incorrectly or produce surprising case and slug results. `stringr` aims to make those cases more predictable.

## Grapheme-aware behavior

Some visible characters are made of multiple code points. `stringr` uses grapheme-aware behavior for operations like `graphemes()`, `countGrapheme()`, and `reverse()`.

```dart
import 'package:stringr/stringr.dart';

void main() {
  print('cafe\u0301'.graphemes());      // [c, a, f, é]
  print('cafe\u0301'.countGrapheme());  // 4
  print('cafe\u0301'.reverse());        // éfac

  print('👨‍👩‍👧‍👦'.graphemes());        // [👨‍👩‍👧‍👦]
  print('👨‍👩‍👧‍👦'.countGrapheme());    // 1
  print('👨‍👩‍👧‍👦'.reverse());          // 👨‍👩‍👧‍👦

  print('👩🏽‍💻 works'.reverse());      // skrow 👩🏽‍💻
}
```

## Word detection across scripts

`words()` uses Unicode-aware regular expressions instead of splitting only on spaces. That helps with identifiers, accented text, and many non-Latin scripts.

```dart
import 'package:stringr/stringr.dart';

void main() {
  print('XMLHttpRequest'.words());  // [XML, Http, Request]
  print('नमस्ते दुनिया'.words());    // [नमस्ते, दुनिया]
  print('مرحبا بالعالم'.words());   // [مرحبا, بالعالم]
  print('👩🏽‍💻 works'.words());    // [👩🏽, 💻, works]
}
```

This behavior flows into other APIs such as `camelCase()`, `kebabCase()`, `snakeCase()`, and `countWords()`.

## Case behavior

Case transforms behave best for scripts with case distinctions and are intentionally conservative elsewhere.

```dart
import 'package:stringr/stringr.dart';

void main() {
  print('HELLO'.capitalize());          // Hello
  print('HeLLo'.capitalize());          // Hello
  print('macBook'.capitalize());        // MacBook

  print('XMLHttpRequest'.camelCase());  // xmlHttpRequest
  print('İstanbul'.titleCase());        // İstanbul
}
```

Notes:

- `capitalize()` normalizes already-uppercase and mixed-uppercase words.
- `camelCase()` preserves acronym-like word splits such as `XML` + `Http` + `Request`.
- For scripts without uppercase/lowercase distinctions, case transforms may leave text unchanged.

## Latinization and slug generation

`latinize()` removes diacritics and transliterates supported characters into a Latin representation. `slugify()` builds on that behavior and then normalizes separators.

```dart
import 'package:stringr/stringr.dart';

void main() {
  print('cafe\u0301'.latinize());      // cafe
  print('man\u0303ana'.latinize());    // manana
  print('İstanbul'.slugify());         // istanbul
  print('Straße'.slugify());           // strase
  print('XMLHttpRequest'.slugify());   // xml-http-request
}
```

Notes:

- transliteration quality depends on the current mapping table
- unsupported scripts may not produce a Latin slug
- emoji-only input currently slugifies to an empty string

## Known behavior to be aware of

These are intentional descriptions of current behavior, not promises that the implementation is finished forever:

- family emoji such as `👨‍👩‍👧‍👦` count as one grapheme, but emoji tokenization in `words()` is still regex-driven rather than semantic
- emoji-containing phrases like `👩🏽‍💻 works` can still produce useful surrounding words, but emoji tokenization is not yet “semantic”
- transliteration coverage varies by script and character

These are good areas for future improvement and additional fixture coverage.

## Regression coverage

The repository includes dedicated Unicode regression fixtures and tests covering:

- combining marks
- emoji grapheme clusters
- Devanagari and Arabic word boundaries
- dotted `İ`
- eszett
- acronym-heavy identifiers

If you find a broken edge case, please open an issue with the exact input, expected output, and actual output.
