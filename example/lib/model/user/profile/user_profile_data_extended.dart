import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:model_generator_example/model/user/profile/user_profile_data.dart';

part 'user_profile_data_extended.g.dart';

@JsonSerializable()
@immutable
class UserProfileDataExtended extends UserProfileData {
  @JsonKey(name: 'additionalField', required: true)
  final String additionalField;

  const UserProfileDataExtended({
    required this.additionalField,
  });

  factory UserProfileDataExtended.fromJson(Map<String, dynamic> json) => _$UserProfileDataExtendedFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileDataExtendedToJson(this);

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserProfileDataExtended && runtimeType == other.runtimeType && additionalField == other.additionalField;

  @override
  int get hashCode => additionalField.hashCode;

  @override
  String toString() => 'UserProfileDataExtended{'
      'additionalField: $additionalField'
      '}';
}
