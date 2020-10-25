import 'package:model_generator/model/model/custom_model.dart';
import 'package:test/test.dart';

void main() {
  group('Default', () {
    test('Normal CustomModel', () {
      final field = CustomModel(
        name: 'MyCustomModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
      );
      expect(field.name, 'MyCustomModel');
      expect(field.path, 'path_to_my_model');
      expect(field.baseDirectory, 'base_dir');
    });
  });
  group('Custom Path', () {
    test('Normal Custom Path', () {
      final field = CustomModel(
        name: 'MyCustomModel',
        path: 'path_to_my_model/',
        baseDirectory: 'base_dir',
      );
      expect(field.name, 'MyCustomModel');
      expect(field.path, 'path_to_my_model');
      expect(field.baseDirectory, 'base_dir');
    });

    test('Normal Custom Base Dir', () {
      final field = CustomModel(
        name: 'MyCustomModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir/',
      );
      expect(field.name, 'MyCustomModel');
      expect(field.path, 'path_to_my_model');
      expect(field.baseDirectory, 'base_dir');
    });
  });
}
