import 'package:model_generator/model/model/json_converter_model.dart';
import 'package:test/test.dart';

void main() {
  group('Default', () {
    test('Normal JsonConverterModel', () {
      final field = JsonConverterModel(
        name: 'MyJsonConverterModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
      );
      expect(field.name, 'MyJsonConverterModel');
      expect(field.path, 'path_to_my_model');
      expect(field.baseDirectory, 'base_dir');
    });
  });
  group('Custom Path', () {
    test('Normal Custom Path', () {
      final field = JsonConverterModel(
        name: 'MyJsonConverterModel',
        path: 'path_to_my_model/',
        baseDirectory: 'base_dir',
      );
      expect(field.name, 'MyJsonConverterModel');
      expect(field.path, 'path_to_my_model');
      expect(field.baseDirectory, 'base_dir');
    });

    test('Normal Custom Base Dir', () {
      final field = JsonConverterModel(
        name: 'MyJsonConverterModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir/',
      );
      expect(field.name, 'MyJsonConverterModel');
      expect(field.path, 'path_to_my_model');
      expect(field.baseDirectory, 'base_dir');
    });
  });
}
