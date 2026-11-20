// ignore_for_file: avoid_print

import 'package:stringr/stringr.dart';

void main() {
  // Case conversion
  print('XMLHttpRequest'.camelCase()); // xmlHttpRequest
  print('XMLHttpRequest'.snakeCase()); // xml_http_request
  print('XMLHttpRequest'.kebabCase()); // xml-http-request
  print('hello world'.titleCase()); // Hello World
  print('hello world'.toPascalCase); // HelloWorld

  // URL slugs and diacritics
  print('Crème Brûlée & Café au Lait'.slugify()); // creme-brulee-cafe-au-lait
  print('anglikonų šiurkščios'.latinize()); // anglikonu siurkscios

  // Truncation
  print('The quick brown fox jumps'.prune(15)); // The quick brown
  print('The quick brown fox jumps'.truncate(15)); // The quick br...

  // Counting and splitting
  print('Hello, how are you today?'.countWords()); // 5
  print('foo_bar-baz qux'.words()); // [foo, bar, baz, qux]
  print('banana'.countOccurrences('a')); // 3

  // Grapheme-aware operations
  print('café'.length); // 5 (UTF-16 code units)
  print('café'.countGrapheme()); // 4 (user-perceived characters)
  print('ab👨‍👩‍👧‍👦c'.reverse()); // c👨‍👩‍👧‍👦ba

  // HTML escaping
  print('<a href="x">Tom & Jerry</a>'.escapeHtml());
  // &lt;a href=&quot;x&quot;&gt;Tom &amp; Jerry&lt;/a&gt;
}
