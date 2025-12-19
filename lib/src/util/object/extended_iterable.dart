/// Helper extension function for Iterables
extension ExtendedIterable<E> on Iterable<E> {
  /// Like `Iterable<T>.map` but callback has index as second argument
  Iterable<T> mapIndex<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  /// Like `Iterable<T>.forEach` but callback has index as second argument
  void forEachIndex(void Function(E e, int i) f) {
    var i = 0;
    forEach((e) => f(e, i++));
  }
}
