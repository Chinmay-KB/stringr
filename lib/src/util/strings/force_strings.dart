extension ForceString on String {
  String forceToString({String defaultValue = ""}) {
    if (this == null)
      return defaultValue;
    else if (this.isEmpty)
      return defaultValue;
    else
      return this;
  }
}
