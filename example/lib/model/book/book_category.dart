import 'package:json_annotation/json_annotation.dart';

enum BookCategory {
  @JsonValue('UNKOWN')
  UNKOWN,
  @JsonValue('FICTION')
  FICTION,
  @JsonValue('FANTASY')
  FANTASY,
}
