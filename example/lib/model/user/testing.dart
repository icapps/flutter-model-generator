import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:model_generator_example/model/data/custom/duration.dart';
import 'package:model_generator_example/model/data/custom/duration_from_to_json.dart';

part 'testing.g.dart';

@JsonSerializable()
class Testing {
  @JsonKey(name: 'beneficiary', required: true)
  final String beneficiary;
  @JsonKey(name: 'isFavourite', nullable: true, ignore: true)
  String isFavourite;
  @JsonKey(name: 'structuredMessage', nullable: true)
  final String structuredMessage;
  @JsonKey(name: 'beneficiaryIBAN', nullable: true)
  final String beneficiaryIBAN;
  @JsonKey(name: 'duration', nullable: true)
  final Duration duration;
  @JsonKey(name: 'duration_from_json_test', nullable: true, fromJson: handleDurationFromToJsonFromJson, toJson: handleDurationFromToJsonToJson)
  final DurationFromToJson durationFromJsonTest;

  Testing({
    @required this.beneficiary,
    this.isFavourite,
    this.structuredMessage,
    this.beneficiaryIBAN,
    this.duration,
    this.durationFromJsonTest,
  });

  factory Testing.fromJson(Map<String, dynamic> json) => _$TestingFromJson(json);

  Map<String, dynamic> toJson() => _$TestingToJson(this);

}
