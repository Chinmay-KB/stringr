import 'package:characters/characters.dart';
import 'dart:convert' show utf8;
import '../util/strings/surrogate_pair.dart';

///Extension bundling all functions related to destructive string manipulation
extension Chop on String {
  ///Get a character from a specific index
  String charAt(int index) => this[index];

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
      : this.substring(this.length - length, this.length);

  ///Get a grapheme from a string specified at an [index]
  String graphemeAt(int index) => this.characters.elementAt(index);

  ///Returns a string of reduced size. Length of returned string is
  ///<=[pruneLength]
  ///
  ///Ensured that the words will not be broken, returned string is always less
  ///than or equal to the [pruneLength] provided
  ///TODO: Implement prune
  String prune(int pruneLength) {
    String result;
    if (this.length <= pruneLength)
      result = this;
    else {
      result = this.substring(0, pruneLength);
      if (this[pruneLength] != " ") {
        result = result.substring(0, result.lastIndexOf(" "));
      }
    }
    return result;
  }

  ///Slice from a string a partial string from [start] index to [end] index.
  String slice(int start, [int? end]) => this.substring(start, end);

  ///Truncates a string to the provided [truncateLength]
  String truncate(int truncateLength, {String endString = "..."}) =>
      truncateLength >= this.length
          ? this
          : this.slice(0,truncateLength - endString.length) +
              endString;
}
