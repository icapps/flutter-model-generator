import 'package:flutter_test/flutter_test.dart';
import 'package:model_generator/model/item_type/map_type.dart';

void main() {
  group('Map Type', () {
    test('int, String Map Type', () {
      final field = MapType(key: 'int', valueName: 'String');
      expect(field.name, 'int');
      expect(field.valueName, 'String');
    });
    test('String, String Map Type ', () {
      final field = MapType(key: 'String', valueName: 'String');
      expect(field.name, 'String');
      expect(field.valueName, 'String');
    });
  });
}
