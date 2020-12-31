import 'package:characters/characters.dart';
import 'package:stringr/src/util/regex/const.dart';

import '../util/strings/surrogate_pair.dart';
import '../util/regex/const_regex.dart';

///Extension bundling all functions related to destructive string manipulation
extension Chop on String {
  ///Get a character from a specific index
  String charAt(int index) => this.charAt(index);

  ///Get the unicode point value from a specific index
  int codePointAt(int index) {
    int firstCodePoint = this.codeUnitAt(index);
    int secondCodePoint;
    if (firstCodePoint.isHighSurrogate() && this.length > index + 1) {
      secondCodePoint = this.codeUnitAt(index + 1);
      if (secondCodePoint.isLowSurrogate()) {
        return getAstralNumberFromSurrogatePair(
            firstCodePoint, secondCodePoint);
      }
    }
    return firstCodePoint;
  }

  ///Extracts the first [length] characters from a string
  String first(int length) =>
      this.length <= length ? this : this.substring(0, length);

  ///Extracts the last [length] characters from a string
  String last(int length) => this.length <= length
      ? this
      : this.substring(this.length - length, length);

  ///Get a grapheme from a string specified at an [index]
  String graphemeAt(int index) => this.characters.elementAt(index);

  ///Truncates a string to a new [length]
  ///
  ///Ensured that the words will not be broken, returned string is always less
  ///than or equal to the length provided
  ///TODO: Implement prune
  // String prune(int length) {
  //   String endString = "...";
  //   if (length >= this.length) return this;
  //   Pattern pattern = RegExp(REGEXP_EXTENDED_ASCII).hasMatch(this)
  //       ? REGEXP_LATIN_WORD
  //       : REGEXP_WORD;
  //   int truncatedLength = 0;
  //   if (match != null) {
  //     if (match.end <= length - 3) truncatedLength = match.end;
  //   }
  //   return this.substring(0, truncatedLength) + endString;
  // }
}
