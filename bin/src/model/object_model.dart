import 'field.dart';
import 'model/model.dart';

class ObjectModel extends Model {
  final List<Field> fields;

  ObjectModel(
    String name,
    String path,
    this.fields,
    {String modelDirectory}
  ) : super(name, path, modelDirectory: modelDirectory);
}
