// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

enum Status {
  @JsonValue(0)
  STATUS_0,
  @JsonValue(1)
  STATUS_1,
  @JsonValue(2)
  STATUS_2,
  @JsonValue(3)
  STATUS_3,
}

const statusMapping = {
  Status.STATUS_0: 0,
  Status.STATUS_1: 1,
  Status.STATUS_2: 2,
  Status.STATUS_3: 3,
};

const reverseStatusMapping = {
  0: Status.STATUS_0,
  1: Status.STATUS_1,
  2: Status.STATUS_2,
  3: Status.STATUS_3,
};

extension StatusExtension on Status {
  int get intValue => statusMapping[this]!;
}

extension StatusintExtension on int {
  Status? get asStatus => reverseStatusMapping[this];
}
