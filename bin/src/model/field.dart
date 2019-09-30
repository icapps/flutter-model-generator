import 'item_type/item_type.dart';

class Field {
  final String name;
  final ItemType type;
  final bool required;

  Field(this.name, this.type, this.required);

  @override
  String toString() {
    return 'Field{name: $name, type: $type, required: $required}';
  }
}
