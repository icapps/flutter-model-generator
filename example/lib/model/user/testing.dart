// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:model_generator_example/model/data/custom/duration.dart';
import 'package:model_generator_example/model/data/custom/duration_from_to_json.dart';

part 'testing.g.dart';

@JsonSerializable(explicitToJson: true)
class Testing {
  @JsonKey(name: 'beneficiary', required: true, includeIfNull: false)
  final String beneficiary;
  @JsonKey(name: 'isFavourite', includeIfNull: false, ignore: true)
  String? isFavourite;
  @JsonKey(name: 'structuredMessage', includeIfNull: false)
  final String? structuredMessage;
  @JsonKey(name: 'beneficiaryIBAN', includeIfNull: false)
  final String? beneficiaryIBAN;
  @JsonKey(name: 'dynamicField', includeIfNull: false)
  final dynamic dynamicField;
  @JsonKey(name: 'duration', includeIfNull: false)
  final Duration? duration;
  @JsonKey(name: 'duration_from_json_test', includeIfNull: false, fromJson: handleDurationFromToJsonFromJson, toJson: handleDurationFromToJsonToJson)
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

  factory Testing.fromJson(Map<String, dynamic> json) => _$TestingFromJson(json);

  Map<String, dynamic> toJson() => _$TestingToJson(this);

}

const deserializeTesting = Testing.fromJson;

Map<String, dynamic> serializeTesting(Testing object) => object.toJson();

List<Testing> deserializeTestingList(List<Map<String, dynamic>> jsonList)
    => jsonList.map(Testing.fromJson).toList();

List<Map<String, dynamic>> serializeTestingList(List<Testing> objects)
    => objects.map((object) => object.toJson()).toList();
