import 'package:json_annotation/json_annotation.dart';

part 'custom_base_directory_obj.g.dart';

@JsonSerializable()
class CustomBaseDirectoryObj {
  @JsonKey(name: 'name')
  final String? name;

  CustomBaseDirectoryObj({
    this.name,
  });

  factory CustomBaseDirectoryObj.fromJson(Map<String, dynamic> json) => _$CustomBaseDirectoryObjFromJson(json);

  Map<String, dynamic> toJson() => _$CustomBaseDirectoryObjToJson(this);

}
