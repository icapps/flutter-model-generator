import 'package:model_generator/model/item_type/object_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ObjectType', () {
    test('ObjectType', () {
      final field = ObjectType('MyCustomObject');
      expect(field.name, 'MyCustomObject');
    });
  });
}
