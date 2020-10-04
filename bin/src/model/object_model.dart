import 'field.dart';
import 'model/model.dart';

class ObjectModel extends Model {
  final List<Field> fields;
  final List<String> converters;

  ObjectModel(
    String name,
    String path,
    String baseDirectory,
    this.fields,
    this.converters,
  ) : super(name, path, baseDirectory);
}
