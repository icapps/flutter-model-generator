import 'field.dart';
import 'model/model.dart';

class ObjectModel extends Model {
  final List<Field> fields;

  ObjectModel(
    String name,
    String path,
    String baseDirectory,
    this.fields,
  ) : super(name, path, baseDirectory);
}
