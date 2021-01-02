import 'package:stringr/stringr.dart';
import 'package:test/test.dart';

void main() {
  test("should return escaped HTML string", () {
    expect('<>&"\'`'.escapeHTML(), '&lt;&gt;&amp;&quot;&#x27;&#x60;');
    expect('<p>wonderful world</p>'.escapeHTML(),
        '&lt;p&gt;wonderful world&lt;/p&gt;');
  });
}
