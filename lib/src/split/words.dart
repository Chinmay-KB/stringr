import '../util/regex/const_regex.dart';

///Extension function bundling all functionalities related to splitting a string
extension Words on String {
  ///Split a string according to a given pattern/regex. Splits on [" "] by
  ///default. To split according to a regex, pass the regex pattern string to
  ///[regex] parameter
  List<String> words({String regex = " "}) => this.split(RegExp(regex));
  // List<String> words({Pattern pattern = ""}) {
  //   Pattern patternRegExp;
  //   if (pattern == " ")
  //     patternRegExp = RegExp(REGEXP_EXTENDED_ASCII).hasMatch(this)
  //         ? REGEXP_LATIN_WORD
  //         : REGEXP_WORD;
  //   else
  //     patternRegExp = pattern;

  //   return this.split(patternRegExp);
  // }
}
