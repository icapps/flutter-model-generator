import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'duration.g.dart';

@JsonSerializable()
class Duration {
  @JsonKey(name: 'test', required: true)
  final String test;

  Duration({
    @required this.test,
  });

  factory Duration.fromJson(Map<String, dynamic> json) =>
      _$DurationFromJson(json);

  Map<String, dynamic> toJson() => _$DurationToJson(this);
}
