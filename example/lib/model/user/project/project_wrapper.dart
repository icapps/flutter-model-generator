// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:model_generator_example/model/user/project/project.dart';

part 'project_wrapper.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class ProjectWrapper {
  @JsonKey(name: 'projectListById', required: true)
  final Map<String, List<Project>> projectListById;

  const ProjectWrapper({
    required this.projectListById,
  });

  factory ProjectWrapper.fromJson(Map<String, dynamic> json) =>
      _$ProjectWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectWrapperToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectWrapper &&
          runtimeType == other.runtimeType &&
          projectListById == other.projectListById;

  @override
  int get hashCode => projectListById.hashCode;

  @override
  String toString() => 'ProjectWrapper{'
      'projectListById: $projectListById'
      '}';
}

const deserializeProjectWrapper = ProjectWrapper.fromJson;

Map<String, dynamic> serializeProjectWrapper(ProjectWrapper object) =>
    object.toJson();

List<ProjectWrapper> deserializeProjectWrapperList(
        List<Map<String, dynamic>> jsonList) =>
    jsonList.map(ProjectWrapper.fromJson).toList();

List<Map<String, dynamic>> serializeProjectWrapperList(
        List<ProjectWrapper> objects) =>
    objects.map((object) => object.toJson()).toList();
