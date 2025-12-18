import 'package:stringr/src/util/regex/const_regex.dart';

/// Utility extension function bundling all functionalities related to Strings.
extension Strings on String {
  /// Checks whether a provided string is all uppercase.
  bool isUpperCase() => toUpperCase().compareTo(this) == 0;

  /// Checks whether the provided string is in all lowerCase
  bool isLowerCase() => toLowerCase().compareTo(this) == 0;

  /// Checks whether the string is all aplhabets
  bool isAlphabet() => regexpAlpha.hasMatch(this);
}
