// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:model_generator_example/model/user/person/gender.dart';

part 'person.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class Person {
  @JsonKey(name: 'firstName', required: true, includeIfNull: false)
  final String firstName;
  @JsonKey(name: 'gender', required: true, includeIfNull: false, unknownEnumValue: Gender.X)
  final Gender gender;

  const Person({
    required this.firstName,
    required this.gender,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName &&
          gender == other.gender;

  @override
  int get hashCode =>
      firstName.hashCode ^
      gender.hashCode;

  @override
  String toString() =>
      'Person{'
      'firstName: $firstName, '
      'gender: $gender'
      '}';

}

const deserializePerson = Person.fromJson;

Map<String, dynamic> serializePerson(Person object) => object.toJson();

List<Person> deserializePersonList(List<Map<String, dynamic>> jsonList)
    => jsonList.map(Person.fromJson).toList();

List<Map<String, dynamic>> serializePersonList(List<Person> objects)
    => objects.map((object) => object.toJson()).toList();
