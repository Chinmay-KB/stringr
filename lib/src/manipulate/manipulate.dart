import 'package:characters/characters.dart';
import 'package:stringr/src/case/case.dart';
import 'package:stringr/src/chop/chop.dart';
import 'package:stringr/src/util/regex/const.dart';
import 'package:stringr/src/util/strings/diacritics_map.dart';
import 'package:stringr/src/util/strings/grapheme_boundary.dart';

/// Bundles destructive string manipulation functionalities
extension Manipulate on String {
  /// Inserts the [toInsert] string to a string at index [position]
  ///
  /// [position] is a UTF-16 code unit index, like [String.length]. If it falls
  /// inside a grapheme cluster (for example between the two halves of a
  /// surrogate pair), [toInsert] is placed before that cluster instead, so a
  /// cluster is never split. Out of range positions return the string as is.
  String insert(String toInsert, int position) {
    if (position < 0 || position > length || toInsert.isEmpty) {
      return this;
    }
    final at = graphemeFloor(this, position);
    return slice(0, at) + toInsert + slice(at);
  }

  /// Returns a latinised string
  ///
  /// Diacritics are removed and non Latin letters are transliterated, for
  /// example `café` becomes `cafe` and `straße` becomes `strasse`.
  String latinize() => isUnchangedByReplacement(this)
      ? this
      : String.fromCharCodes(replaceCodeUnits(codeUnits));

  /// Reverses a string. Works with strings containing graphemes
  String reverse() => characters.split(''.characters).toList().reversed.join();

  /// Slugifies the string and replaces diacritics with corresponding latin
  /// characters
  String slugify() =>
      latinize().replaceAll(RegExp(regexpNonLatin), '-').kebabCase();

  /// Changes a string by deleting [deleteCount] of chacters from the
  /// [startPosition]. Replaces [replacement] charactes instead of deleted
  /// characters
  ///
  /// [startPosition] and [deleteCount] are UTF-16 code unit based, like
  /// [String.length]. The affected range never splits a grapheme cluster: it
  /// is widened to cover every cluster it touches, so deleting half a
  /// surrogate pair deletes the whole pair. With a [deleteCount] of zero the
  /// replacement is inserted before the cluster containing [startPosition].
  /// A [deleteCount] that runs past the end of the string deletes up to the
  /// end and never throws.
  String splice(int deleteCount, int startPosition, String replacement) {
    if (startPosition < 0) {
      startPosition = length + startPosition;
      if (startPosition < 0) {
        startPosition = 0;
      }
    } else if (startPosition > length) {
      startPosition = length;
    }
    if (deleteCount < 0) {
      deleteCount = 0;
    } else if (deleteCount > length - startPosition) {
      // Deleting past the end deletes to the end. Clamping first also keeps
      // `startPosition + deleteCount` from overflowing.
      deleteCount = length - startPosition;
    }
    final start = graphemeFloor(this, startPosition);
    final end = deleteCount == 0
        ? start
        : graphemeCeil(this, startPosition + deleteCount);
    return slice(0, start) + replacement + slice(end);
  }

  /// Translate a string by replacing a given substring with another substring
  ///
  /// Provide translations as a `Map<String, String>` to [translations]
  ///
  /// The string is scanned once from left to right, so replacements never
  /// cascade: replaced text is not translated again. At each position the
  /// longest matching key wins. Empty keys are ignored.
  /// Example
  /// ```dart
  /// void main(){
  /// print("Hello world".translate({"ell":"ipp"}));
  /// // Output - "Hippo world"
  /// print("ab".translate({"a":"b", "b":"c"}));
  /// // Output - "bc"
  /// }
  /// ```
  String translate(Map<String, String> translations) {
    final keys = translations.keys.where((key) => key.isNotEmpty).toList();
    if (keys.isEmpty) {
      return this;
    }
    // Regex alternation picks the first alternative that matches, so listing
    // longer keys first makes the longest key win.
    keys.sort((a, b) => b.length.compareTo(a.length));
    final matcher = RegExp(keys.map(RegExp.escape).join('|'));
    return replaceAllMapped(matcher, (match) => translations[match[0]!]!);
  }

  // / Wraps a string to a given number of characters using a string break
  // / character
  // /
  // / [width] is the number of characters to wrap at. [newLine] is the string
  // / added at the end of a line. [indent] is the string used to indent the line.
  // / When [cut] is `false`(default), it does not split the word even if the
  // / word length is bigger than `width`. When `true`, words having bigger
  // / length than `width` are broken.
}
