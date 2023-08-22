import 'package:model_generator/config/pubspec_config.dart';
import 'package:model_generator/config/yml_generator_config.dart';
import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/item_type/array_type.dart';
import 'package:model_generator/model/item_type/boolean_type.dart';
import 'package:model_generator/model/item_type/date_time_type.dart';
import 'package:model_generator/model/item_type/double_type.dart';
import 'package:model_generator/model/item_type/dynamic_type.dart';
import 'package:model_generator/model/item_type/integer_type.dart';
import 'package:model_generator/model/item_type/map_type.dart';
import 'package:model_generator/model/item_type/object_type.dart';
import 'package:model_generator/model/item_type/string_type.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:test/test.dart';

void main() {
  group('ModelReaderTest', () {
    test('Test simple basic fields', () {
      final models = YmlGeneratorConfig(
              PubspecConfig("name: test"),
              """
TestModel:
  properties:
    simpleString: string
    nullableString: string?
    simpleInt: int
    simpleBool: bool
    simpleDouble: double
    simpleDynamic: dynamic
    simpleDateTime: datetime?
""",
              '')
          .models;

      expect(models.length, 1);
      final model = models.first;
      expect(model is ObjectModel, true);
      model as ObjectModel;

      final simpleString = model.fields.getByName("simpleString");
      final nullableString = model.fields.getByName("nullableString");
      final simpleInt = model.fields.getByName("simpleInt");
      final simpleBool = model.fields.getByName("simpleBool");
      final simpleDouble = model.fields.getByName("simpleDouble");
      final simpleDynamic = model.fields.getByName("simpleDynamic");
      final simpleDateTime = model.fields.getByName("simpleDateTime");

      expect(simpleString.type, isA<StringType>());
      expect(simpleString.isRequired, true);

      expect(nullableString.type, isA<StringType>());
      expect(nullableString.isRequired, false);

      expect(simpleInt.type, isA<IntegerType>());
      expect(simpleInt.isRequired, true);

      expect(simpleBool.type, isA<BooleanType>());
      expect(simpleBool.isRequired, true);

      expect(simpleDouble.type, isA<DoubleType>());
      expect(simpleDouble.isRequired, true);

      expect(simpleDynamic.type, isA<DynamicType>());
      expect(simpleDynamic.isRequired, true);

      expect(simpleDateTime.type, isA<DateTimeType>());
      expect(simpleDateTime.isRequired, false);
    });

    test('Test required not definable anymore', () {
      final models = YmlGeneratorConfig(
              PubspecConfig("name: test"),
              """
TestModel:
  properties:
    optionalString1:
        type: String?
        required: true
    optionalString2:
        type: String?
    requiredString1:
        type: String
        required: false
    requiredString2:
        type: String
""",
              '')
          .models;

      expect(models.length, 1);
      final model = models.first;
      expect(model is ObjectModel, true);
      model as ObjectModel;

      final optionalString1 = model.fields.getByName("optionalString1");
      final requiredString1 = model.fields.getByName("requiredString1");
      final optionalString2 = model.fields.getByName("optionalString2");
      final requiredString2 = model.fields.getByName("requiredString2");

      expect(optionalString1.type, isA<StringType>());
      expect(optionalString1.isRequired, false);

      expect(requiredString1.type, isA<StringType>());
      expect(requiredString1.isRequired, true);

      expect(optionalString2.type, isA<StringType>());
      expect(optionalString2.isRequired, false);

      expect(requiredString2.type, isA<StringType>());
      expect(requiredString2.isRequired, true);
    });

    test('Test List not supported anymore', () {
      dynamic error;
      try {
        final config = YmlGeneratorConfig(
            PubspecConfig("name: test"),
            """
TestModel:
  properties:
    list: 
      type: array
      items:
        type: String
""",
            '');

        config.checkIfTypesAvailable();
      } catch (e) {
        error = e;
      }
      expect(error, isNotNull);
    });

    test('Test Map not supported anymore', () {
      dynamic error;
      try {
        final config = YmlGeneratorConfig(
            PubspecConfig("name: test"),
            """
TestModel:
  properties:
    list: 
      type: map
      items:
        key: String
        value: String
""",
            '');

        config.checkIfTypesAvailable();
      } catch (e) {
        error = e;
      }
      expect(error, isNotNull);
    });

    test('Test simple generic fields', () {
      final models = YmlGeneratorConfig(
              PubspecConfig("name: test"),
              """
TestModel:
  properties:
    simpleStringList: List<string>
    nullableStringList: List<string>?
    simpleMap: Map<String, int>
""",
              '')
          .models;

      expect(models.length, 1);
      final model = models.first;
      expect(model is ObjectModel, true);
      model as ObjectModel;

      final simpleStringList = model.fields.getByName("simpleStringList");
      final nullableStringList = model.fields.getByName("nullableStringList");
      final simpleMap = model.fields.getByName("simpleMap");

      expect(simpleStringList.type, isA<ArrayType>());
      expect(simpleStringList.isRequired, true);

      expect(nullableStringList.type, isA<ArrayType>());
      expect(nullableStringList.isRequired, false);

      expect(simpleMap.type, isA<MapType>());
      expect(simpleMap.isRequired, true);
    });
    test('Test simple object reference fields', () {
      final models = YmlGeneratorConfig(
              PubspecConfig("name: test"),
              """
TestModel:
  properties:
    simpleRef: TestModel2
    listRef: List<TestModel2>?
    nullableRef: TestModel2?
TestModel2:
  properties:
    simpleMap: Map<String, int>
""",
              '')
          .models;

      expect(models.length, 2);
      final model = models.firstWhere((element) => element.name == 'TestModel');
      expect(model is ObjectModel, true);
      model as ObjectModel;

      final simpleRef = model.fields.getByName("simpleRef");
      final listRef = model.fields.getByName("listRef");
      final nullableRef = model.fields.getByName("nullableRef");

      expect(simpleRef.type, isA<ObjectType>());
      expect(simpleRef.isRequired, true);

      expect(listRef.type, isA<ArrayType>());
      expect(listRef.isRequired, false);

      expect(nullableRef.type, isA<ObjectType>());
      expect(nullableRef.isRequired, false);
    });
  });
}

extension _ListHelper on List<Field> {
  Field getByName(String name) {
    return firstWhere((element) => element.name == name);
  }
}
