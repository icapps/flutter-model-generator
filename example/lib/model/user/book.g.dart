// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'publishingDate', 'isAvailable'],
  );
  return Book(
    name: json['name'] as String,
    publishingDate: DateTime.parse(json['publishingDate'] as String),
    isAvailable: json['isAvailable'] as bool,
    price: (json['price'] as num?)?.toDouble(),
    pages: json['pages'] as int?,
  );
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'name': instance.name,
      'publishingDate': instance.publishingDate.toIso8601String(),
      'isAvailable': instance.isAvailable,
      'price': instance.price,
      'pages': instance.pages,
    };
