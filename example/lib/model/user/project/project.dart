// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:model_generator_example/model/status/status.dart';

part 'project.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class Project {
  @JsonKey(name: 'name', required: false, disallowNullValue: false)
  final String name;
  @JsonKey(name: 'cost', includeIfNull: false)
  final double? cost;
  @JsonKey(
      name: 'status', includeIfNull: false, unknownEnumValue: Status.status_0)
  final Status? status;

  const Project({
    this.name = 'test',
    this.cost = 0.2,
    this.status,
  });

  factory Project.fromJson(Object? json) =>
      _$ProjectFromJson(json as Map<String, dynamic>); // ignore: avoid_as

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  // ignore: prefer_constructors_over_static_methods
  static Project create(Object? json) => Project.fromJson(json);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Project &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          cost == other.cost &&
          status == other.status;

  @override
  int get hashCode => name.hashCode ^ cost.hashCode ^ status.hashCode;

  @override
  String toString() => 'Project{'
      'name: $name, '
      'cost: $cost, '
      'status: $status'
      '}';
}

const deserializeProject = Project.fromJson;

Map<String, dynamic> serializeProject(Project object) => object.toJson();

List<Project> deserializeProjectList(List<Map<String, dynamic>> jsonList) =>
    jsonList.map(Project.fromJson).toList();

List<Map<String, dynamic>> serializeProjectList(List<Project> objects) =>
    objects.map((object) => object.toJson()).toList();
