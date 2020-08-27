import 'model.dart';

class CustomModel extends Model {
  CustomModel(
    String name,
    String path,
    {String modelDirectory}
  ) : super(name, path, modelDirectory: modelDirectory);
}
