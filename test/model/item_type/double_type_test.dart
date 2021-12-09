import 'package:model_generator/model/item_type/double_type.dart';
import 'package:test/test.dart';

void main() {
  group('DoubleType', () {
    test('DoubleType', () {
      final field = DoubleType();
      expect(field.name, 'double');
    });
  });
}
