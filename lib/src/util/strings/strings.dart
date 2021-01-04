import '../regex/const_regex.dart';

/// Utility extension function bundling all functionalities related to Strings.
extension Strings on String {
  /// Checks whether a provided string is all uppercase.
  bool isUpperCase() => this.toUpperCase().compareTo(this) == 0;

  /// Checks whether the provided string is in all lowerCase
  bool isLowerCase() => this.toLowerCase().compareTo(this) == 0;

  /// Checks whether the string is all aplhabets
  bool isAlphabet() => REGEXP_ALPHA.hasMatch(this);
}
