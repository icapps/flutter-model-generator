import 'package:json_annotation/json_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) {
    var actualJson = json;
    if (json.contains('.')) {
      actualJson = json.substring(0, json.length - 1);
    }
    return DateTime.parse(actualJson);
  }

  @override
  String toJson(DateTime json) => json.toIso8601String();
}
