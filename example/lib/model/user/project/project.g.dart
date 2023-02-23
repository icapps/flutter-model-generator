// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      name: json['name'] as String? ?? 'test',
      cost: (json['cost'] as num?)?.toDouble() ?? 0.2,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status'],
          unknownValue: Status.STATUS_0),
    );

Map<String, dynamic> _$ProjectToJson(Project instance) {
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
  Status.STATUS_0: 0,
  Status.STATUS_1: 1,
  Status.STATUS_2: 2,
  Status.STATUS_3: 3,
};
