import 'package:test/test.dart';

import '../../lib/src/escape/escape.dart';

void main() {
  test("should return escaped HTML string", () {
    expect('<>&"\'`'.escapeHTML(), '&lt;&gt;&amp;&quot;&#x27;&#x60;');
    expect('<p>wonderful world</p>'.escapeHTML(),
        '&lt;p&gt;wonderful world&lt;/p&gt;');
  });

  test('should return escaped regex', () {
    expect('500-200'.escapeRegExp(), r"500\\-200");
  });

  test('should return un-escaped regex', () {
    expect(r"500\\-200".unEscapeRegExp(), '500-200');
  });
}
