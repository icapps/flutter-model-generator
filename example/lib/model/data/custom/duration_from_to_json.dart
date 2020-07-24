DurationFromToJson handleDurationFromToJsonFromJson(object) =>
    DurationFromToJson.fromJson(object);

double handleDurationFromToJsonToJson(DurationFromToJson data) => data.toJson();

class DurationFromToJson {
  final double duration;

  DurationFromToJson({
    this.duration,
  });

  factory DurationFromToJson.fromJson(json) {
    if (json is double) {
      return DurationFromToJson(duration: json);
    }
    if (json is int) {
      return DurationFromToJson(duration: json.toDouble());
    }
    return DurationFromToJson(duration: 0);
  }

  double toJson() => duration;
}
