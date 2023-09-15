// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:model_generator_example/model/status/status.dart';
import 'package:model_generator_example/model/user/project/project.dart';

part 'sub_project.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class SubProject extends Project {
  const SubProject({
    String name = 'test',
    double? cost = 0.2,
    Status? status,
  }) : super(
          name: name,
          cost: cost,
          status: status,
        );

  factory SubProject.fromJson(Map<String, dynamic> json) =>
      _$SubProjectFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SubProjectToJson(this);

  @override
  String toString() => 'SubProject{'
      'name: $name, '
      'cost: $cost, '
      'status: $status'
      '}';
}

const deserializeSubProject = SubProject.fromJson;

Map<String, dynamic> serializeSubProject(SubProject object) => object.toJson();

List<SubProject> deserializeSubProjectList(
        List<Map<String, dynamic>> jsonList) =>
    jsonList.map(SubProject.fromJson).toList();

List<Map<String, dynamic>> serializeSubProjectList(List<SubProject> objects) =>
    objects.map((object) => object.toJson()).toList();
