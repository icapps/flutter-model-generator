import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class Project {
  @JsonKey(name: 'name', required: true, includeIfNull: false)
  final String name;
  @JsonKey(name: 'cost', includeIfNull: false)
  final double? cost;

  const Project({
    this.name = 'test',
    this.cost = 0.2,
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
          cost == other.cost;

  @override
  int get hashCode => name.hashCode ^ cost.hashCode;

  @override
  String toString() => 'Project{'
      'name: $name, '
      'cost: $cost'
      '}';
}
