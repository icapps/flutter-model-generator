import 'package:model_generator/model/item_type/double_type.dart';
import 'package:model_generator/model/item_type/integer_type.dart';
import 'package:test/test.dart';
import 'package:model_generator/model/model/enum_model.dart';

import 'writer_test_helper.dart';

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
            rawName: 'MY_VALUE_1',
            value: 'MY_VALUE_1',
            description: 'A good description of this field',
          ),
          EnumField(
            name: 'MY_VALUE_2',
            rawName: 'MY_VALUE_2',
            value: 'MY_VALUE_2',
          ),
        ],
      );
      WriterTestHelper.testEnumModelWriter(model, 'normal');
    });

    test('Normal EnumModel with int type', () {
      final model = EnumModel(
        name: 'MyEnumModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        itemType: IntegerType(),
        fields: [
          EnumField(
            name: 'MY_VALUE_1',
            rawName: 'MY_VALUE_1',
            value: '1',
            description: 'A good description of this field',
          ),
          EnumField(
            name: 'MY_VALUE_2',
            rawName: 'MY_VALUE_2',
            value: '2',
          ),
        ],
      );
      WriterTestHelper.testEnumModelWriter(model, 'normal_with_int_type');
    });

    test('Normal EnumModel with int type generate map', () {
      final model = EnumModel(
        name: 'MyEnumModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        itemType: IntegerType(),
        generateMap: true,
        fields: [
          EnumField(
            name: 'MY_VALUE_1',
            rawName: 'MY_VALUE_1',
            value: '1',
            description: 'A good description of this field',
          ),
          EnumField(
            name: 'MY_VALUE_2',
            rawName: 'MY_VALUE_2',
            value: '2',
          ),
        ],
      );
      WriterTestHelper.testEnumModelWriter(model, 'normal_with_int_type_map');
    });

    test('Normal EnumModel with int type generate map extension', () {
      final model = EnumModel(
        name: 'MyEnumModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        itemType: IntegerType(),
        generateMap: true,
        generateExtensions: true,
        fields: [
          EnumField(
            name: 'MY_VALUE_1',
            rawName: 'MY_VALUE_1',
            value: '1',
            description: 'A good description of this field',
          ),
          EnumField(
            name: 'MY_VALUE_2',
            rawName: 'MY_VALUE_2',
            value: '2',
          ),
        ],
      );
      WriterTestHelper.testEnumModelWriter(
          model, 'normal_with_int_type_map_extension');
    });

    test('Normal EnumModel with double type', () {
      final model = EnumModel(
        name: 'MyEnumModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        itemType: DoubleType(),
        fields: [
          EnumField(
            name: 'MY_VALUE_1',
            rawName: 'MY_VALUE_1',
            value: '1',
            description: 'A good description of this field',
          ),
          EnumField(
            name: 'MY_VALUE_2',
            rawName: 'MY_VALUE_2',
            value: '2.2',
          ),
        ],
      );
      WriterTestHelper.testEnumModelWriter(model, 'normal_with_double_type');
    });

    test('Normal EnumModel with double type generate map', () {
      final model = EnumModel(
        name: 'MyEnumModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        itemType: DoubleType(),
        generateMap: true,
        fields: [
          EnumField(
            name: 'MY_VALUE_1',
            rawName: 'MY_VALUE_1',
            value: '1',
            description: 'A good description of this field',
          ),
          EnumField(
            name: 'MY_VALUE_2',
            rawName: 'MY_VALUE_2',
            value: '2.2',
          ),
        ],
      );
      WriterTestHelper.testEnumModelWriter(
          model, 'normal_with_double_type_map');
    });

    test('Normal EnumModel with double type generate map extension', () {
      final model = EnumModel(
        name: 'MyEnumModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        itemType: DoubleType(),
        generateMap: true,
        generateExtensions: true,
        fields: [
          EnumField(
            name: 'MY_VALUE_1',
            rawName: 'MY_VALUE_1',
            value: '1',
            description: 'A good description of this field',
          ),
          EnumField(
            name: 'MY_VALUE_2',
            rawName: 'MY_VALUE_2',
            value: '2.2',
          ),
        ],
      );
      WriterTestHelper.testEnumModelWriter(
          model, 'normal_with_double_type_map_extension');
    });

    test('Normal EnumModel custom value', () {
      final model = EnumModel(
        name: 'MyEnumModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          EnumField(
            name: 'MY_VALUE_1',
            rawName: 'MY_VALUE_1',
            value: 'MY_VALUE_1',
          ),
          EnumField(
            name: 'MY_VALUE_2',
            rawName: 'MY_VALUE_2',
            value: 'custom_value_2',
          ),
        ],
      );
      WriterTestHelper.testEnumModelWriter(model, 'custom-value');
    });

    test('Enum model with null enumfield.value ', () {
      final model = EnumModel(
        name: 'MyEnumModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          EnumField(
            name: 'MY_VALUE_1',
            rawName: 'MY_VALUE_1',
            value: 'MY_VALUE_1',
          ),
          EnumField(
            name: 'MY_VALUE_2',
            rawName: 'MY_VALUE_2',
          ),
        ],
      );
      WriterTestHelper.testEnumModelWriter(model, 'null-value');
    });

    test('EnumModel with no fields ', () {
      final model = EnumModel(
        name: 'MyEnumModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [],
      );
      WriterTestHelper.testEnumModelWriter(model, 'no-fields');
    });

    test('Custom EnumModel generate map', () {
      final model = EnumModel(
        name: 'MyEnumModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateMap: true,
        fields: [
          EnumField(
            name: 'MY_VALUE_1',
            rawName: 'MY_VALUE_1',
            value: 'customValue',
          ),
          EnumField(
            name: 'MY_VALUE_2',
            rawName: 'MY_VALUE_2',
          ),
        ],
      );
      WriterTestHelper.testEnumModelWriter(model, 'custom-value-map');
    });

    test('Custom EnumModel generate map extension', () {
      final model = EnumModel(
        name: 'MyEnumModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateMap: true,
        generateExtensions: true,
        fields: [
          EnumField(
            name: 'MY_VALUE_1',
            rawName: 'MY_VALUE_1',
            value: 'customValue',
          ),
          EnumField(
            name: 'MY_VALUE_2',
            rawName: 'MY_VALUE_2',
          ),
        ],
      );
      WriterTestHelper.testEnumModelWriter(model, 'custom-value-map-extension');
    });

    test('Normal EnumModel with description', () {
      final model = EnumModel(
        name: 'MyEnumModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          EnumField(
            name: 'MY_VALUE_1',
            rawName: 'MY_VALUE_1',
            value: 'MY_VALUE_1',
            description: 'A good description of this field',
          ),
          EnumField(
            name: 'MY_VALUE_2',
            rawName: 'MY_VALUE_2',
            value: 'MY_VALUE_2',
          ),
        ],
        description: 'A good description of this enum',
      );
      WriterTestHelper.testEnumModelWriter(model, 'normal-description');
    });
  });
}
