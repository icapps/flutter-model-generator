import 'package:model_generator/model/model/custom_from_to_json_model.dart';
import 'package:test/test.dart';

void main() {
  group('Default', () {
    test('Normal CustomFromToJsonModel', () {
      final model = CustomFromToJsonModel(
        name: 'MyCustomFromToJsonModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
      );
      expect(model.name, 'MyCustomFromToJsonModel');
      expect(model.path, 'path_to_my_model');
      expect(model.baseDirectory, 'base_dir');
    });
  });
  group('Custom Path', () {
    test('Normal Custom Path', () {
      final model = CustomFromToJsonModel(
        name: 'MyCustomFromToJsonModel',
        path: 'path_to_my_model/',
        baseDirectory: 'base_dir',
      );
      expect(model.name, 'MyCustomFromToJsonModel');
      expect(model.path, 'path_to_my_model');
      expect(model.baseDirectory, 'base_dir');
    });

    test('Normal Custom Base Dir', () {
      final model = CustomFromToJsonModel(
        name: 'MyCustomFromToJsonModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir/',
      );
      expect(model.name, 'MyCustomFromToJsonModel');
      expect(model.path, 'path_to_my_model');
      expect(model.baseDirectory, 'base_dir');
    });
  });
}
