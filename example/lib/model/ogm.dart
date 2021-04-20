import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:model_generator_example/model/converter/date_time_converter.dart';

part 'ogm.g.dart';

@JsonSerializable()
@immutable
@DateTimeConverter()
class OGM {
  @JsonKey(name: 'structuredMessage', required: true)
  final String structuredMessage;
  @JsonKey(name: 'beneficiary', required: true)
  final String beneficiary;
  @JsonKey(name: 'beneficiaryIBAN', required: true)
  final String beneficiaryIBAN;
  @JsonKey(name: 'test_Test', required: true)
  final String testTest;
  @JsonKey(name: 'some_Thing', required: true)
  final String someThing;
  @JsonKey(name: 'some_ThinG_huGE', required: true)
  final String someThinGHuGE;
  @JsonKey(name: 'securityIndicator')
  final String? securityRole;
  @JsonKey(name: 'mutableProperty')
  String? mutableProperty;
  @JsonKey(name: 'dateChange')
  final DateTime? dateChange;

  OGM({
    required this.structuredMessage,
    required this.beneficiary,
    required this.beneficiaryIBAN,
    required this.testTest,
    required this.someThing,
    required this.someThinGHuGE,
    this.securityRole,
    this.mutableProperty,
    this.dateChange,
  });

  factory OGM.fromJson(Map<String, dynamic> json) => _$OGMFromJson(json);

  Map<String, dynamic> toJson() => _$OGMToJson(this);
}
