// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:model_generator_example/model/book/book_category.dart';
import 'package:model_generator_example/model/user/person/person.dart';

part 'book.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class Book {
  @JsonKey(name: 'id', required: true, includeIfNull: false)
  final int id;
  @JsonKey(name: 'name', required: true)
  final String name;
  @JsonKey(name: 'publishingDate', required: true)
  final DateTime publishingDate;
  @JsonKey(name: 'isAvailable', required: true)
  final bool isAvailable;
  @JsonKey(name: 'editors', required: true, includeIfNull: false)
  final List<Person> editors;
  @JsonKey(name: 'author', required: true)
  final Person author;
  @JsonKey(name: 'category', required: true)
  final BookCategory category;
  @JsonKey(name: 'price')
  final double? price;
  @JsonKey(name: 'pages')
  final int? pages;
  @JsonKey(name: 'translators', includeIfNull: false)
  final List<Person>? translators;
  @JsonKey(name: 'publisher')
  final Person? publisher;
  @JsonKey(name: 'tags', includeIfNull: false)
  final List<String>? tags;
  @JsonKey(name: 'secondCategory')
  final BookCategory? secondCategory;

  const Book({
    required this.id,
    required this.name,
    required this.publishingDate,
    required this.isAvailable,
    required this.editors,
    required this.author,
    required this.category,
    this.price,
    this.pages,
    this.translators,
    this.publisher,
    this.tags,
    this.secondCategory,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Book &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          publishingDate == other.publishingDate &&
          isAvailable == other.isAvailable &&
          editors == other.editors &&
          author == other.author &&
          category == other.category &&
          price == other.price &&
          pages == other.pages &&
          translators == other.translators &&
          publisher == other.publisher &&
          tags == other.tags &&
          secondCategory == other.secondCategory;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      publishingDate.hashCode ^
      isAvailable.hashCode ^
      editors.hashCode ^
      author.hashCode ^
      category.hashCode ^
      price.hashCode ^
      pages.hashCode ^
      translators.hashCode ^
      publisher.hashCode ^
      tags.hashCode ^
      secondCategory.hashCode;

  @override
  String toString() =>
      'Book{'
      'id: $id, '
      'name: $name, '
      'publishingDate: $publishingDate, '
      'isAvailable: $isAvailable, '
      'editors: $editors, '
      'author: $author, '
      'category: $category, '
      'price: $price, '
      'pages: $pages, '
      'translators: $translators, '
      'publisher: $publisher, '
      'tags: $tags, '
      'secondCategory: $secondCategory'
      '}';

}

const deserializeBook = Book.fromJson;

Map<String, dynamic> serializeBook(Book object) => object.toJson();

List<Book> deserializeBookList(List<Map<String, dynamic>> jsonList)
    => jsonList.map(Book.fromJson).toList();

List<Map<String, dynamic>> serializeBookList(List<Book> objects)
    => objects.map((object) => object.toJson()).toList();
