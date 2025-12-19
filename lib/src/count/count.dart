import 'package:characters/characters.dart';
import 'package:stringr/src/split/words.dart';

/// Extension bundling functionalities related to counting string units
extension Count on String {
  /// Counts the characters in a string
  @Deprecated('Use .length instead')
  int count() => length;

  /// Counts the graphemes in a string
  int countGrapheme() => characters.length;

  /// Counts the occurrences of [find] in a string
  int countOccurrences(String find) {
    var count = 0;
    var matchIndex = 0;
    if (isEmpty || find.isEmpty) {
      return count;
    }
    do {
      matchIndex = indexOf(find, matchIndex);
      if (matchIndex != -1) {
        count++;
        matchIndex += find.length;
      }
    } while (matchIndex != -1);
    return count;
  }

  /// Counts the occurrences of [find] in a string
  @Deprecated('Use countOccurrences instead (note the spelling)')
  int countOccurences(String find) => countOccurrences(find);

  /// Counts the characters in a string for which predicate returns `true`
  int countWhere(bool Function(String character) predicate) {
    if (isEmpty) {
      return 0;
    }
    var count = 0;
    for (final rune in runes) {
      if (predicate(String.fromCharCode(rune)) == true) {
        count++;
      }
    }
    return count;
  }

  /// Count the number of words in a string
  int countWords({String pattern = ""}) => words(pattern: pattern).length;
}
