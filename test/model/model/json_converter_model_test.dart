import 'package:model_generator/model/model/json_converter_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Default', () {
    test('Normal JsonConverterModel', () {
      final model = JsonConverterModel(
        name: 'MyJsonConverterModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
      );
      expect(model.name, 'MyJsonConverterModel');
      expect(model.path, 'path_to_my_model');
      expect(model.baseDirectory, 'base_dir');
    });
  });
  group('Custom Path', () {
    test('Normal Custom Path', () {
      final model = JsonConverterModel(
        name: 'MyJsonConverterModel',
        path: 'path_to_my_model/',
        baseDirectory: 'base_dir',
      );
      expect(model.name, 'MyJsonConverterModel');
      expect(model.path, 'path_to_my_model');
      expect(model.baseDirectory, 'base_dir');
    });

    test('Normal Custom Base Dir', () {
      final model = JsonConverterModel(
        name: 'MyJsonConverterModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir/',
      );
      expect(model.name, 'MyJsonConverterModel');
      expect(model.path, 'path_to_my_model');
      expect(model.baseDirectory, 'base_dir');
    });
  });
}
