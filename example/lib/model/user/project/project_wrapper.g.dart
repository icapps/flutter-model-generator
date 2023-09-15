// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectWrapper _$ProjectWrapperFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['projectListById'],
  );
  return ProjectWrapper(
    projectListById: (json['projectListById'] as Map<String, dynamic>).map(
      (k, e) =>
          MapEntry(k, (e as List<dynamic>).map(Project.fromJson).toList()),
    ),
  );
}

Map<String, dynamic> _$ProjectWrapperToJson(ProjectWrapper instance) =>
    <String, dynamic>{
      'projectListById': instance.projectListById
          .map((k, e) => MapEntry(k, e.map((e) => e.toJson()).toList())),
    };
