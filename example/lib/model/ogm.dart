import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ogm.g.dart';

@JsonSerializable()
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
  final String someThinGhuGE;
  @JsonKey(name: 'securityIndicator', nullable: true)
  final String securityRole;

  OGM({
    @required this.structuredMessage,
    @required this.beneficiary,
    @required this.beneficiaryIBAN,
    @required this.testTest,
    @required this.someThing,
    @required this.someThinGhuGE,
    this.securityRole,
  });

  factory OGM.fromJson(Map<String, dynamic> json) => _$OGMFromJson(json);

  Map<String, dynamic> toJson() => _$OGMToJson(this);

}
