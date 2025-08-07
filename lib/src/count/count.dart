import 'package:characters/characters.dart';
import '../split/words.dart';

/// Extension bundling functionalities related to counting string units
extension Count on String {
  /// Counts the characters in a string
  int count() => this.length;

  /// Counts the graphemes in a string
  int countGrapheme() => this.characters.length;

  /// Counts the occurences of [find] in a string
  int countOccurences(String find) {
    int count = 0;
    int matchIndex = 0;
    if (this.isEmpty || find.isEmpty) {
      return count;
    }
    do {
      matchIndex = this.indexOf(find, matchIndex);
      if (matchIndex != -1) {
        count++;
        matchIndex += find.length;
      }
    } while (matchIndex != -1);
    return count;
  }

  /// Counts the characters in a string for which predicate returns `true`
  int countWhere(bool Function(String character) predicate) {
    if (isEmpty) return 0;
    int count = 0;
    runes.forEach((rune) {
      if (predicate(String.fromCharCode(rune)) == true) count++;
    });
    return count;
  }

  /// Count the number of words in a string
  int countWords({String pattern=""}) => this.words(pattern: pattern).length;
}
