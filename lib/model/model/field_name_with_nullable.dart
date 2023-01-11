class FieldNameWithNullable {
  final String name;
  final bool isNullable;

  FieldNameWithNullable(this.name, this.isNullable);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FieldNameWithNullable &&
        other.name == name &&
        other.isNullable == isNullable;
  }

  @override
  int get hashCode => name.hashCode ^ isNullable.hashCode;
}
