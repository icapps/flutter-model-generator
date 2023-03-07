// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'custom_base_directory_obj.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class CustomBaseDirectoryObj {
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;

  const CustomBaseDirectoryObj({
    this.name,
  });

  factory CustomBaseDirectoryObj.fromJson(Map<String, dynamic> json) => _$CustomBaseDirectoryObjFromJson(json);

  Map<String, dynamic> toJson() => _$CustomBaseDirectoryObjToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomBaseDirectoryObj &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode =>
      name.hashCode;

  @override
  String toString() =>
      'CustomBaseDirectoryObj{'
      'name: $name'
      '}';

}

const deserializeCustomBaseDirectoryObj = CustomBaseDirectoryObj.fromJson;

Map<String, dynamic> serializeCustomBaseDirectoryObj(CustomBaseDirectoryObj object) => object.toJson();

List<CustomBaseDirectoryObj> deserializeCustomBaseDirectoryObjList(List<Map<String, dynamic>> jsonList)
    => jsonList.map(CustomBaseDirectoryObj.fromJson).toList();

List<Map<String, dynamic>> serializeCustomBaseDirectoryObjList(List<CustomBaseDirectoryObj> objects)
    => objects.map((object) => object.toJson()).toList();
