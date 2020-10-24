import 'package:model_generator/model/item_type/date_time_type.dart';
import 'package:test/test.dart';

void main() {
  group('DateTimeType', () {
    test('DateTimeType', () {
      final field = DateTimeType();
      expect(field.name, 'DateTime');
    });
  });
}
