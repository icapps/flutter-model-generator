// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'publishingDate', 'isAvailable', 'authors'],
  );
  return Book(
    name: json['name'] as String,
    publishingDate: DateTime.parse(json['publishingDate'] as String),
    isAvailable: json['isAvailable'] as bool,
    authors: (json['authors'] as List<dynamic>)
        .map((e) => Person.fromJson(e as Map<String, dynamic>))
        .toList(),
    price: (json['price'] as num?)?.toDouble(),
    pages: json['pages'] as int?,
    publishers: (json['publishers'] as List<dynamic>?)
        ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BookToJson(Book instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'publishingDate': instance.publishingDate.toIso8601String(),
    'isAvailable': instance.isAvailable,
    'authors': instance.authors.map((e) => e.toJson()).toList(),
    'price': instance.price,
    'pages': instance.pages,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'publishers', instance.publishers?.map((e) => e.toJson()).toList());
  return val;
}
