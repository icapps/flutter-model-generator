import 'package:json_annotation/json_annotation.dart';

part 'ogm.g.dart';

@JsonSerializable(nullable: false)
class OGM {
  @JsonKey(name: 'beneficiary', required: true)
  final String beneficiary;
  @JsonKey(name: 'structuredMessage', required: true)
  final String structuredMessage;
  @JsonKey(name: 'beneficiaryIBAN', required: true)
  final String beneficiaryIBAN;

  OGM(
    this.beneficiary,
    this.structuredMessage,
    this.beneficiaryIBAN,
  );

  factory OGM.fromJson(Map<String, dynamic> json) => _$OGMFromJson(json);

  Map<String, dynamic> toJson() => _$OGMToJson(this);
}
