import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
class Person {
  @JsonKey(name: 'firstName', required: true)
  final String firstName;

  Person({
    @required this.firstName,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

}
