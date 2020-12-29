import '../util/strings/force_strings.dart';

extension Words on String {
  List<String> words({String regex = " "}) {
    final valString = this.forceToString();
    return valString.split(RegExp(regex));
  }
}
