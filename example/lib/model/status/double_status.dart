// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

enum DoubleStatus {
  @JsonValue(0.0)
  STATUS_0,
  @JsonValue(1.0)
  STATUS_1,
  @JsonValue(2.0)
  STATUS_2,
  @JsonValue(3.0)
  STATUS_3,
}

const doubleStatusMapping = {
  DoubleStatus.STATUS_0: 0.0,
  DoubleStatus.STATUS_1: 1.0,
  DoubleStatus.STATUS_2: 2.0,
  DoubleStatus.STATUS_3: 3.0,
};

final reverseDoubleStatusMapping = {
  0.0: DoubleStatus.STATUS_0,
  1.0: DoubleStatus.STATUS_1,
  2.0: DoubleStatus.STATUS_2,
  3.0: DoubleStatus.STATUS_3,
};

extension DoubleStatusExtension on DoubleStatus {
  double get doubleValue => doubleStatusMapping[this]!;
}

extension DoubleStatusDoubleExtension on double {
  DoubleStatus? get asDoubleStatus => reverseDoubleStatusMapping[this];
}
