/// Helper extension function for Iterables
extension ExtendedIterable<E> on Iterable<E> {

  /// Like Iterable<T>.map but callback have index as second argument
  Iterable<T> mapIndex<T>(T f(E e, int i)) {
    var i = 0;
    return this.map((e) => f(e, i++));
  }

  /// Like Iterable<T>.forEach but callback has index as second argument
  // ignore: public_member_api_docs
  void forEachIndex(void f(E e, int i)) {
    var i = 0;
    this.forEach((e) => f(e, i++));
  }
}