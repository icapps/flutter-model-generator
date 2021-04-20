import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable()
class Project {
  @JsonKey(name: 'name', required: true)
  final String name;
  @JsonKey(name: 'cost')
  final double? cost;

  Project({
    required this.name,
    this.cost,
  });

  factory Project.fromJson(Object? json) => _$ProjectFromJson(json as Map<String, dynamic>); // ignore: avoid_as

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

}
