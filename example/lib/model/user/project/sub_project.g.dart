// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubProject _$SubProjectFromJson(Map<String, dynamic> json) => SubProject(
      name: json['name'] as String? ?? 'test',
      cost: (json['cost'] as num?)?.toDouble() ?? 0.2,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status'],
          unknownValue: Status.status0),
    );

Map<String, dynamic> _$SubProjectToJson(SubProject instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('cost', instance.cost);
  writeNotNull('status', _$StatusEnumMap[instance.status]);
  return val;
}

const _$StatusEnumMap = {
  Status.status0: 0,
  Status.status1: 1,
  Status.status2: 2,
  Status.status3: 3,
};
