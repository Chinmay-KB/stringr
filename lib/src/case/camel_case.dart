import '../util/strings/force_strings.dart';
import './capitalize.dart';
import '../split/words.dart';

extension CamelCase on String {
  String camelCase() {
    final valString = this.forceToString();
    String camelCaseString = "";
    List<String> wordList = valString.words();
    wordList.asMap().forEach((index, word) {
      camelCaseString += index == 0
          ? word.toLowerCase()
          : word.capitalize(capitalizeAll: false);
    });
    // for (int index = 0; index < wordList.length; index++) {
    //   camelCaseString += wordToCamel(wordList[index], index);
    // }
    return camelCaseString;
  }
}

// String wordToCamel(String word, int index) =>
//     index == 0 ? word.toLowerCase() : word.capitalize(capitalizeAll: false);
