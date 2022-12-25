// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_generator_example_database.dart';

// ignore_for_file: type=lint
class DbBook extends DataClass implements Insertable<DbBook> {
  final int id;
  final String name;
  final DateTime publishingDate;
  final bool isAvailable;
  final BookCategory category;
  final double? price;
  final int? pages;
  final BookCategory? secondCategory;
  const DbBook(
      {required this.id,
      required this.name,
      required this.publishingDate,
      required this.isAvailable,
      required this.category,
      this.price,
      this.pages,
      this.secondCategory});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['publishing_date'] = Variable<DateTime>(publishingDate);
    map['is_available'] = Variable<bool>(isAvailable);
    {
      final converter = $DbBookTableTable.$convertercategory;
      map['category'] = Variable<String>(converter.toSql(category));
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    if (!nullToAbsent || pages != null) {
      map['pages'] = Variable<int>(pages);
    }
    if (!nullToAbsent || secondCategory != null) {
      final converter = $DbBookTableTable.$convertersecondCategoryn;
      map['second_category'] =
          Variable<String>(converter.toSql(secondCategory));
    }
    return map;
  }

  DbBookTableCompanion toCompanion(bool nullToAbsent) {
    return DbBookTableCompanion(
      id: Value(id),
      name: Value(name),
      publishingDate: Value(publishingDate),
      isAvailable: Value(isAvailable),
      category: Value(category),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      pages:
          pages == null && nullToAbsent ? const Value.absent() : Value(pages),
      secondCategory: secondCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(secondCategory),
    );
  }

  factory DbBook.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbBook(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      publishingDate: serializer.fromJson<DateTime>(json['publishingDate']),
      isAvailable: serializer.fromJson<bool>(json['isAvailable']),
      category: serializer.fromJson<BookCategory>(json['category']),
      price: serializer.fromJson<double?>(json['price']),
      pages: serializer.fromJson<int?>(json['pages']),
      secondCategory:
          serializer.fromJson<BookCategory?>(json['secondCategory']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'publishingDate': serializer.toJson<DateTime>(publishingDate),
      'isAvailable': serializer.toJson<bool>(isAvailable),
      'category': serializer.toJson<BookCategory>(category),
      'price': serializer.toJson<double?>(price),
      'pages': serializer.toJson<int?>(pages),
      'secondCategory': serializer.toJson<BookCategory?>(secondCategory),
    };
  }

