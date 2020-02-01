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

  OGM({
    @required this.structuredMessage,
    @required this.beneficiary,
    @required this.beneficiaryIBAN,
  });

  factory OGM.fromJson(Map<String, dynamic> json) => _$OGMFromJson(json);

  Map<String, dynamic> toJson() => _$OGMToJson(this);

}
