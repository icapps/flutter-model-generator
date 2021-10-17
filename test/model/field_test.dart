import 'package:flutter_test/flutter_test.dart';
import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/item_type/string_type.dart';

void main() {
  group('Default', () {
    test('Normal field', () {
      final field = Field(
        name: 'fieldName',
        type: StringType(),
        isRequired: true,
        ignore: true,
        includeIfNull: true,
        nonFinal: true,
        ignoreEquality: false,
        unknownEnumValue: 'Unknown Enum Value',
      );
      expect(field.name, 'fieldName');
      expect(field.type.runtimeType, StringType);
      expect(field.isRequired, true);
      expect(field.ignore, true);
      expect(field.includeIfNull, true);
      expect(field.nonFinal, true);
      expect(field.ignoreEquality, false);
      expect(field.unknownEnumValue, 'Unknown Enum Value');
      expect(field.serializedName, 'fieldName');
    });

    test('Case util for name', () {
      final field = Field(
        name: 'FieldName',
        type: StringType(),
        isRequired: true,
        ignore: true,
        includeIfNull: true,
        ignoreEquality: true,
        nonFinal: true,
        unknownEnumValue: 'Unknown Enum Value',
      );
      expect(field.name, 'fieldName');
      expect(field.type.runtimeType, StringType);
      expect(field.isRequired, true);
      expect(field.ignore, true);
      expect(field.includeIfNull, true);
      expect(field.ignoreEquality, true);
      expect(field.nonFinal, true);
      expect(field.unknownEnumValue, 'Unknown Enum Value');
      expect(field.serializedName, 'FieldName');
    });
  });

  group('Custom SerializedName', () {
    test('Normal field', () {
      final field = Field(
        name: 'fieldName',
        type: StringType(),
        isRequired: true,
        ignore: true,
        includeIfNull: true,
        ignoreEquality: true,
        nonFinal: true,
        unknownEnumValue: 'Unknown Enum Value',
        jsonKey: 'field_name',
      );
      expect(field.name, 'fieldName');
      expect(field.type.runtimeType, StringType);
      expect(field.isRequired, true);
      expect(field.ignore, true);
      expect(field.includeIfNull, true);
      expect(field.nonFinal, true);
      expect(field.unknownEnumValue, 'Unknown Enum Value');
      expect(field.serializedName, 'field_name');
    });

    test('Case util for name', () {
      final field = Field(
        name: 'FieldName',
        type: StringType(),
        isRequired: true,
        ignore: true,
        includeIfNull: true,
        ignoreEquality: true,
        nonFinal: true,
        unknownEnumValue: 'Unknown Enum Value',
        jsonKey: 'field_name',
      );
      expect(field.name, 'fieldName');
      expect(field.type.runtimeType, StringType);
      expect(field.isRequired, true);
      expect(field.ignore, true);
      expect(field.includeIfNull, true);
      expect(field.nonFinal, true);
      expect(field.unknownEnumValue, 'Unknown Enum Value');
      expect(field.serializedName, 'field_name');
    });
  });
}