  DbBook copyWith(
          {int? id,
          String? name,
          DateTime? publishingDate,
          bool? isAvailable,
          BookCategory? category,
          Value<double?> price = const Value.absent(),
          Value<int?> pages = const Value.absent(),
          Value<BookCategory?> secondCategory = const Value.absent()}) =>
      DbBook(
        id: id ?? this.id,
        name: name ?? this.name,
        publishingDate: publishingDate ?? this.publishingDate,
        isAvailable: isAvailable ?? this.isAvailable,
        category: category ?? this.category,
        price: price.present ? price.value : this.price,
        pages: pages.present ? pages.value : this.pages,
        secondCategory:
            secondCategory.present ? secondCategory.value : this.secondCategory,
      );
  @override
  String toString() {
    return (StringBuffer('DbBook(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('publishingDate: $publishingDate, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('category: $category, ')
          ..write('price: $price, ')
          ..write('pages: $pages, ')
          ..write('secondCategory: $secondCategory')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, publishingDate, isAvailable,
      category, price, pages, secondCategory);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbBook &&
          other.id == this.id &&
          other.name == this.name &&
          other.publishingDate == this.publishingDate &&
          other.isAvailable == this.isAvailable &&
          other.category == this.category &&
          other.price == this.price &&
          other.pages == this.pages &&
          other.secondCategory == this.secondCategory);
}

class DbBookTableCompanion extends UpdateCompanion<DbBook> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> publishingDate;
  final Value<bool> isAvailable;
  final Value<BookCategory> category;
  final Value<double?> price;
  final Value<int?> pages;
  final Value<BookCategory?> secondCategory;
  const DbBookTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.publishingDate = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.category = const Value.absent(),
    this.price = const Value.absent(),
    this.pages = const Value.absent(),
    this.secondCategory = const Value.absent(),
  });
  DbBookTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required DateTime publishingDate,
    required bool isAvailable,
    required BookCategory category,
    this.price = const Value.absent(),
    this.pages = const Value.absent(),
    this.secondCategory = const Value.absent(),
  })  : name = Value(name),
        publishingDate = Value(publishingDate),
        isAvailable = Value(isAvailable),
        category = Value(category);
  static Insertable<DbBook> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? publishingDate,
    Expression<bool>? isAvailable,
    Expression<String>? category,
    Expression<double>? price,
    Expression<int>? pages,
    Expression<String>? secondCategory,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (publishingDate != null) 'publishing_date': publishingDate,
      if (isAvailable != null) 'is_available': isAvailable,
      if (category != null) 'category': category,
      if (price != null) 'price': price,
      if (pages != null) 'pages': pages,
      if (secondCategory != null) 'second_category': secondCategory,
    });
  }

  DbBookTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<DateTime>? publishingDate,
      Value<bool>? isAvailable,
      Value<BookCategory>? category,
      Value<double?>? price,
      Value<int?>? pages,
      Value<BookCategory?>? secondCategory}) {
    return DbBookTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      publishingDate: publishingDate ?? this.publishingDate,
      isAvailable: isAvailable ?? this.isAvailable,
      category: category ?? this.category,
      price: price ?? this.price,
      pages: pages ?? this.pages,
      secondCategory: secondCategory ?? this.secondCategory,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (publishingDate.present) {
      map['publishing_date'] = Variable<DateTime>(publishingDate.value);
    }
    if (isAvailable.present) {
      map['is_available'] = Variable<bool>(isAvailable.value);
    }
    if (category.present) {
      final converter = $DbBookTableTable.$convertercategory;
      map['category'] = Variable<String>(converter.toSql(category.value));
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (pages.present) {
      map['pages'] = Variable<int>(pages.value);
    }
    if (secondCategory.present) {
      final converter = $DbBookTableTable.$convertersecondCategoryn;
      map['second_category'] =
          Variable<String>(converter.toSql(secondCategory.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbBookTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('publishingDate: $publishingDate, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('category: $category, ')
          ..write('price: $price, ')
          ..write('pages: $pages, ')
          ..write('secondCategory: $secondCategory')
          ..write(')'))
        .toString();
  }
}

class $DbBookTableTable extends DbBookTable
    with TableInfo<$DbBookTableTable, DbBook> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbBookTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _publishingDateMeta =
      const VerificationMeta('publishingDate');
  @override
  late final GeneratedColumn<DateTime> publishingDate =
      GeneratedColumn<DateTime>('publishing_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isAvailableMeta =
      const VerificationMeta('isAvailable');
  @override
  late final GeneratedColumn<bool> isAvailable =
      GeneratedColumn<bool>('is_available', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_available" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumnWithTypeConverter<BookCategory, String> category =
      GeneratedColumn<String>('category', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<BookCategory>($DbBookTableTable.$convertercategory);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _pagesMeta = const VerificationMeta('pages');
  @override
  late final GeneratedColumn<int> pages = GeneratedColumn<int>(
      'pages', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _secondCategoryMeta =
      const VerificationMeta('secondCategory');
  @override
  late final GeneratedColumnWithTypeConverter<BookCategory?, String>
      secondCategory = GeneratedColumn<String>(
              'second_category', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<BookCategory?>(
              $DbBookTableTable.$convertersecondCategoryn);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        publishingDate,
        isAvailable,
        category,
        price,
        pages,
        secondCategory
      ];
  @override
  String get aliasedName => _alias ?? 'db_book_table';
  @override
  String get actualTableName => 'db_book_table';
  @override
  VerificationContext validateIntegrity(Insertable<DbBook> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('publishing_date')) {
      context.handle(
          _publishingDateMeta,
          publishingDate.isAcceptableOrUnknown(
              data['publishing_date']!, _publishingDateMeta));
    } else if (isInserting) {
      context.missing(_publishingDateMeta);
    }
    if (data.containsKey('is_available')) {
      context.handle(
          _isAvailableMeta,
          isAvailable.isAcceptableOrUnknown(
              data['is_available']!, _isAvailableMeta));
    } else if (isInserting) {
      context.missing(_isAvailableMeta);
    }
    context.handle(_categoryMeta, const VerificationResult.success());
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    }
    if (data.containsKey('pages')) {
      context.handle(
          _pagesMeta, pages.isAcceptableOrUnknown(data['pages']!, _pagesMeta));
    }
    context.handle(_secondCategoryMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbBook map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbBook(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      publishingDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}publishing_date'])!,
      isAvailable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_available'])!,
      category: $DbBookTableTable.$convertercategory.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!),
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price']),
      pages: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pages']),
      secondCategory: $DbBookTableTable.$convertersecondCategoryn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}second_category'])),
    );
  }

  @override
  $DbBookTableTable createAlias(String alias) {
    return $DbBookTableTable(attachedDatabase, alias);
  }

  static TypeConverter<BookCategory, String> $convertercategory =
      const BookTableBookCategoryConverter();
  static TypeConverter<BookCategory, String> $convertersecondCategory =
      const BookTableBookCategoryConverter();
  static TypeConverter<BookCategory?, String?> $convertersecondCategoryn =
      NullAwareTypeConverter.wrap($convertersecondCategory);
}

abstract class _$ModelGeneratorExampleDatabase extends GeneratedDatabase {
  _$ModelGeneratorExampleDatabase(QueryExecutor e) : super(e);
  late final $DbBookTableTable dbBookTable = $DbBookTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dbBookTable];
}
