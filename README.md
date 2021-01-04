# stringr 🧵

String manipulation in dart/flutter on steroids! ⚡⚡
This dart plugin is null safety compliant 😎😎

![codecov](https://codecov.io/gh/Chinmay-KB/stringr/branch/master/graph/badge.svg?token=UIWY4OF2TE)
![codemagic](https://api.codemagic.io/apps/5fecda726b96ea001cebef4a/flutter-package/status_badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)


This dart plugin is inspired 🧠 by [Voca js](https://vocajs.com/#) library. This plugin includes all the nifty functions required for powerful string manipulations. 

How powerful? Glad you asked!!

This plugin works on both latin and non latin strings, and uses complex regular expressions to extract words from strings on manipulations, rather than just calling `split(" ")` on a string.
```dart

import 'package:stringr/stringr.dart';

void main(){
 print("camel case".camelCase()); // Output - "camelCase"
 print("HTMLview".camelCase(preserveAcronym=true)); // Output - "HTMLView"
 print("/this/is/a/directory".camelCase()); // Output - "thisIsADirectory"
 print("полет птицы".kebabCase()); // Output - "полет_птицы"
 print("La variété la plus fréquente est la blanche".prune(12)); // Output - La variété
print("2infinity*@#@AND93beyond".words()); // Output - ["2", "infinity", "AND", "93", "beyond"]
 print("gravity".words(pattern: r"\w{1,2}")); // Output - ['gr', 'av', 'it', 'y']
}
 
```
Convert a string to its latin counterpart! Can reverse not only pure strings, but strings with grapheme clusters as well😎

```dart

import 'package:stringr/stringr.dart';

void main(){
print("cafe\u0301".latinize()); // Output - cafe
print("anglikonų šiurkščios užrašinėti".latinize());// Output - 'anglikonu siurkscios uzrasineti'
print("𝌆 bar mañana mañana".reverse()); // Output - 'anañam anañam rab 𝌆'
// Splitting and reversing normally would give this as output
// anãnam anañam rab ��
}
 
```
Support for graphemes is also included in this plugin. [characters](https://pub.dev/packages/characters) plugin is used to facilitate some of the functionalities.

```dart

import 'package:stringr/stringr.dart';

void main(){
 print("cafe\u0301".countGrapheme()); // Output - 4
 print("\uD835\uDC00\uD835\uDC01".countGrapheme()); // Output - 2
 print("\uD835\uDC00\uD835\uDC01".graphemeAt(1)); // Output - "\uD835\uDC01"
print("stellar bomb".codePoints()); // Output - [0x73, 0x74, 0x65, 0x6c, 0x6c, 0x61, 0x72, 0x20, 0x62, 0x6f, 0x6d, 0x62]
 print('man\u0303ana'.graphemes()); // Output - ['m','a', 'n\u0303', 'a', 'n', 'a']
}
 
```
HTML strings can be escaped!

```dart

import 'package:stringr/stringr.dart';

void main(){
print('<>&"\'`'.escapeHTML()); // Output - '&lt;&gt;&amp;&quot;&#x27;&#x60;'
print('<p>wonderful world</p>'.escapeHTML());// Output - '&lt;p&gt;wonderful world&lt;/p&gt;'
}
 
```
You can count on stringr to count the words, latin, non latin, or strings with grapheme clusters!
```dart

import 'package:stringr/stringr.dart';

void main(){
print("a year without rain".count()); // Output - 19
print("foo\uD834\uDF06\u0303\u035C\u035D\u035Ebar".countGrapheme());// Output - 7
print("to be or not to be".countOccurences("to")); // Output - 2
print("aBCdeFgH".countWhere((character) => character.isAlphabet())); // Output - 8
print("NewYork".countWords()); // Output - 2
}
 
```
* Some of the functionalities, like `char()` and `codePoints` are either simple enough to implement or were available in the characters package. But still I decided to add them to make bundle everything under a similar syntax ( i.e- calling the extension functions on string). 
* For functions like `padLeft()` and `trim()` which already are extension functions and inbuilt in dart, I have not included them in this plugin as the syntax would be similar to that of this plugin.
