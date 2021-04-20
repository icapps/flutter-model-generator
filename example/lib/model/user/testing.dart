import 'package:json_annotation/json_annotation.dart';
import 'package:model_generator_example/model/data/custom/duration.dart';
import 'package:model_generator_example/model/data/custom/duration_from_to_json.dart';

part 'testing.g.dart';

@JsonSerializable()
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
  @JsonKey(name: 'duration_from_json_test', fromJson: handleDurationFromToJsonFromJson, toJson: handleDurationFromToJsonToJson)
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Testing &&
          runtimeType == other.runtimeType &&
          beneficiary == other.beneficiary &&
          isFavourite == other.isFavourite &&
          structuredMessage == other.structuredMessage &&
          beneficiaryIBAN == other.beneficiaryIBAN &&
          dynamicField == other.dynamicField &&
          duration == other.duration &&
          durationFromJsonTest == other.durationFromJsonTest;

  @override
  int get hashCode =>
      beneficiary.hashCode ^
      isFavourite.hashCode ^
      structuredMessage.hashCode ^
      beneficiaryIBAN.hashCode ^
      dynamicField.hashCode ^
      duration.hashCode ^
      durationFromJsonTest.hashCode;

  @override
  String toString() => 
      'Testing{'
      'beneficiary: $beneficiary, '
      'isFavourite: $isFavourite, '
      'structuredMessage: $structuredMessage, '
      'beneficiaryIBAN: $beneficiaryIBAN, '
      'dynamicField: $dynamicField, '
      'duration: $duration, '
      'durationFromJsonTest: $durationFromJsonTest'
      '}';

}
