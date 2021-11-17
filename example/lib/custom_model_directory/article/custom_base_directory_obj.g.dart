// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_base_directory_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomBaseDirectoryObj _$CustomBaseDirectoryObjFromJson(
        Map<String, dynamic> json) =>
    CustomBaseDirectoryObj(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CustomBaseDirectoryObjToJson(
    CustomBaseDirectoryObj instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  return val;
}
