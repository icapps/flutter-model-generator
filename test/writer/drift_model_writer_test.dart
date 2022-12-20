import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/item_type/string_type.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:test/test.dart';

import 'writer_test_helper.dart';

void main() {
  group('DriftModelWriter', () {
    test('Normal DriftModelWriter', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        staticCreate: false,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: false,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
            description: 'A good description',
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testDriftModelWriter(model, [], 'normal');
    });

    test('Normal DriftModelWriter with specified databasePath', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        staticCreate: false,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: false,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
            description: 'A good description',
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testDriftModelWriter(model, [], 'normal');
    });
  });
}
