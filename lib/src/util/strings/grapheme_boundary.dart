import 'package:characters/characters.dart';

/// Code units below U+0300 never extend or join a grapheme cluster, so a
/// position between two of them is a cluster boundary, except inside `\r\n`.
bool _isTrivialBoundary(String text, int index) {
  final before = text.codeUnitAt(index - 1);
  final after = text.codeUnitAt(index);
  return before < 0x300 && after < 0x300 && !(before == 0x0D && after == 0x0A);
}

/// Returns the largest grapheme cluster boundary that is `<= index`.
///
/// [index] is a UTF-16 code unit offset and is clamped to `0..text.length`.
/// Pure ASCII/Latin-1 text takes a constant-time path; text that may contain
/// multi-unit clusters is walked with the `characters` package.
int graphemeFloor(String text, int index) {
  if (index <= 0) {
    return 0;
  }
  if (index >= text.length) {
    return text.length;
  }
  if (_isTrivialBoundary(text, index)) {
    return index;
  }
  var position = 0;
  for (final cluster in text.characters) {
    final next = position + cluster.length;
    if (next > index) {
      return position;
    }
    position = next;
  }
  return text.length;
}

/// Returns the smallest grapheme cluster boundary that is `>= index`.
///
/// [index] is a UTF-16 code unit offset and is clamped to `0..text.length`.
int graphemeCeil(String text, int index) {
  if (index <= 0) {
    return 0;
  }
  if (index >= text.length) {
    return text.length;
  }
  if (_isTrivialBoundary(text, index)) {
    return index;
  }
  var position = 0;
  for (final cluster in text.characters) {
    if (position >= index) {
      return position;
    }
    position += cluster.length;
  }
  return text.length;
}
