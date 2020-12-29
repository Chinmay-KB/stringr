import '../util/strings/force_strings.dart';

extension LowerCase on String {
  String lowerCase() {
    final valString = this.forceToString();
    return valString.toLowerCase();
  }
}
