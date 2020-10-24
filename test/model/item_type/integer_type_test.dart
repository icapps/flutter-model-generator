import 'package:model_generator/model/item_type/integer_type.dart';
import 'package:test/test.dart';

void main() {
  group('IntegerType', () {
    test('IntegerType', () {
      final field = IntegerType();
      expect(field.name, 'int');
    });
  });
}
