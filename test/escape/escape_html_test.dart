import 'package:stringr/stringr.dart';
import 'package:test/test.dart';

void main() {
  test("should return escaped HTML string", () {
    expect('<>&"\'`'.escapeHTML(), '&lt;&gt;&amp;&quot;&#x27;&#x60;');
    expect('<p>wonderful world</p>'.escapeHTML(),
        '&lt;p&gt;wonderful world&lt;/p&gt;');
  });

  test('should unescape HTML entities', () {
    expect('&lt;&gt;&amp;&quot;&#x27;&#x60;'.unescapeHtml(), '<>&"\'`');
    expect('&#39; &apos;'.unescapeHtml(), "' '");
    expect('no entities'.unescapeHtml(), 'no entities');
  });

  test('should unescape HTML entities in a single pass', () {
    expect('&amp;quot;'.unescapeHtml(), '&quot;');
    expect('&amp;lt;'.unescapeHtml(), '&lt;');
    expect('&amp;amp;'.unescapeHtml(), '&amp;');
    expect('&amp;#39;'.unescapeHtml(), '&#39;');
    expect('&amp;lt;b&amp;gt;'.unescapeHtml(), '&lt;b&gt;');
    for (final text in ['<a href="x">&</a>', "it's &amp; `that`", '&quot;']) {
      expect(text.escapeHtml().unescapeHtml(), text);
    }
  });
}
