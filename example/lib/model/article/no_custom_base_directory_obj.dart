import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:model_generator_example/custom_model_directory/article/custom_base_directory_obj.dart';

part 'no_custom_base_directory_obj.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class NoCustomBaseDirectoryObj {
  @JsonKey(name: 'customBaseDirectoryObj', includeIfNull: false)
  final CustomBaseDirectoryObj? customBaseDirectoryObj;

  const NoCustomBaseDirectoryObj({
    this.customBaseDirectoryObj,
  });

  factory NoCustomBaseDirectoryObj.fromJson(Map<String, dynamic> json) =>
      _$NoCustomBaseDirectoryObjFromJson(json);

  Map<String, dynamic> toJson() => _$NoCustomBaseDirectoryObjToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoCustomBaseDirectoryObj &&
          runtimeType == other.runtimeType &&
          customBaseDirectoryObj == other.customBaseDirectoryObj;

  @override
  int get hashCode => customBaseDirectoryObj.hashCode;

  @override
  String toString() => 'NoCustomBaseDirectoryObj{'
      'customBaseDirectoryObj: $customBaseDirectoryObj'
      '}';
}
