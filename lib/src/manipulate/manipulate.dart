import 'package:characters/characters.dart';
import 'package:stringr/src/case/case.dart';
import 'package:stringr/src/chop/chop.dart';
import 'package:stringr/src/util/regex/const.dart';
import 'package:stringr/src/util/strings/diacritics_map.dart';

/// Bundles destructive string manipulation functionalities
extension Manipulate on String {
  /// Inserts the [toInsert] string to a string at index [position]
  String insert(String toInsert, int position) {
    if (position < 0 || position > length || toInsert.isEmpty) {
      return this;
    }
    return slice(0, position) + toInsert + slice(position);
  }

  /// Returns a latinised string
  String latinize() => String.fromCharCodes(replaceCodeUnits(codeUnits));

  /// Reverses a string. Works with strings containing graphemes
  String reverse() => characters.split(''.characters).toList().reversed.join();

  /// Slugifies the string and replaces diacritics with corresponding latin
  /// characters
  String slugify() =>
      latinize().replaceAll(RegExp(regexpNonLatin), '-').kebabCase();

  /// Changes a string by deleting [deleteCount] of chacters from the
  /// [startPosition]. Replaces [replacement] charactes instead of deleted
  /// characters
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
    }
    return slice(0, startPosition) +
        replacement +
        slice(startPosition + deleteCount);
  }

  /// Translate a string by replacing a given substring with another substring
  ///
  /// Provide translations as a `Map<String, String>` to [translations]
  /// Example
  /// ```dart
  /// void main(){
  /// print("Hello world".translate({"ell":"ipp"}));
  /// // Output - "Hippo World"
  /// }
  /// ```
  String translate(Map<String, String> translations) {
    var translated = this;
    translations.forEach(
      (key, value) {
        translated = translated.replaceAll(key, value);
      },
    );
    return translated;
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
