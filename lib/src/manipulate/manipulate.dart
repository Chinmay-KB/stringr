import '../chop/chop.dart';
import '../util/strings/diacritics_map.dart';
import '../util/regex/const.dart';
import '../case/case.dart';
import 'package:characters/characters.dart';

/// Bundles destructive string manipulation functionalities
extension Manipulate on String {
  /// Inserts the [toInsert] string to a string at index [position]
  String insert(String toInsert, int position) {
    if (position < 0 || position > this.length || toInsert.isEmpty) return this;
    return this.slice(0, position) + toInsert + this.slice(position);
  }

  /// Returns a latinised string
  String latinize() => String.fromCharCodes(replaceCodeUnits(this.codeUnits));

  /// Reverses a string. Works with strings containing graphemes
  String reverse() =>
      this.characters.split(''.characters).toList().reversed.join('');

  /// Slugifies the string and replaces diacritics with corresponding latin
  /// characters
  String slugify() =>
      this.latinize().replaceAll(RegExp(REGEXP_NON_LATIN), '-').kebabCase();

  /// Changes a string by deleting [deleteCount] of chacters from the
  /// [startPosition]. Replaces [replacement] charactes instead of deleted
  /// characters
  String splice(int deleteCount, int startPosition, String replacement) {
    if (startPosition < 0) {
      startPosition = this.length + startPosition;
      if (startPosition < 0) startPosition = 0;
    } else if (startPosition > this.length) startPosition = this.length;
    if (deleteCount < 0) deleteCount = 0;
    return this.slice(0, startPosition) +
        replacement +
        this.slice(startPosition + deleteCount);
  }
}
