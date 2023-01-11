import 'dart:convert';

import 'package:drift/drift.dart';

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    return fromDb.split(',').map((e) => utf8.decode(base64Decode(e))).toList();
  }

  @override
  String toSql(List<String> value) {
    return value.map((e) => base64Encode(utf8.encode(e))).join(',');
  }
}
