import 'package:model_generator/model/model/custom_model.dart';

class CustomFromToJsonModel extends CustomModel {
  CustomFromToJsonModel({
    required String name,
    required String? path,
    required String? baseDirectory,
    String? extend,
    List<String>? extraImports,
    List<String>? extraAnnotations,
  }) : super(
          name: name,
          path: path,
          extend: extend,
          baseDirectory: baseDirectory,
          extraImports: extraImports,
          extraAnnotations: extraAnnotations,
        );
}
