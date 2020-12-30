import 'force_strings.dart';

extension AllCaps on String {
  bool allCaps() {
    final varString = this.forceToString();
    return varString.toUpperCase().compareTo(varString) == 0;
  }
}
