///Utility extension function bundling all functionalities related to Strings.
extension Strings on String {

  ///Checks whether a provided string has all characters in uppercase.
  bool allCaps() => this.toUpperCase().compareTo(this) == 0;
  }

  // String forceToString({String defaultValue = ""}) {
  //   if (this == null)
  //     return defaultValue;
  //   else if (this.isEmpty)
  //     return defaultValue;
  //   else
  //     return this;
  // }
