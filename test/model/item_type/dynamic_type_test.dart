import 'package:model_generator/model/item_type/dynamic_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DynamicType', () {
    test('DynamicType', () {
      final field = DynamicType();
      expect(field.name, 'dynamic');
    });
  });
}
