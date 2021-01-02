# stringr

String manipulation in dart/flutter on steroids!
This dart plugin is null safety compliant 😎😎

![codecov](https://codecov.io/gh/Chinmay-KB/stringr/branch/master/graph/badge.svg?token=UIWY4OF2TE)
![codemagic](https://api.codemagic.io/apps/5fecda726b96ea001cebef4a/flutter-package/status_badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)



This dart plugin is inspired by [Voca js](https://vocajs.com/#) library. This plugin includes all the nifty functions required for powerful string manipulations. 
How powerful? Good you asked!!
```dart

import 'package:stringr/stringr.dart';

void main(){
 print("camel case".camelCase()); // Output - "camelCase"
 print("HTMLview".camelCase(preserveAcronym=true)); // Output - "HTMLView"
 print("/this/is/a/directory".camelCase()); // Output - "thisIsADirectory"
 print("полет птицы".kebabCase()); // Output - "полет_птицы"
 print("La variété la plus fréquente est la blanche".prune(12)); // Output - La variété
}
 
```
This plugin works on both latin and non latin strings, and uses complex regular expressions to extract words from strings on manipulations, rather than just calling `split(" ")` on a string.

Support for graphemes is also included in this plugin. [characters](https://pub.dev/packages/characters) plugin is used to facilitate some of this functionalities.

```dart

import 'package:stringr/stringr.dart';

void main(){
 print("cafe\u0301".countGrapheme()); // Output - 4
 print("\uD835\uDC00\uD835\uDC01".countGrapheme()); // Output - 2
 print("\uD835\uDC00\uD835\uDC01".graphemeAt(1)); // Output - "\uD835\uDC01"
}
 
```

This plugin is still a work in progress, with about half the work still to be done.
