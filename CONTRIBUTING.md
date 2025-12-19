# Contributing to stringr

Thank you for your interest in contributing to stringr! This document provides guidelines for contributing.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/stringr.git`
3. Install dependencies: `dart pub get`
4. Run tests: `dart test`

## Development Workflow

### Making Changes

1. Create a feature branch: `git checkout -b feature/your-feature`
2. Make your changes
3. Run tests: `dart test`
4. Run analysis: `dart analyze`
5. Commit your changes with a descriptive message

### Code Style

- Follow the [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Run `dart format .` before committing
- Ensure `dart analyze` passes with no issues

### Testing

- Add tests for new features
- Ensure all existing tests pass
- Test with both Latin and non-Latin strings when applicable

### Commit Messages

Use clear, descriptive commit messages:
- `feat: add new method for X`
- `fix: handle edge case in Y`
- `docs: update README examples`
- `refactor: improve performance of Z`

## Pull Request Process

1. Ensure all tests pass
2. Update documentation if needed
3. Update CHANGELOG.md with your changes
4. Submit a pull request with a clear description

## Reporting Issues

When reporting issues, please include:
- Dart/Flutter version
- Minimal code to reproduce the issue
- Expected vs actual behavior

## Questions?

Feel free to open an issue for questions or discussions.
