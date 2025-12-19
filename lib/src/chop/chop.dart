import 'package:characters/characters.dart';
import 'package:stringr/src/util/strings/surrogate_pair.dart';

/// Extension bundling all functions related to destructive string manipulation
extension Chop on String {
  /// Get a character from a specific index
  @Deprecated('Use string[index] instead')
  String charAt(int index) => this[index];

  /// Get the unicode point value from a specific index
  int codePointAt(int index) {
    final firstCodePoint = codeUnitAt(index);
    int secondCodePoint;
    if (firstCodePoint.isHighSurrogate() && length > index + 1) {
      secondCodePoint = codeUnitAt(index + 1);
      if (secondCodePoint.isLowSurrogate()) {
        return getAstralNumberFromSurrogatePair(
            firstCodePoint, secondCodePoint);
      }
    }
    return firstCodePoint;
  }

  /// Extracts the first [length] characters from a string
  String first(int length) =>
      this.length <= length ? this : substring(0, length);

  /// Extracts the last [length] characters from a string
  String last(int length) => this.length <= length
      ? this
      : substring(this.length - length, this.length);

  /// Get a grapheme from a string specified at an [index]
  String graphemeAt(int index) => characters.elementAt(index);

  /// Returns a string of reduced size. Length of returned string is
  /// <=[pruneLength]
  ///
  /// Ensures that words will not be broken, returned string is always less
  /// than or equal to the [pruneLength] provided. Handles spaces, tabs, and
  /// other whitespace characters.
  String prune(int pruneLength) {
    if (length <= pruneLength) {
      return this;
    }

    final result = substring(0, pruneLength);
    // Check if we're in the middle of a word
    if (pruneLength < length && !RegExp(r'\s').hasMatch(this[pruneLength])) {
      final lastWhitespace = result.lastIndexOf(RegExp(r'\s'));
      if (lastWhitespace > 0) {
        return result.substring(0, lastWhitespace);
      }
    }
    return result;
  }

  /// Slice from a string a partial string from [start] index to [end] index.
  String slice(int start, [int? end]) => substring(start, end);

  /// Truncates a string to the provided [truncateLength]
  String truncate(int truncateLength, {String endString = "..."}) =>
      truncateLength >= length
          ? this
          : slice(0,truncateLength - endString.length) +
              endString;
}
