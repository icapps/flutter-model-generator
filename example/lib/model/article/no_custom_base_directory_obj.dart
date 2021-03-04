import 'package:json_annotation/json_annotation.dart';
import 'package:model_generator_example/custom_model_directory/article/custom_base_directory_obj.dart';

part 'no_custom_base_directory_obj.g.dart';

@JsonSerializable()
class NoCustomBaseDirectoryObj {
  @JsonKey(name: 'customBaseDirectoryObj')
  final CustomBaseDirectoryObj? customBaseDirectoryObj;

  NoCustomBaseDirectoryObj({
    this.customBaseDirectoryObj,
  });

  factory NoCustomBaseDirectoryObj.fromJson(Map<String, dynamic> json) =>
      _$NoCustomBaseDirectoryObjFromJson(json);

  Map<String, dynamic> toJson() => _$NoCustomBaseDirectoryObjToJson(this);
}
