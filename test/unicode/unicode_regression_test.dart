import 'package:stringr/stringr.dart';
import 'package:test/test.dart';

import '../fixtures/unicode_cases.dart';

void main() {
  group('unicode grapheme regressions', () {
    for (final fixture in unicodeGraphemeFixtures) {
      test(fixture.description, () {
        expect(fixture.input.graphemes(), fixture.graphemes);
        expect(fixture.input.countGrapheme(), fixture.graphemes.length);
        expect(fixture.input.reverse(), fixture.reversed);
      });
    }
  });

  group('unicode word boundary regressions', () {
    for (final fixture in unicodeWordFixtures) {
      test(fixture.description, () {
        expect(fixture.input.words(), fixture.words);

        if (fixture.camelCase != null) {
          expect(fixture.input.camelCase(), fixture.camelCase);
        }

        if (fixture.kebabCase != null) {
          expect(fixture.input.kebabCase(), fixture.kebabCase);
        }

        if (fixture.snakeCase != null) {
          expect(fixture.input.snakeCase(), fixture.snakeCase);
        }
      });
    }
  });

  group('unicode transform regressions', () {
    for (final fixture in unicodeTransformFixtures) {
      test(fixture.description, () {
        if (fixture.capitalize != null) {
          expect(fixture.input.capitalize(), fixture.capitalize);
        }

        if (fixture.titleCase != null) {
          expect(fixture.input.titleCase(), fixture.titleCase);
        }

        if (fixture.latinize != null) {
          expect(fixture.input.latinize(), fixture.latinize);
        }

        if (fixture.slugify != null) {
          expect(fixture.input.slugify(), fixture.slugify);
        }
      });
    }
  });
}
