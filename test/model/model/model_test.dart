import 'package:model_generator/model/model/object_model.dart';
import 'package:test/test.dart';

void main() {
  group('Default', () {
    test('Normal ObjectModel', () {
      final field = ObjectModel(
        name: 'MyModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [],
        converters: [],
      );
      expect(field.name, 'MyModel');
      expect(field.path, 'path_to_my_model');
      expect(field.baseDirectory, 'base_dir');
      expect(field.fields.isEmpty, true);
      expect(field.converters.isEmpty, true);
    });
  });
  group('Custom Path', () {
    test('Normal Custom Path', () {
      final field = ObjectModel(
        name: 'MyModel',
        path: 'path_to_my_model/',
        baseDirectory: 'base_dir',
        fields: [],
        converters: [],
      );
      expect(field.name, 'MyModel');
      expect(field.path, 'path_to_my_model');
      expect(field.baseDirectory, 'base_dir');
      expect(field.fields.isEmpty, true);
      expect(field.converters.isEmpty, true);
    });

    test('Normal Custom Base Dir', () {
      final field = ObjectModel(
        name: 'MyModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir/',
        fields: [],
        converters: [],
      );
      expect(field.name, 'MyModel');
      expect(field.path, 'path_to_my_model');
      expect(field.baseDirectory, 'base_dir');
      expect(field.fields.isEmpty, true);
      expect(field.converters.isEmpty, true);
    });
  });
}
