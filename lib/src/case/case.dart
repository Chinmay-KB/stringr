import '../util/strings/strings.dart';
import '../split/words.dart';

/// Extension function bundling all functionalities related to case manipulation
/// [camelCase()]
extension Case on String {

  ///Changes a string into camelCase
  ///
  ///To prevent acronyms from being converted to upper or lowercase,
  ///[preserveAcronym] can be set to `true`.
  String camelCase({bool preserveAcronym = false}) {
    String camelCaseString = "";
    List<String> wordList = this.words();
    wordList.asMap().forEach(
      (index, word) {
        camelCaseString += index == 0
            ? (preserveAcronym)
                ? (word.allCaps() ? word : word.toLowerCase())
                : word.toLowerCase()
            : word.capitalize(capitalizeAll: false);
      },
    );
    return camelCaseString;
  }

  ///Capitalizes the first character of the string
  String capitalize({bool capitalizeAll = false}) {
    if (capitalizeAll) {
      return this.toUpperCase();
    } else {
      if (this.length == 0)
        return this.toUpperCase();
      else
        return this[0].toUpperCase() + this.substring(1);
    }
  }

}
