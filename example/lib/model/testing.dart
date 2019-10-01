import 'package:json_annotation/json_annotation.dart';

part 'testing.g.dart';

@JsonSerializable(nullable: false)
class Testing {
  @JsonKey(name: 'beneficiary', required: true)
  final String beneficiary;
  @JsonKey(name: 'structuredMessage')
  final String structuredMessage;
  @JsonKey(name: 'beneficiaryIBAN')
  final String beneficiaryIBAN;

  Testing(
    this.beneficiary,
    this.structuredMessage,
    this.beneficiaryIBAN,
  );

  factory Testing.fromJson(Map<String, dynamic> json) => _$TestingFromJson(json);

  Map<String, dynamic> toJson() => _$TestingToJson(this);

}
