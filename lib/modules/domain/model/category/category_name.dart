class CategoryName {
  final String value;
  CategoryName(this.value);

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) {
    return other is CategoryName &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }
}
