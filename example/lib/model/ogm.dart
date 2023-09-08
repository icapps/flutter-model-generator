// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:model_generator_example/model/converter/date_time_converter.dart';
import 'package:model_generator_example/model/user/testing.dart';

part 'ogm.g.dart';

@JsonSerializable(explicitToJson: true)
@DateTimeConverter()
class OGM {
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
  @JsonKey(name: 'simpleFields', required: true, includeIfNull: false)
  final List<Testing> simpleFields;
  @JsonKey(name: 'listMap', required: true, includeIfNull: false)
  final Map<int, List<String>> listMap;
  @JsonKey(name: 'structuredMessage', includeIfNull: false)
  final String? structuredMessage;
  @JsonKey(name: 'securityIndicator', includeIfNull: false)
  final String? securityRole;
  @JsonKey(name: 'mutableProperty', includeIfNull: false)
  String? mutableProperty;
  @JsonKey(name: 'dateChange', includeIfNull: false)
  final DateTime? dateChange;
  @JsonKey(name: 'fields', includeIfNull: false)
  final List<List<Testing>>? fields;
  @JsonKey(name: 'simpleMap', includeIfNull: false)
  final Map<String, Testing>? simpleMap;

  OGM({
    required this.beneficiary,
    required this.beneficiaryIBAN,
    required this.testTest,
    required this.someThing,
    required this.someThinGHuGE,
    required this.simpleFields,
    required this.listMap,
    this.structuredMessage,
    this.securityRole,
    this.mutableProperty,
    this.dateChange,
    this.fields,
    this.simpleMap,
  });

  factory OGM.fromJson(Map<String, dynamic> json) => _$OGMFromJson(json);

  Map<String, dynamic> toJson() => _$OGMToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OGM &&
          runtimeType == other.runtimeType &&
          beneficiary == other.beneficiary &&
          beneficiaryIBAN == other.beneficiaryIBAN &&
          testTest == other.testTest &&
          someThing == other.someThing &&
          someThinGHuGE == other.someThinGHuGE &&
          simpleFields == other.simpleFields &&
          listMap == other.listMap &&
          structuredMessage == other.structuredMessage &&
          securityRole == other.securityRole &&
          mutableProperty == other.mutableProperty &&
          dateChange == other.dateChange &&
          fields == other.fields &&
          simpleMap == other.simpleMap;

  @override
  int get hashCode =>
      beneficiary.hashCode ^
      beneficiaryIBAN.hashCode ^
      testTest.hashCode ^
      someThing.hashCode ^
      someThinGHuGE.hashCode ^
      simpleFields.hashCode ^
      listMap.hashCode ^
      structuredMessage.hashCode ^
      securityRole.hashCode ^
      mutableProperty.hashCode ^
      dateChange.hashCode ^
      fields.hashCode ^
      simpleMap.hashCode;

  @override
  String toString() => 'OGM{'
      'beneficiary: $beneficiary, '
      'beneficiaryIBAN: $beneficiaryIBAN, '
      'testTest: $testTest, '
      'someThing: $someThing, '
      'someThinGHuGE: $someThinGHuGE, '
      'simpleFields: $simpleFields, '
      'listMap: $listMap, '
      'structuredMessage: $structuredMessage, '
      'securityRole: $securityRole, '
      'mutableProperty: $mutableProperty, '
      'dateChange: $dateChange, '
      'fields: $fields, '
      'simpleMap: $simpleMap'
      '}';
}

const deserializeOGM = OGM.fromJson;

Map<String, dynamic> serializeOGM(OGM object) => object.toJson();

List<OGM> deserializeOGMList(List<Map<String, dynamic>> jsonList) =>
    jsonList.map(OGM.fromJson).toList();

List<Map<String, dynamic>> serializeOGMList(List<OGM> objects) =>
    objects.map((object) => object.toJson()).toList();
