// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'name',
      'publishingDate',
      'isAvailable',
      'authors',
      'category'
    ],
  );
  return Book(
    id: json['id'] as int,
    name: json['name'] as String,
    publishingDate: DateTime.parse(json['publishingDate'] as String),
    isAvailable: json['isAvailable'] as bool,
    authors: (json['authors'] as List<dynamic>)
        .map((e) => Person.fromJson(e as Map<String, dynamic>))
        .toList(),
    category: $enumDecode(_$BookCategoryEnumMap, json['category']),
    price: (json['price'] as num?)?.toDouble(),
    pages: json['pages'] as int?,
    publishers: (json['publishers'] as List<dynamic>?)
        ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
        .toList(),
    tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    secondCategory:
        $enumDecodeNullable(_$BookCategoryEnumMap, json['secondCategory']),
  );
}

Map<String, dynamic> _$BookToJson(Book instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'publishingDate': instance.publishingDate.toIso8601String(),
    'isAvailable': instance.isAvailable,
    'authors': instance.authors.map((e) => e.toJson()).toList(),
    'category': _$BookCategoryEnumMap[instance.category]!,
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
  writeNotNull('tags', instance.tags);
  val['secondCategory'] = _$BookCategoryEnumMap[instance.secondCategory];
  return val;
}

const _$BookCategoryEnumMap = {
  BookCategory.UNKOWN: 'UNKOWN',
  BookCategory.FICTION: 'FICTION',
  BookCategory.FANTASY: 'FANTASY',
};
