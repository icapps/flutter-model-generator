// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'no_custom_base_directory_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoCustomBaseDirectoryObj _$NoCustomBaseDirectoryObjFromJson(
        Map<String, dynamic> json) =>
    NoCustomBaseDirectoryObj(
      customBaseDirectoryObj: json['customBaseDirectoryObj'] == null
          ? null
          : CustomBaseDirectoryObj.fromJson(
              json['customBaseDirectoryObj'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NoCustomBaseDirectoryObjToJson(
    NoCustomBaseDirectoryObj instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'customBaseDirectoryObj', instance.customBaseDirectoryObj?.toJson());
  return val;
}
