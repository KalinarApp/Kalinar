extension ListExtension<T> on List<T> {
  List updateItem(int index, T item) {
    this[index] = item;
    return this;
  }
}
