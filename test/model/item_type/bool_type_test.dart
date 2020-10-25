import 'package:model_generator/model/item_type/boolean_type.dart';
import 'package:test/test.dart';

void main() {
  group('BooleanType', () {
    test('BooleanType', () {
      final field = BooleanType();
      expect(field.name, 'bool');
    });
  });
}
