import 'package:model_generator/model/model/custom_from_to_json_model.dart';
import 'package:test/test.dart';

void main() {
  group('Default', () {
    test('Normal CustomFromToJsonModel', () {
      final field = CustomFromToJsonModel(
        name: 'MyCustomFromToJsonModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
      );
      expect(field.name, 'MyCustomFromToJsonModel');
      expect(field.path, 'path_to_my_model');
      expect(field.baseDirectory, 'base_dir');
    });
  });
  group('Custom Path', () {
    test('Normal Custom Path', () {
      final field = CustomFromToJsonModel(
        name: 'MyCustomFromToJsonModel',
        path: 'path_to_my_model/',
        baseDirectory: 'base_dir',
      );
      expect(field.name, 'MyCustomFromToJsonModel');
      expect(field.path, 'path_to_my_model');
      expect(field.baseDirectory, 'base_dir');
    });

    test('Normal Custom Base Dir', () {
      final field = CustomFromToJsonModel(
        name: 'MyCustomFromToJsonModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir/',
      );
      expect(field.name, 'MyCustomFromToJsonModel');
      expect(field.path, 'path_to_my_model');
      expect(field.baseDirectory, 'base_dir');
    });
  });
}
