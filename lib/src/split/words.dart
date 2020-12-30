///Extension function bundling all functionalities related to splitting a string
extension Words on String {
  ///Split a string according to a given pattern/regex. Splits on [" "] by
  ///default. To split according to a regex, pass the regex pattern string to
  ///[regex] parameter
  List<String> words({String regex = " "}) => this.split(RegExp(regex));
}
