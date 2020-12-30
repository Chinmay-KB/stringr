import '../util/strings/force_strings.dart';
import '../util/strings/all_caps.dart';
import './capitalize.dart';
import '../split/words.dart';

extension CamelCase on String {
  String camelCase({bool preserveAcronym = false}) {
    final valString = this.forceToString();
    String camelCaseString = "";
    List<String> wordList = valString.words();
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
}
