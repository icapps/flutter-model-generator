import 'package:model_generator/model/model/object_model.dart';
import 'package:test/test.dart';

void main() {
  group('Default', () {
    test('Normal ObjectModel', () {
      final model = ObjectModel(
        name: 'MyModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: true,
        fields: [],
        converters: [],
        staticCreate: false,
      );
      expect(model.name, 'MyModel');
      expect(model.path, 'path_to_my_model');
      expect(model.baseDirectory, 'base_dir');
      expect(model.generateForGenerics, true);
      expect(model.fields.isEmpty, true);
      expect(model.converters.isEmpty, true);
    });
  });
  group('Custom Path', () {
    test('Normal Custom Path', () {
      final model = ObjectModel(
        name: 'MyModel',
        path: 'path_to_my_model/',
        baseDirectory: 'base_dir',
        generateForGenerics: true,
        fields: [],
        converters: [],
        staticCreate: false,
      );
      expect(model.name, 'MyModel');
      expect(model.path, 'path_to_my_model');
      expect(model.baseDirectory, 'base_dir');
      expect(model.generateForGenerics, true);
      expect(model.fields.isEmpty, true);
      expect(model.converters.isEmpty, true);
    });

    test('Normal Custom Base Dir', () {
      final model = ObjectModel(
        name: 'MyModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir/',
        generateForGenerics: true,
        fields: [],
        converters: [],
        staticCreate: false,
      );
      expect(model.name, 'MyModel');
      expect(model.path, 'path_to_my_model');
      expect(model.baseDirectory, 'base_dir');
      expect(model.generateForGenerics, true);
      expect(model.fields.isEmpty, true);
      expect(model.converters.isEmpty, true);
    });
  });
}
