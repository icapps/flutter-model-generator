import 'package:json_annotation/json_annotation.dart';
import 'package:model_generator_example/model/ogm.dart';
import 'package:model_generator_example/model/testing.dart';
import 'package:model_generator_example/model/ogm.dart';

part 'user_profile_data.g.dart';

@JsonSerializable(nullable: false)
class UserProfileData {
  @JsonKey(name: 'firstName', required: true)
  final String firstName;
  @JsonKey(name: 'legalAddress', required: true)
  final OGM legalAddress;
  @JsonKey(name: 'phones', required: true)
  final Testing phones;
  @JsonKey(name: 'offTrack')
  final List<String> offTrack;
  @JsonKey(name: 'legalEmail', required: true)
  final String legalEmail;
  @JsonKey(name: 'onTrack')
  final List<OGM> onTrack;
  @JsonKey(name: 'standardLanguage', required: true)
  final String standardLanguage;
  @JsonKey(name: 'lastName', required: true)
  final String lastName;
  @JsonKey(name: 'mainAccountNumber', required: true)
  final String mainAccountNumber;

  UserProfileData(
    this.firstName,
    this.legalAddress,
    this.phones,
    this.offTrack,
    this.legalEmail,
    this.onTrack,
    this.standardLanguage,
    this.lastName,
    this.mainAccountNumber,
  );

  factory UserProfileData.fromJson(Map<String, dynamic> json) => _$UserProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileDataToJson(this);

}
