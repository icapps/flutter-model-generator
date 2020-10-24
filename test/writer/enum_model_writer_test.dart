import 'package:model_generator/model/model/enum_model.dart';
import 'package:model_generator/writer/enum_model_writer.dart';
import 'package:test/test.dart';

void main() {
  group('EnumModel', () {
    test('Normal EnumModel', () {
      final model = EnumModel(
        name: 'MyEnumModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          EnumField(
            name: 'MY_VALUE_1',
            value: 'MY_VALUE_1',
          ),
          EnumField(
            name: 'MY_VALUE_2',
            value: 'MY_VALUE_2',
          ),
        ],
      );
      final writer = EnumModelWriter(model);
      expect(writer.write(), r'''
import 'package:json_annotation/json_annotation.dart';

enum MyEnumModel {
  @JsonValue('MY_VALUE_1')
  MY_VALUE_1,
  @JsonValue('MY_VALUE_2')
  MY_VALUE_2,
}
''');
    });

    test('Normal EnumModel custom value', () {
      final model = EnumModel(
        name: 'MyEnumModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          EnumField(
            name: 'MY_VALUE_1',
            value: 'MY_VALUE_1',
          ),
          EnumField(
            name: 'MY_VALUE_2',
            value: 'custom_value_2',
          ),
        ],
      );
      final writer = EnumModelWriter(model);
      expect(writer.write(), r'''
import 'package:json_annotation/json_annotation.dart';

enum MyEnumModel {
  @JsonValue('MY_VALUE_1')
  MY_VALUE_1,
  @JsonValue('custom_value_2')
  MY_VALUE_2,
}
''');
    });

    test('Enum model with null enumfield.value ', () {
      final model = EnumModel(
        name: 'MyEnumModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          EnumField(
            name: 'MY_VALUE_1',
            value: 'MY_VALUE_1',
          ),
          EnumField(
            name: 'MY_VALUE_2',
          ),
        ],
      );
      final writer = EnumModelWriter(model);
      expect(writer.write(), r'''
import 'package:json_annotation/json_annotation.dart';

enum MyEnumModel {
  @JsonValue('MY_VALUE_1')
  MY_VALUE_1,
  @JsonValue('MY_VALUE_2')
  MY_VALUE_2,
}
''');
    });

    test('EnumModel with no fields ', () {
      final model = EnumModel(
        name: 'MyEnumModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [],
      );
      final writer = EnumModelWriter(model);
      expect(writer.write(), r'''
import 'package:json_annotation/json_annotation.dart';

enum MyEnumModel {
}
''');
    });
  });
}
