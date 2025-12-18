// ignore_for_file: avoid_print

import 'package:stringr/stringr.dart';

void main() {
  // Case transformations
  print('camelCase: "XMLHttpRequest" -> "${"XMLHttpRequest".camelCase()}"');
  print(
      'camelCase: "/home/Kb/code/stringr" -> "${"/home/Kb/code/stringr".camelCase()}"');
  print('capitalize: "яблоко" -> "${"яблоко".capitalize()}"');
  print('kebabCase: "XMLHttpRequest" -> "${"XMLHttpRequest".kebabCase()}"');
  print('snakeCase: "XMLHttpRequest" -> "${"XMLHttpRequest".snakeCase()}"');
  print('titleCase: "hello world" -> "${"hello world".titleCase()}"');
  print('');

  // Chop operations
  print(
      'codePointAt: "\\uD835\\uDC00\\uD835\\uDC01" at 2 -> "${"\uD835\uDC00\uD835\uDC01".codePointAt(2)}"');
  print(
      'graphemeAt: complex string at 3 -> "${"foo\uD834\uDF06\u0303\u035C\u035D\u035Ebar".graphemeAt(3)}"');
  print('prune: "Привет как дела" to 10 -> "${"Привет как дела".prune(10)}"');
  print(
      'truncate: "Is this where you wanna go" to 10 -> "${"Is this where you wanna go".truncate(10)}"');
  print('first: "hello" first 3 -> "${"hello".first(3)}"');
  print('last: "hello" last 3 -> "${"hello".last(3)}"');
  print('');

  // Count operations
  print('count: "hello" -> ${"hello".count()}');
  print('countWords: "hello world foo" -> ${"hello world foo".countWords()}');
  print('countGrapheme: "café" -> ${"café".countGrapheme()}');
  print('');

  // Manipulate operations
  print('reverse: "hello" -> "${"hello".reverse()}"');
  print('slugify: "Hello World" -> "${"Hello World".slugify()}"');
  print('latinize: "café" -> "${"café".latinize()}"');
}
