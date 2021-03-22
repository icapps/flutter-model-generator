// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['name']);
  return Project(
    name: json['name'] as String,
    cost: (json['cost'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'name': instance.name,
      'cost': instance.cost,
    };
