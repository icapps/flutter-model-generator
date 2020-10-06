// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'no_custom_base_directory_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoCustomBaseDirectoryObj _$NoCustomBaseDirectoryObjFromJson(
    Map<String, dynamic> json) {
  return NoCustomBaseDirectoryObj(
    customBaseDirectoryObj: json['customBaseDirectoryObj'] == null
        ? null
        : CustomBaseDirectoryObj.fromJson(
            json['customBaseDirectoryObj'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NoCustomBaseDirectoryObjToJson(
        NoCustomBaseDirectoryObj instance) =>
    <String, dynamic>{
      'customBaseDirectoryObj': instance.customBaseDirectoryObj,
    };
