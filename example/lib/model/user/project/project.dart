import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'project.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class Project {
  @JsonKey(name: 'name', required: true, includeIfNull: false)
  final String name;
  @JsonKey(name: 'cost', includeIfNull: false)
  final double? cost;

  const Project({
    required this.name,
    this.cost,
  });

  factory Project.fromJson(Object? json) => _$ProjectFromJson(json as Map<String, dynamic>); // ignore: avoid_as

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Project &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          cost == other.cost;

  @override
  int get hashCode =>
      name.hashCode ^
      cost.hashCode;

  @override
  String toString() =>
      'Project{'
      'name: $name, '
      'cost: $cost'
      '}';

}
