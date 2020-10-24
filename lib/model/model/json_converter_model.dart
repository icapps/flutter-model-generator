import 'package:meta/meta.dart';
import 'package:model_generator/model/model/model.dart';

class JsonConverterModel extends Model {
  JsonConverterModel({
    @required String name,
    @required String path,
    @required String baseDirectory,
  }) : super(name: name, path: path, baseDirectory: baseDirectory);
}
