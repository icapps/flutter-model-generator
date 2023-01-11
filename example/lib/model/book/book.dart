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
  @JsonKey(name: 'authors', required: true, includeIfNull: false)
  final List<Person> authors;
  @JsonKey(name: 'category', required: true)
  final BookCategory category;
  @JsonKey(name: 'price')
  final double? price;
  @JsonKey(name: 'pages')
  final int? pages;
  @JsonKey(name: 'publishers', includeIfNull: false)
  final List<Person>? publishers;
  @JsonKey(name: 'secondCategory')
  final BookCategory? secondCategory;

  const Book({
    required this.id,
    required this.name,
    required this.publishingDate,
    required this.isAvailable,
    required this.authors,
    required this.category,
    this.price,
    this.pages,
    this.publishers,
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
          authors == other.authors &&
          category == other.category &&
          price == other.price &&
          pages == other.pages &&
          publishers == other.publishers &&
          secondCategory == other.secondCategory;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      publishingDate.hashCode ^
      isAvailable.hashCode ^
      authors.hashCode ^
      category.hashCode ^
      price.hashCode ^
      pages.hashCode ^
      publishers.hashCode ^
      secondCategory.hashCode;

  @override
  String toString() => 'Book{'
      'id: $id, '
      'name: $name, '
      'publishingDate: $publishingDate, '
      'isAvailable: $isAvailable, '
      'authors: $authors, '
      'category: $category, '
      'price: $price, '
      'pages: $pages, '
      'publishers: $publishers, '
      'secondCategory: $secondCategory'
      '}';
}

const deserializeBook = Book.fromJson;

Map<String, dynamic> serializeBook(Book object) => object.toJson();

List<Book> deserializeBookList(List<Map<String, dynamic>> jsonList) =>
    jsonList.map(Book.fromJson).toList();

List<Map<String, dynamic>> serializeBookList(List<Book> objects) =>
    objects.map((object) => object.toJson()).toList();
