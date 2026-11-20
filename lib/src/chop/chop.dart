import 'package:characters/characters.dart';
import 'package:stringr/src/util/strings/grapheme_boundary.dart';
import 'package:stringr/src/util/strings/surrogate_pair.dart';

final _whitespace = RegExp(r'\s');

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
  ///
  /// [length] counts UTF-16 code units, like [String.length]. The result never
  /// splits a grapheme cluster (surrogate pair, combining sequence, ZWJ emoji,
  /// `\r\n`): if the cut would fall inside a cluster, the whole cluster is
  /// left out, so the result is at most [length] code units long. For text
  /// where every grapheme is a single code unit the result is unchanged. A
  /// negative [length] returns an empty string.
  String first(int length) =>
      this.length <= length ? this : substring(0, graphemeFloor(this, length));

  /// Extracts the last [length] characters from a string
  ///
  /// [length] counts UTF-16 code units, like [String.length]. The result never
  /// splits a grapheme cluster: if the cut would fall inside a cluster, the
  /// whole cluster is left out, so the result is at most [length] code units
  /// long. For text where every grapheme is a single code unit the result is
  /// unchanged. A negative [length] returns an empty string.
  String last(int length) => this.length <= length
      ? this
      : substring(
          length <= 0 ? this.length : graphemeCeil(this, this.length - length));

  /// Get a grapheme from a string specified at an [index]
  String graphemeAt(int index) => characters.elementAt(index);

  /// Returns a string of reduced size. Length of returned string is
  /// <=[pruneLength]
  ///
  /// Ensures that words will not be broken, returned string is always less
  /// than or equal to the [pruneLength] provided. Handles spaces, tabs, and
  /// other whitespace characters.
  ///
  /// [pruneLength] counts UTF-16 code units, like [String.length]. The result
  /// never splits a grapheme cluster: a cluster that straddles the cut is
  /// dropped entirely. A negative [pruneLength] returns an empty string.
  String prune(int pruneLength) {
    if (length <= pruneLength) {
      return this;
    }

    final cut = graphemeFloor(this, pruneLength);
    final result = substring(0, cut);
    // Check if we're in the middle of a word
    if (cut < length && !_whitespace.hasMatch(this[cut])) {
      final lastWhitespace = result.lastIndexOf(_whitespace);
      if (lastWhitespace > 0) {
        return result.substring(0, graphemeFloor(result, lastWhitespace));
      }
    }
    return result;
  }

  /// Slice from a string a partial string from [start] index to [end] index.
  String slice(int start, [int? end]) => substring(start, end);

  /// Truncates a string to the provided [truncateLength]
  ///
  /// [truncateLength] counts UTF-16 code units, like [String.length], and
  /// includes [endString]. Strings that already fit are returned unchanged.
  /// The cut never splits a grapheme cluster, so the result can be a little
  /// shorter than [truncateLength] but never longer.
  ///
  /// This method never throws. If [truncateLength] is smaller than the length
  /// of [endString], the result is [endString] clipped to [truncateLength]
  /// (for example `'hello world'.truncate(2)` is `'..'`). A zero or negative
  /// [truncateLength] returns an empty string.
  String truncate(int truncateLength, {String endString = "..."}) {
    if (truncateLength >= length) {
      return this;
    }
    if (truncateLength <= endString.length) {
      return endString.first(truncateLength);
    }
    return substring(
            0, graphemeFloor(this, truncateLength - endString.length)) +
        endString;
  }
}
