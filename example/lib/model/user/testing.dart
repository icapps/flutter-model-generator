import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

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

  Testing({
    @required this.beneficiary,
    this.isFavourite,
    this.structuredMessage,
    this.beneficiaryIBAN,
  });

  factory Testing.fromJson(Map<String, dynamic> json) =>
      _$TestingFromJson(json);

  Map<String, dynamic> toJson() => _$TestingToJson(this);
}
