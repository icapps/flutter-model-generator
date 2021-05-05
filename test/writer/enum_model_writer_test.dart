import 'package:flutter_test/flutter_test.dart';
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
            value: 'MY_VALUE_1',
          ),
          EnumField(
            name: 'MY_VALUE_2',
            value: 'MY_VALUE_2',
          ),
        ],
      );
      WriterTestHelper.testEnumModelWriter(model, 'normal');
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
            value: 'MY_VALUE_1',
          ),
          EnumField(
            name: 'MY_VALUE_2',
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

    test('Normal EnumModel generate map', () {
      final model = EnumModel(
        name: 'MyEnumModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateMap: true,
        fields: [
          EnumField(
            name: 'MY_VALUE_1',
            value: 'customValue',
          ),
          EnumField(
            name: 'MY_VALUE_2',
          ),
        ],
      );
      WriterTestHelper.testEnumModelWriter(model, 'custom-value-map');
    });
  });
}
