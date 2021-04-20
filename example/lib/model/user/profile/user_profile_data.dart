import 'package:json_annotation/json_annotation.dart';
import 'package:model_generator_example/model/user/testing.dart';
import 'package:model_generator_example/model/ogm.dart';
import 'package:model_generator_example/model/user/person/person.dart';

part 'user_profile_data.g.dart';

@JsonSerializable()
class UserProfileData {
  @JsonKey(name: 'firstName', required: true)
  final String firstName;
  @JsonKey(name: 'lastName', required: true)
  final String lastName;
  @JsonKey(name: 'standardLanguage', required: true)
  final String standardLanguage;
  @JsonKey(name: 'mainAccountNumber', required: true)
  final String mainAccountNumber;
  @JsonKey(name: 'legalEmail', required: true)
  final String legalEmail;
  @JsonKey(name: 'phones', required: true)
  final Testing phones;
  @JsonKey(name: 'legalAddress', required: true)
  final OGM legalAddress;
  @JsonKey(name: 'offTrack', includeIfNull: false)
  final List<String>? offTrack;
  @JsonKey(name: 'onTrack')
  final List<OGM>? onTrack;
  @JsonKey(name: 'persons')
  final List<Person>? persons;
  @JsonKey(name: 'personsById')
  final Map<String, Person>? personsById;

  UserProfileData({
    required this.firstName,
    required this.lastName,
    required this.standardLanguage,
    required this.mainAccountNumber,
    required this.legalEmail,
    required this.phones,
    required this.legalAddress,
    this.offTrack,
    this.onTrack,
    this.persons,
    this.personsById,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileDataToJson(this);
}
