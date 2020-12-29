import '../util/strings/force_strings.dart';

extension Capitalize on String {
  String capitalize({bool capitalizeAll = false}) {
    final valString = this.forceToString();
    if (capitalizeAll) {
      return valString.toUpperCase();
    } else {
      if (valString.length == 0)
        return valString.toUpperCase();
      else
        return valString[0].toUpperCase() + valString.substring(1);
    }
  }
}
