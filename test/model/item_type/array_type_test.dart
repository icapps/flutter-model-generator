import 'package:model_generator/model/item_type/array_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Array Type', () {
    test('int Array Type', () {
      final field = ArrayType('int');
      expect(field.name, 'int');
    });
    test('String Array Type ', () {
      final field = ArrayType('String');
      expect(field.name, 'String');
    });
  });
}
