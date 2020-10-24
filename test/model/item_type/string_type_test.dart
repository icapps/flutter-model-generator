import 'package:model_generator/model/item_type/string_type.dart';
import 'package:test/test.dart';

void main() {
  group('String Type', () {
    test('String Type', () {
      final field = StringType();
      expect(field.name, 'String');
    });
  });
}
