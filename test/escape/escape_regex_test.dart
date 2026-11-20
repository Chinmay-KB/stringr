import 'dart:math';

import 'package:characters/characters.dart';
import 'package:test/test.dart';

import '../../lib/src/escape/escape.dart';

void main() {
  test("should return escaped HTML string", () {
    expect('<>&"\'`'.escapeHTML(), '&lt;&gt;&amp;&quot;&#x27;&#x60;');
    expect('<p>wonderful world</p>'.escapeHTML(),
        '&lt;p&gt;wonderful world&lt;/p&gt;');
  });

  test('should return escaped regex', () {
    expect('500-200'.escapeRegExp(), '500-200');
    expect('a.b'.escapeRegExp(), r'a\.b');
    expect(r'\^$.*+?()[]{}|'.escapeRegExp(), r'\\\^\$\.\*\+\?\(\)\[\]\{\}\|');
  });

  test('should return un-escaped regex', () {
    expect(r"500\.200".unEscapeRegExp(), '500.200');
  });

  test('escaped output matches the literal input in default and unicode mode',
      () {
    bool matchesLiterally(String text, {required bool unicode}) {
      final match =
          RegExp(text.escapeRegExp(), unicode: unicode).firstMatch(text);
      return match != null && match.start == 0 && match.end == text.length;
    }

    // every printable ASCII character on its own and surrounded by text
    for (var code = 0x20; code <= 0x7E; code++) {
      final char = String.fromCharCode(code);
      for (final text in [char, 'x${char}y', '$char$char']) {
        for (final unicode in [false, true]) {
          expect(matchesLiterally(text, unicode: unicode), isTrue,
              reason: 'text "$text" unicode: $unicode');
        }
      }
    }

    // random strings
    final random = Random(42);
    const alphabet = r'''ab 19-_!<=:#,\^$.*+?()[]{}|/"'~`@%&;é中😀''';
    final characters = alphabet.characters.toList();
    for (var i = 0; i < 500; i++) {
      final text = List.generate(random.nextInt(12),
          (_) => characters[random.nextInt(characters.length)]).join();
      for (final unicode in [false, true]) {
        expect(matchesLiterally(text, unicode: unicode), isTrue,
            reason: 'text "$text" unicode: $unicode');
      }
      expect(text.escapeRegExp().unescapeRegExp(), text);
    }
    // a special character must not match something else
    expect(RegExp('a.b'.escapeRegExp()).hasMatch('axb'), isFalse);
    expect(
        RegExp('a.b'.escapeRegExp(), unicode: true).hasMatch('axb'), isFalse);
  });

  test('unescapeRegExp is the inverse of escapeRegExp', () {
    for (var code = 0x20; code <= 0x7E; code++) {
      final char = String.fromCharCode(code);
      expect('a$char'.escapeRegExp().unescapeRegExp(), 'a$char');
    }
    const samples = [
      '',
      'plain',
      'a.b',
      r'back\slash',
      r'\\',
      'caf\u00e9 (1+1)?'
    ];
    for (final sample in samples) {
      expect(sample.escapeRegExp().unescapeRegExp(), sample);
    }
    expect(r'a\.b'.unescapeRegExp(), 'a.b');
    expect(r'a\\b'.unescapeRegExp(), r'a\b');
    expect(r'trailing\'.unescapeRegExp(), r'trailing\');
  });
}
