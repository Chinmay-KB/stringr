# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Stringr is a comprehensive string manipulation library for Dart/Flutter inspired by VocaJS. It provides powerful string operations that work with Latin, non-Latin, and grapheme cluster strings using complex regular expressions rather than simple whitespace splitting.

**Current Status**: Updated to Dart 3.0+ with modern SDK constraints and comprehensive linting rules.

## Development Commands

### Testing
- `dart test` - Run all tests
- `dart run test_coverage` - Run tests with coverage (used in CI)
- `dart test test/specific_test.dart` - Run specific test file

### Dependencies
- `dart pub get` - Install dependencies
- `dart pub upgrade` - Upgrade dependencies

### Analysis
- `dart analyze` - Static analysis with comprehensive modern Dart linting rules

## Architecture Overview

The library follows a **modular extension-based architecture** with functionality organized into domain-specific modules:

### Core Modules
- **`lib/src/case/`** - Case transformations (camelCase, kebabCase, snakeCase, titleCase)
- **`lib/src/chop/`** - String truncation operations (truncate, slice, prune, first, last)  
- **`lib/src/count/`** - Counting operations (characters, graphemes, occurrences, words)
- **`lib/src/escape/`** - String escaping/unescaping (HTML, RegExp)
- **`lib/src/manipulate/`** - String manipulation (insert, reverse, slugify, translate, splice)
- **`lib/src/split/`** - String splitting operations (words, chars, codePoints, graphemes)

### Utility Infrastructure
- **`lib/src/util/object/`** - Generic utility extensions (ExtendedIterable)
- **`lib/src/util/regex/`** - Pre-compiled regex patterns and constants for Unicode handling
- **`lib/src/util/strings/`** - String utility functions, diacritics mapping, and surrogate pair handling

### Key Patterns
- Each module implements a Dart extension on `String` class
- Heavy use of pre-compiled regex patterns for Unicode-aware text processing
- Consistent method signatures with optional parameters and sensible defaults
- Support for complex Unicode scenarios including surrogate pairs and grapheme clusters

## Dependencies
- **`characters`** ^1.3.0 - Used for grapheme cluster support and Unicode handling (Flutter-compatible version)
- **`test`** ^1.26.3 - Modern testing framework (dev dependency)

## Important Notes
- Project uses dependency overrides for `file` and `watcher` packages to ensure Dart 3.0+ compatibility
- The codebase has comprehensive linting rules enforced through `analysis_options.yaml`
- All tests pass on Dart 3.0+ but there are linting warnings that can be addressed incrementally

## CI/CD
- GitHub Actions workflow runs on push/PR to master branch
- Uses latest stable Dart container (`dart:stable`)
- Runs tests with coverage and uploads to Codecov
- Coverage reports stored in `coverage/lcov.info`