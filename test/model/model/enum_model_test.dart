import 'package:model_generator/model/model/enum_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EnumModel', () {
    group('Default', () {
      test('Normal EnumModel', () {
        final model = EnumModel(
          name: 'MyEnumModel',
          path: 'path_to_my_model',
          baseDirectory: 'base_dir',
        );
        expect(model.name, 'MyEnumModel');
        expect(model.path, 'path_to_my_model');
        expect(model.baseDirectory, 'base_dir');
      });
    });
    group('Custom Path', () {
      test('Normal Custom Path', () {
        final model = EnumModel(
          name: 'MyEnumModel',
          path: 'path_to_my_model/',
          baseDirectory: 'base_dir',
        );
        expect(model.name, 'MyEnumModel');
        expect(model.path, 'path_to_my_model');
        expect(model.baseDirectory, 'base_dir');
      });

      test('Normal Custom Base Dir', () {
        final model = EnumModel(
          name: 'MyEnumModel',
          path: 'path_to_my_model',
          baseDirectory: 'base_dir/',
        );
        expect(model.name, 'MyEnumModel');
        expect(model.path, 'path_to_my_model');
        expect(model.baseDirectory, 'base_dir');
      });
    });
  });

  group('EnumField', () {
    group('Default', () {
      test('Normal EnumField', () {
        final field = EnumField(
            name: 'MY_ENUM_VALUE',
            rawName: 'MY_ENUM_VALUE',
            value: 'MY_ENUM_VALUE');
        expect(field.name, 'MY_ENUM_VALUE');
        expect(field.serializedName, 'MY_ENUM_VALUE');
        expect(field.value, 'MY_ENUM_VALUE');
      });
      test('Normal EnumField, lowercased', () {
        final field = EnumField(
            name: 'my_enum_value',
            rawName: 'MY_ENUM_VALUE',
            value: 'MY_ENUM_VALUE');
        expect(field.name, 'my_enum_value');
        expect(field.serializedName, 'MY_ENUM_VALUE');
        expect(field.value, 'MY_ENUM_VALUE');
      });
    });
    group('Custom serializedName', () {
      test('Normal Custom Base Dir', () {
        final field = EnumField(
            name: 'MY_ENUM_VALUE',
            rawName: 'my_enum_value',
            value: 'my_enum_value');
        expect(field.name, 'MY_ENUM_VALUE');
        expect(field.serializedName, 'my_enum_value');
        expect(field.value, 'my_enum_value');
      });
    });
  });
}
