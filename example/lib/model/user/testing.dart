import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:model_generator_example/model/data/custom/duration.dart';
import 'package:model_generator_example/model/data/custom/duration_from_to_json.dart';

part 'testing.g.dart';

@JsonSerializable()
@immutable
class Testing {
  @JsonKey(name: 'beneficiary', required: true)
  final String beneficiary;
  @JsonKey(name: 'isFavourite', ignore: true)
  String? isFavourite;
  @JsonKey(name: 'structuredMessage')
  final String? structuredMessage;
  @JsonKey(name: 'beneficiaryIBAN')
  final String? beneficiaryIBAN;
  @JsonKey(name: 'dynamicField')
  final dynamic? dynamicField;
  @JsonKey(name: 'duration')
  final Duration? duration;
  @JsonKey(
      name: 'duration_from_json_test',
      fromJson: handleDurationFromToJsonFromJson,
      toJson: handleDurationFromToJsonToJson)
  final DurationFromToJson? durationFromJsonTest;

  Testing({
    required this.beneficiary,
    this.isFavourite,
    this.structuredMessage,
    this.beneficiaryIBAN,
    this.dynamicField,
    this.duration,
    this.durationFromJsonTest,
  });

  factory Testing.fromJson(Map<String, dynamic> json) =>
      _$TestingFromJson(json);

  Map<String, dynamic> toJson() => _$TestingToJson(this);
}
