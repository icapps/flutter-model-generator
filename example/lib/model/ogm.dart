import 'package:json_annotation/json_annotation.dart';
import 'package:model_generator_example/model/converter/date_time_converter.dart';

part 'ogm.g.dart';

@JsonSerializable()
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OGM &&
          runtimeType == other.runtimeType &&
          structuredMessage == other.structuredMessage &&
          beneficiary == other.beneficiary &&
          beneficiaryIBAN == other.beneficiaryIBAN &&
          testTest == other.testTest &&
          someThing == other.someThing &&
          someThinGHuGE == other.someThinGHuGE &&
          securityRole == other.securityRole &&
          mutableProperty == other.mutableProperty &&
          dateChange == other.dateChange;

  @override
  int get hashCode =>
      structuredMessage.hashCode ^
      beneficiary.hashCode ^
      beneficiaryIBAN.hashCode ^
      testTest.hashCode ^
      someThing.hashCode ^
      someThinGHuGE.hashCode ^
      securityRole.hashCode ^
      mutableProperty.hashCode ^
      dateChange.hashCode;

  @override
  String toString() => 
      'OGM{'
      'structuredMessage: $structuredMessage, '
      'beneficiary: $beneficiary, '
      'beneficiaryIBAN: $beneficiaryIBAN, '
      'testTest: $testTest, '
      'someThing: $someThing, '
      'someThinGHuGE: $someThinGHuGE, '
      'securityRole: $securityRole, '
      'mutableProperty: $mutableProperty, '
      'dateChange: $dateChange'
      '}';

}
