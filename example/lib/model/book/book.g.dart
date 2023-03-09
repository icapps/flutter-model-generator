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
      'editors',
      'author',
      'category'
    ],
  );
  return Book(
    id: json['id'] as int,
    name: json['name'] as String,
    publishingDate: DateTime.parse(json['publishingDate'] as String),
    isAvailable: json['isAvailable'] as bool,
    editors: (json['editors'] as List<dynamic>)
        .map((e) => Person.fromJson(e as Map<String, dynamic>))
        .toList(),
    author: Person.fromJson(json['author'] as Map<String, dynamic>),
    category: $enumDecode(_$BookCategoryEnumMap, json['category']),
    price: (json['price'] as num?)?.toDouble(),
    pages: json['pages'] as int?,
    translators: (json['translators'] as List<dynamic>?)
        ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
        .toList(),
    publisher: json['publisher'] == null
        ? null
        : Person.fromJson(json['publisher'] as Map<String, dynamic>),
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
    'editors': instance.editors.map((e) => e.toJson()).toList(),
    'author': instance.author.toJson(),
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
      'translators', instance.translators?.map((e) => e.toJson()).toList());
  val['publisher'] = instance.publisher?.toJson();
  writeNotNull('tags', instance.tags);
  val['secondCategory'] = _$BookCategoryEnumMap[instance.secondCategory];
  return val;
}

const _$BookCategoryEnumMap = {
  BookCategory.UNKOWN: 'UNKOWN',
  BookCategory.FICTION: 'FICTION',
  BookCategory.FANTASY: 'FANTASY',
};
