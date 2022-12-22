import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class Book {
  @JsonKey(name: 'name', required: true)
  final String name;
  @JsonKey(name: 'publishingDate', required: true)
  final DateTime publishingDate;
  @JsonKey(name: 'isAvailable', required: true)
  final bool isAvailable;
  @JsonKey(name: 'price')
  final double? price;
  @JsonKey(name: 'pages')
  final int? pages;

  const Book({
    required this.name,
    required this.publishingDate,
    required this.isAvailable,
    this.price,
    this.pages,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Book &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          publishingDate == other.publishingDate &&
          isAvailable == other.isAvailable &&
          price == other.price &&
          pages == other.pages;

  @override
  int get hashCode =>
      name.hashCode ^
      publishingDate.hashCode ^
      isAvailable.hashCode ^
      price.hashCode ^
      pages.hashCode;

  @override
  String toString() => 'Book{'
      'name: $name, '
      'publishingDate: $publishingDate, '
      'isAvailable: $isAvailable, '
      'price: $price, '
      'pages: $pages'
      '}';
}

Book deserializeBook(Map<String, dynamic> json) => Book.fromJson(json);

Map<String, dynamic> serializeBook(Book object) => object.toJson();

List<Book> deserializeBookList(List<Map<String, dynamic>> jsonList) =>
    jsonList.map((json) => Book.fromJson(json)).toList();

List<Map<String, dynamic>> serializeBookList(List<Book> objects) =>
    objects.map((object) => object.toJson()).toList();
