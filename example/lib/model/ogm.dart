import 'package:json_annotation/json_annotation.dart';
import 'package:model_generator_example/model/converter/date_time_converter.dart';
import 'package:model_generator_example/model/user/testing.dart';

part 'ogm.g.dart';

@JsonSerializable(explicitToJson: true)
@DateTimeConverter()
class OGM {
  @JsonKey(name: 'structuredMessage', required: true, includeIfNull: false)
  final String structuredMessage;
  @JsonKey(name: 'beneficiary', required: true, includeIfNull: false)
  final String beneficiary;
  @JsonKey(name: 'beneficiaryIBAN', required: true, includeIfNull: false)
  final String beneficiaryIBAN;
  @JsonKey(name: 'test_Test', required: true, includeIfNull: false)
  final String testTest;
  @JsonKey(name: 'some_Thing', required: true, includeIfNull: false)
  final String someThing;
  @JsonKey(name: 'some_ThinG_huGE', required: true, includeIfNull: false)
  final String someThinGHuGE;
  @JsonKey(name: 'securityIndicator', includeIfNull: false)
  final String? securityRole;
  @JsonKey(name: 'mutableProperty', includeIfNull: false)
  String? mutableProperty;
  @JsonKey(name: 'dateChange', includeIfNull: false)
  final DateTime? dateChange;
  @JsonKey(name: 'fields', includeIfNull: false)
  final List<List<Testing>>? fields;

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
    this.fields,
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
          dateChange == other.dateChange &&
          fields == other.fields;

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
      dateChange.hashCode ^
      fields.hashCode;

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
      'dateChange: $dateChange, '
      'fields: $fields'
      '}';

}
