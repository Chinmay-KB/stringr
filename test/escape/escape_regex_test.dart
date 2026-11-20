import 'package:test/test.dart';

import '../../lib/src/escape/escape.dart';

void main() {
  test("should return escaped HTML string", () {
    expect('<>&"\'`'.escapeHTML(), '&lt;&gt;&amp;&quot;&#x27;&#x60;');
    expect('<p>wonderful world</p>'.escapeHTML(),
        '&lt;p&gt;wonderful world&lt;/p&gt;');
  });

  test('should return escaped regex', () {
    expect('500-200'.escapeRegExp(), r"500\-200");
  });

  test('should return un-escaped regex', () {
    expect(r"500\-200".unEscapeRegExp(), '500-200');
  });

  test('escaped output matches the literal input for every special character',
      () {
    expect(r'a.b'.escapeRegExp(), r'a\.b');
    expect(RegExp('a.b'.escapeRegExp()).hasMatch('a.b'), isTrue);
    expect(RegExp('a.b'.escapeRegExp()).hasMatch('axb'), isFalse);
    for (final char in r'-[]{}()*+!<=:?.\^$|#,'.split('')) {
      final input = 'x${char}y';
      final match = RegExp('^${input.escapeRegExp()}\$').hasMatch(input);
      expect(match, isTrue, reason: 'special character "$char"');
    }
    const everything = r'-[]{}()*+!<=:?.\^$|#, plain text';
    expect(
        RegExp('^${everything.escapeRegExp()}\$').hasMatch(everything), isTrue);
  });

  test('unescapeRegExp is the inverse of escapeRegExp', () {
    const samples = [
      '',
      'plain',
      'a.b',
      '500-200',
      r'back\slash',
      r'\\',
      r'-[]{}()*+!<=:?.\^$|#,',
      'caf\u00e9 (1+1)?',
    ];
    for (final sample in samples) {
      expect(sample.escapeRegExp().unescapeRegExp(), sample);
    }
    expect(r'a\.b'.unescapeRegExp(), 'a.b');
    expect(r'a\\b'.unescapeRegExp(), r'a\b');
    expect(r'trailing\'.unescapeRegExp(), r'trailing\');
  });
}
