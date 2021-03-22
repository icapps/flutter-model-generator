import 'package:model_generator/model/item_type/date_time_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DateTimeType', () {
    test('DateTimeType', () {
      final field = DateTimeType();
      expect(field.name, 'DateTime');
    });
  });
}
