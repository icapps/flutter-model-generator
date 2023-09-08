// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      name: json['name'] as String? ?? 'test',
      cost: (json['cost'] as num?)?.toDouble() ?? 0.2,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status'],
          unknownValue: Status.status_0),
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
  Status.status_0: 0,
  Status.status_1: 1,
  Status.status_2: 2,
  Status.status_3: 3,
};
