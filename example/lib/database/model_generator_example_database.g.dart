// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_generator_example_database.dart';

// ignore_for_file: type=lint
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
  static const VerificationMeta _authorFirstNameMeta =
      const VerificationMeta('authorFirstName');
  @override
  late final GeneratedColumn<String> authorFirstName = GeneratedColumn<String>(
      'author_first_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorLastNameMeta =
      const VerificationMeta('authorLastName');
  @override
  late final GeneratedColumn<String> authorLastName = GeneratedColumn<String>(
      'author_last_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  static const VerificationMeta _publisherFirstNameMeta =
      const VerificationMeta('publisherFirstName');
  @override
  late final GeneratedColumn<String> publisherFirstName =
      GeneratedColumn<String>('publisher_first_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _publisherLastNameMeta =
      const VerificationMeta('publisherLastName');
  @override
  late final GeneratedColumn<String> publisherLastName =
      GeneratedColumn<String>('publisher_last_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> tags =
      GeneratedColumn<String>('tags', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<String>?>($DbBookTableTable.$convertertagsn);
  static const VerificationMeta _secondCategoryMeta =
      const VerificationMeta('secondCategory');
  @override
  late final GeneratedColumnWithTypeConverter<BookCategory?, String>
      secondCategory = GeneratedColumn<String>(
              'second_category', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<BookCategory?>(
              $DbBookTableTable.$convertersecondCategory);
  static const VerificationMeta _onlyInDbMeta =
      const VerificationMeta('onlyInDb');
  @override
  late final GeneratedColumn<String> onlyInDb = GeneratedColumn<String>(
      'only_in_db', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        publishingDate,
        isAvailable,
        authorFirstName,
        authorLastName,
        category,
        price,
        pages,
        publisherFirstName,
        publisherLastName,
        tags,
        secondCategory,
        onlyInDb
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
    if (data.containsKey('author_first_name')) {
      context.handle(
          _authorFirstNameMeta,
          authorFirstName.isAcceptableOrUnknown(
              data['author_first_name']!, _authorFirstNameMeta));
    } else if (isInserting) {
      context.missing(_authorFirstNameMeta);
    }
    if (data.containsKey('author_last_name')) {
      context.handle(
          _authorLastNameMeta,
          authorLastName.isAcceptableOrUnknown(
              data['author_last_name']!, _authorLastNameMeta));
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
    if (data.containsKey('publisher_first_name')) {
      context.handle(
          _publisherFirstNameMeta,
          publisherFirstName.isAcceptableOrUnknown(
              data['publisher_first_name']!, _publisherFirstNameMeta));
    }
    if (data.containsKey('publisher_last_name')) {
      context.handle(
          _publisherLastNameMeta,
          publisherLastName.isAcceptableOrUnknown(
              data['publisher_last_name']!, _publisherLastNameMeta));
    }
    context.handle(_tagsMeta, const VerificationResult.success());
    context.handle(_secondCategoryMeta, const VerificationResult.success());
    if (data.containsKey('only_in_db')) {
      context.handle(_onlyInDbMeta,
          onlyInDb.isAcceptableOrUnknown(data['only_in_db']!, _onlyInDbMeta));
    }
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
      authorFirstName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}author_first_name'])!,
      authorLastName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}author_last_name']),
      category: $DbBookTableTable.$convertercategory.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!),
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price']),
      pages: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pages']),
      publisherFirstName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}publisher_first_name']),
      publisherLastName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}publisher_last_name']),
      tags: $DbBookTableTable.$convertertagsn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])),
      secondCategory: $DbBookTableTable.$convertersecondCategory.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}second_category'])),
      onlyInDb: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}only_in_db']),
    );
  }

  @override
  $DbBookTableTable createAlias(String alias) {
    return $DbBookTableTable(attachedDatabase, alias);
  }

  static TypeConverter<BookCategory, String> $convertercategory =
      const BookTableBookCategoryConverter();
  static TypeConverter<List<String>, String> $convertertags =
      const StringListConverter();
  static TypeConverter<List<String>?, String?> $convertertagsn =
      NullAwareTypeConverter.wrap($convertertags);
  static TypeConverter<BookCategory?, String?> $convertersecondCategory =
      const BookTableBookCategoryNullableConverter();
}

class DbBook extends DataClass implements Insertable<DbBook> {
  final int id;
  final String name;
  final DateTime publishingDate;
  final bool isAvailable;
  final String authorFirstName;
  final String? authorLastName;
  final BookCategory category;
  final double? price;
  final int? pages;
  final String? publisherFirstName;
  final String? publisherLastName;
  final List<String>? tags;
  final BookCategory? secondCategory;
  final String? onlyInDb;
  const DbBook(
      {required this.id,
      required this.name,
      required this.publishingDate,
      required this.isAvailable,
      required this.authorFirstName,
      this.authorLastName,
      required this.category,
      this.price,
      this.pages,
      this.publisherFirstName,
      this.publisherLastName,
      this.tags,
      this.secondCategory,
      this.onlyInDb});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['publishing_date'] = Variable<DateTime>(publishingDate);
    map['is_available'] = Variable<bool>(isAvailable);
    map['author_first_name'] = Variable<String>(authorFirstName);
    if (!nullToAbsent || authorLastName != null) {
      map['author_last_name'] = Variable<String>(authorLastName);
    }
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
    if (!nullToAbsent || publisherFirstName != null) {
      map['publisher_first_name'] = Variable<String>(publisherFirstName);
    }
    if (!nullToAbsent || publisherLastName != null) {
      map['publisher_last_name'] = Variable<String>(publisherLastName);
    }
    if (!nullToAbsent || tags != null) {
      final converter = $DbBookTableTable.$convertertagsn;
      map['tags'] = Variable<String>(converter.toSql(tags));
    }
    if (!nullToAbsent || secondCategory != null) {
      final converter = $DbBookTableTable.$convertersecondCategory;
      map['second_category'] =
          Variable<String>(converter.toSql(secondCategory));
    }
    if (!nullToAbsent || onlyInDb != null) {
      map['only_in_db'] = Variable<String>(onlyInDb);
    }
    return map;
  }

  DbBookTableCompanion toCompanion(bool nullToAbsent) {
    return DbBookTableCompanion(
      id: Value(id),
      name: Value(name),
      publishingDate: Value(publishingDate),
      isAvailable: Value(isAvailable),
      authorFirstName: Value(authorFirstName),
      authorLastName: authorLastName == null && nullToAbsent
          ? const Value.absent()
          : Value(authorLastName),
      category: Value(category),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      pages:
          pages == null && nullToAbsent ? const Value.absent() : Value(pages),
      publisherFirstName: publisherFirstName == null && nullToAbsent
          ? const Value.absent()
          : Value(publisherFirstName),
      publisherLastName: publisherLastName == null && nullToAbsent
          ? const Value.absent()
          : Value(publisherLastName),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      secondCategory: secondCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(secondCategory),
      onlyInDb: onlyInDb == null && nullToAbsent
          ? const Value.absent()
          : Value(onlyInDb),
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
      authorFirstName: serializer.fromJson<String>(json['authorFirstName']),
      authorLastName: serializer.fromJson<String?>(json['authorLastName']),
      category: serializer.fromJson<BookCategory>(json['category']),
      price: serializer.fromJson<double?>(json['price']),
      pages: serializer.fromJson<int?>(json['pages']),
      publisherFirstName:
          serializer.fromJson<String?>(json['publisherFirstName']),
      publisherLastName:
          serializer.fromJson<String?>(json['publisherLastName']),
      tags: serializer.fromJson<List<String>?>(json['tags']),
      secondCategory:
          serializer.fromJson<BookCategory?>(json['secondCategory']),
      onlyInDb: serializer.fromJson<String?>(json['onlyInDb']),
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
      'authorFirstName': serializer.toJson<String>(authorFirstName),
      'authorLastName': serializer.toJson<String?>(authorLastName),
      'category': serializer.toJson<BookCategory>(category),
      'price': serializer.toJson<double?>(price),
      'pages': serializer.toJson<int?>(pages),
      'publisherFirstName': serializer.toJson<String?>(publisherFirstName),
      'publisherLastName': serializer.toJson<String?>(publisherLastName),
      'tags': serializer.toJson<List<String>?>(tags),
      'secondCategory': serializer.toJson<BookCategory?>(secondCategory),
      'onlyInDb': serializer.toJson<String?>(onlyInDb),
    };
  }

  DbBook copyWith(
          {int? id,
          String? name,
          DateTime? publishingDate,
          bool? isAvailable,
          String? authorFirstName,
          Value<String?> authorLastName = const Value.absent(),
          BookCategory? category,
          Value<double?> price = const Value.absent(),
          Value<int?> pages = const Value.absent(),
          Value<String?> publisherFirstName = const Value.absent(),
          Value<String?> publisherLastName = const Value.absent(),
          Value<List<String>?> tags = const Value.absent(),
          Value<BookCategory?> secondCategory = const Value.absent(),
          Value<String?> onlyInDb = const Value.absent()}) =>
      DbBook(
        id: id ?? this.id,
        name: name ?? this.name,
        publishingDate: publishingDate ?? this.publishingDate,
        isAvailable: isAvailable ?? this.isAvailable,
        authorFirstName: authorFirstName ?? this.authorFirstName,
        authorLastName:
            authorLastName.present ? authorLastName.value : this.authorLastName,
        category: category ?? this.category,
        price: price.present ? price.value : this.price,
        pages: pages.present ? pages.value : this.pages,
        publisherFirstName: publisherFirstName.present
            ? publisherFirstName.value
            : this.publisherFirstName,
        publisherLastName: publisherLastName.present
            ? publisherLastName.value
            : this.publisherLastName,
        tags: tags.present ? tags.value : this.tags,
        secondCategory:
            secondCategory.present ? secondCategory.value : this.secondCategory,
        onlyInDb: onlyInDb.present ? onlyInDb.value : this.onlyInDb,
      );
  @override
  String toString() {
    return (StringBuffer('DbBook(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('publishingDate: $publishingDate, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('authorFirstName: $authorFirstName, ')
          ..write('authorLastName: $authorLastName, ')
          ..write('category: $category, ')
          ..write('price: $price, ')
          ..write('pages: $pages, ')
          ..write('publisherFirstName: $publisherFirstName, ')
          ..write('publisherLastName: $publisherLastName, ')
          ..write('tags: $tags, ')
          ..write('secondCategory: $secondCategory, ')
          ..write('onlyInDb: $onlyInDb')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      publishingDate,
      isAvailable,
      authorFirstName,
      authorLastName,
      category,
      price,
      pages,
      publisherFirstName,
      publisherLastName,
      tags,
      secondCategory,
      onlyInDb);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbBook &&
          other.id == this.id &&
          other.name == this.name &&
          other.publishingDate == this.publishingDate &&
          other.isAvailable == this.isAvailable &&
          other.authorFirstName == this.authorFirstName &&
          other.authorLastName == this.authorLastName &&
          other.category == this.category &&
          other.price == this.price &&
          other.pages == this.pages &&
          other.publisherFirstName == this.publisherFirstName &&
          other.publisherLastName == this.publisherLastName &&
          other.tags == this.tags &&
          other.secondCategory == this.secondCategory &&
          other.onlyInDb == this.onlyInDb);
}

class DbBookTableCompanion extends UpdateCompanion<DbBook> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> publishingDate;
  final Value<bool> isAvailable;
  final Value<String> authorFirstName;
  final Value<String?> authorLastName;
  final Value<BookCategory> category;
  final Value<double?> price;
  final Value<int?> pages;
  final Value<String?> publisherFirstName;
  final Value<String?> publisherLastName;
  final Value<List<String>?> tags;
  final Value<BookCategory?> secondCategory;
  final Value<String?> onlyInDb;
  const DbBookTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.publishingDate = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.authorFirstName = const Value.absent(),
    this.authorLastName = const Value.absent(),
    this.category = const Value.absent(),
    this.price = const Value.absent(),
    this.pages = const Value.absent(),
    this.publisherFirstName = const Value.absent(),
    this.publisherLastName = const Value.absent(),
    this.tags = const Value.absent(),
    this.secondCategory = const Value.absent(),
    this.onlyInDb = const Value.absent(),
  });
  DbBookTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required DateTime publishingDate,
    required bool isAvailable,
    required String authorFirstName,
    this.authorLastName = const Value.absent(),
    required BookCategory category,
    this.price = const Value.absent(),
    this.pages = const Value.absent(),
    this.publisherFirstName = const Value.absent(),
    this.publisherLastName = const Value.absent(),
    this.tags = const Value.absent(),
    this.secondCategory = const Value.absent(),
    this.onlyInDb = const Value.absent(),
  })  : name = Value(name),
        publishingDate = Value(publishingDate),
        isAvailable = Value(isAvailable),
        authorFirstName = Value(authorFirstName),
        category = Value(category);
  static Insertable<DbBook> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? publishingDate,
    Expression<bool>? isAvailable,
    Expression<String>? authorFirstName,
    Expression<String>? authorLastName,
    Expression<String>? category,
    Expression<double>? price,
    Expression<int>? pages,
    Expression<String>? publisherFirstName,
    Expression<String>? publisherLastName,
    Expression<String>? tags,
    Expression<String>? secondCategory,
    Expression<String>? onlyInDb,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (publishingDate != null) 'publishing_date': publishingDate,
      if (isAvailable != null) 'is_available': isAvailable,
      if (authorFirstName != null) 'author_first_name': authorFirstName,
      if (authorLastName != null) 'author_last_name': authorLastName,
      if (category != null) 'category': category,
      if (price != null) 'price': price,
      if (pages != null) 'pages': pages,
      if (publisherFirstName != null)
        'publisher_first_name': publisherFirstName,
      if (publisherLastName != null) 'publisher_last_name': publisherLastName,
      if (tags != null) 'tags': tags,
      if (secondCategory != null) 'second_category': secondCategory,
      if (onlyInDb != null) 'only_in_db': onlyInDb,
    });
  }

  DbBookTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<DateTime>? publishingDate,
      Value<bool>? isAvailable,
      Value<String>? authorFirstName,
      Value<String?>? authorLastName,
      Value<BookCategory>? category,
      Value<double?>? price,
      Value<int?>? pages,
      Value<String?>? publisherFirstName,
      Value<String?>? publisherLastName,
      Value<List<String>?>? tags,
      Value<BookCategory?>? secondCategory,
      Value<String?>? onlyInDb}) {
    return DbBookTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      publishingDate: publishingDate ?? this.publishingDate,
      isAvailable: isAvailable ?? this.isAvailable,
      authorFirstName: authorFirstName ?? this.authorFirstName,
      authorLastName: authorLastName ?? this.authorLastName,
      category: category ?? this.category,
      price: price ?? this.price,
      pages: pages ?? this.pages,
      publisherFirstName: publisherFirstName ?? this.publisherFirstName,
      publisherLastName: publisherLastName ?? this.publisherLastName,
      tags: tags ?? this.tags,
      secondCategory: secondCategory ?? this.secondCategory,
      onlyInDb: onlyInDb ?? this.onlyInDb,
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
    if (authorFirstName.present) {
      map['author_first_name'] = Variable<String>(authorFirstName.value);
    }
    if (authorLastName.present) {
      map['author_last_name'] = Variable<String>(authorLastName.value);
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
    if (publisherFirstName.present) {
      map['publisher_first_name'] = Variable<String>(publisherFirstName.value);
    }
    if (publisherLastName.present) {
      map['publisher_last_name'] = Variable<String>(publisherLastName.value);
    }
    if (tags.present) {
      final converter = $DbBookTableTable.$convertertagsn;
      map['tags'] = Variable<String>(converter.toSql(tags.value));
    }
    if (secondCategory.present) {
      final converter = $DbBookTableTable.$convertersecondCategory;
      map['second_category'] =
          Variable<String>(converter.toSql(secondCategory.value));
    }
    if (onlyInDb.present) {
      map['only_in_db'] = Variable<String>(onlyInDb.value);
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
          ..write('authorFirstName: $authorFirstName, ')
          ..write('authorLastName: $authorLastName, ')
          ..write('category: $category, ')
          ..write('price: $price, ')
          ..write('pages: $pages, ')
          ..write('publisherFirstName: $publisherFirstName, ')
          ..write('publisherLastName: $publisherLastName, ')
          ..write('tags: $tags, ')
          ..write('secondCategory: $secondCategory, ')
          ..write('onlyInDb: $onlyInDb')
          ..write(')'))
        .toString();
  }
}

class $DbPersonTableTable extends DbPersonTable
    with TableInfo<$DbPersonTableTable, DbPerson> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbPersonTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumnWithTypeConverter<Gender, String> gender =
      GeneratedColumn<String>('gender', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Gender>($DbPersonTableTable.$convertergender);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [firstName, gender, lastName];
  @override
  String get aliasedName => _alias ?? 'db_person_table';
  @override
  String get actualTableName => 'db_person_table';
  @override
  VerificationContext validateIntegrity(Insertable<DbPerson> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    context.handle(_genderMeta, const VerificationResult.success());
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {firstName, lastName};
  @override
  DbPerson map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbPerson(
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      gender: $DbPersonTableTable.$convertergender.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!),
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name']),
    );
  }

  @override
  $DbPersonTableTable createAlias(String alias) {
    return $DbPersonTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Gender, String> $convertergender =
      const PersonTableGenderConverter();
}

class DbPerson extends DataClass implements Insertable<DbPerson> {
  final String firstName;
  final Gender gender;
  final String? lastName;
  const DbPerson(
      {required this.firstName, required this.gender, this.lastName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['first_name'] = Variable<String>(firstName);
    {
      final converter = $DbPersonTableTable.$convertergender;
      map['gender'] = Variable<String>(converter.toSql(gender));
    }
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String>(lastName);
    }
    return map;
  }

  DbPersonTableCompanion toCompanion(bool nullToAbsent) {
    return DbPersonTableCompanion(
      firstName: Value(firstName),
      gender: Value(gender),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
    );
  }

  factory DbPerson.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbPerson(
      firstName: serializer.fromJson<String>(json['firstName']),
      gender: serializer.fromJson<Gender>(json['gender']),
      lastName: serializer.fromJson<String?>(json['lastName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'firstName': serializer.toJson<String>(firstName),
      'gender': serializer.toJson<Gender>(gender),
      'lastName': serializer.toJson<String?>(lastName),
    };
  }

  DbPerson copyWith(
          {String? firstName,
          Gender? gender,
          Value<String?> lastName = const Value.absent()}) =>
      DbPerson(
        firstName: firstName ?? this.firstName,
        gender: gender ?? this.gender,
        lastName: lastName.present ? lastName.value : this.lastName,
      );
  @override
  String toString() {
    return (StringBuffer('DbPerson(')
          ..write('firstName: $firstName, ')
          ..write('gender: $gender, ')
          ..write('lastName: $lastName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(firstName, gender, lastName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbPerson &&
          other.firstName == this.firstName &&
          other.gender == this.gender &&
          other.lastName == this.lastName);
}

class DbPersonTableCompanion extends UpdateCompanion<DbPerson> {
  final Value<String> firstName;
  final Value<Gender> gender;
  final Value<String?> lastName;
  const DbPersonTableCompanion({
    this.firstName = const Value.absent(),
    this.gender = const Value.absent(),
    this.lastName = const Value.absent(),
  });
  DbPersonTableCompanion.insert({
    required String firstName,
    required Gender gender,
    this.lastName = const Value.absent(),
  })  : firstName = Value(firstName),
        gender = Value(gender);
  static Insertable<DbPerson> custom({
    Expression<String>? firstName,
    Expression<String>? gender,
    Expression<String>? lastName,
  }) {
    return RawValuesInsertable({
      if (firstName != null) 'first_name': firstName,
      if (gender != null) 'gender': gender,
      if (lastName != null) 'last_name': lastName,
    });
  }

  DbPersonTableCompanion copyWith(
      {Value<String>? firstName,
      Value<Gender>? gender,
      Value<String?>? lastName}) {
    return DbPersonTableCompanion(
      firstName: firstName ?? this.firstName,
      gender: gender ?? this.gender,
      lastName: lastName ?? this.lastName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (gender.present) {
      final converter = $DbPersonTableTable.$convertergender;
      map['gender'] = Variable<String>(converter.toSql(gender.value));
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbPersonTableCompanion(')
          ..write('firstName: $firstName, ')
          ..write('gender: $gender, ')
          ..write('lastName: $lastName')
          ..write(')'))
        .toString();
  }
}

class $DbBookEditorsTableTable extends DbBookEditorsTable
    with TableInfo<$DbBookEditorsTableTable, DbBookEditors> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbBookEditorsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _editorsFirstNameMeta =
      const VerificationMeta('editorsFirstName');
  @override
  late final GeneratedColumn<String> editorsFirstName = GeneratedColumn<String>(
      'editors_first_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _editorsLastNameMeta =
      const VerificationMeta('editorsLastName');
  @override
  late final GeneratedColumn<String> editorsLastName = GeneratedColumn<String>(
      'editors_last_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, editorsFirstName, editorsLastName];
  @override
  String get aliasedName => _alias ?? 'db_book_editors_table';
  @override
  String get actualTableName => 'db_book_editors_table';
  @override
  VerificationContext validateIntegrity(Insertable<DbBookEditors> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('editors_first_name')) {
      context.handle(
          _editorsFirstNameMeta,
          editorsFirstName.isAcceptableOrUnknown(
              data['editors_first_name']!, _editorsFirstNameMeta));
    } else if (isInserting) {
      context.missing(_editorsFirstNameMeta);
    }
    if (data.containsKey('editors_last_name')) {
      context.handle(
          _editorsLastNameMeta,
          editorsLastName.isAcceptableOrUnknown(
              data['editors_last_name']!, _editorsLastNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  DbBookEditors map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbBookEditors(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      editorsFirstName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}editors_first_name'])!,
      editorsLastName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}editors_last_name']),
    );
  }

  @override
  $DbBookEditorsTableTable createAlias(String alias) {
    return $DbBookEditorsTableTable(attachedDatabase, alias);
  }
}

class DbBookEditors extends DataClass implements Insertable<DbBookEditors> {
  final int id;
  final String editorsFirstName;
  final String? editorsLastName;
  const DbBookEditors(
      {required this.id, required this.editorsFirstName, this.editorsLastName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['editors_first_name'] = Variable<String>(editorsFirstName);
    if (!nullToAbsent || editorsLastName != null) {
      map['editors_last_name'] = Variable<String>(editorsLastName);
    }
    return map;
  }

  DbBookEditorsTableCompanion toCompanion(bool nullToAbsent) {
    return DbBookEditorsTableCompanion(
      id: Value(id),
      editorsFirstName: Value(editorsFirstName),
      editorsLastName: editorsLastName == null && nullToAbsent
          ? const Value.absent()
          : Value(editorsLastName),
    );
  }

  factory DbBookEditors.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbBookEditors(
      id: serializer.fromJson<int>(json['id']),
      editorsFirstName: serializer.fromJson<String>(json['editorsFirstName']),
      editorsLastName: serializer.fromJson<String?>(json['editorsLastName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'editorsFirstName': serializer.toJson<String>(editorsFirstName),
      'editorsLastName': serializer.toJson<String?>(editorsLastName),
    };
  }

  DbBookEditors copyWith(
          {int? id,
          String? editorsFirstName,
          Value<String?> editorsLastName = const Value.absent()}) =>
      DbBookEditors(
        id: id ?? this.id,
        editorsFirstName: editorsFirstName ?? this.editorsFirstName,
        editorsLastName: editorsLastName.present
            ? editorsLastName.value
            : this.editorsLastName,
      );
  @override
  String toString() {
    return (StringBuffer('DbBookEditors(')
          ..write('id: $id, ')
          ..write('editorsFirstName: $editorsFirstName, ')
          ..write('editorsLastName: $editorsLastName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, editorsFirstName, editorsLastName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbBookEditors &&
          other.id == this.id &&
          other.editorsFirstName == this.editorsFirstName &&
          other.editorsLastName == this.editorsLastName);
}

class DbBookEditorsTableCompanion extends UpdateCompanion<DbBookEditors> {
  final Value<int> id;
  final Value<String> editorsFirstName;
  final Value<String?> editorsLastName;
  const DbBookEditorsTableCompanion({
    this.id = const Value.absent(),
    this.editorsFirstName = const Value.absent(),
    this.editorsLastName = const Value.absent(),
  });
  DbBookEditorsTableCompanion.insert({
    required int id,
    required String editorsFirstName,
    this.editorsLastName = const Value.absent(),
  })  : id = Value(id),
        editorsFirstName = Value(editorsFirstName);
  static Insertable<DbBookEditors> custom({
    Expression<int>? id,
    Expression<String>? editorsFirstName,
    Expression<String>? editorsLastName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (editorsFirstName != null) 'editors_first_name': editorsFirstName,
      if (editorsLastName != null) 'editors_last_name': editorsLastName,
    });
  }

  DbBookEditorsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? editorsFirstName,
      Value<String?>? editorsLastName}) {
    return DbBookEditorsTableCompanion(
      id: id ?? this.id,
      editorsFirstName: editorsFirstName ?? this.editorsFirstName,
      editorsLastName: editorsLastName ?? this.editorsLastName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (editorsFirstName.present) {
      map['editors_first_name'] = Variable<String>(editorsFirstName.value);
    }
    if (editorsLastName.present) {
      map['editors_last_name'] = Variable<String>(editorsLastName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbBookEditorsTableCompanion(')
          ..write('id: $id, ')
          ..write('editorsFirstName: $editorsFirstName, ')
          ..write('editorsLastName: $editorsLastName')
          ..write(')'))
        .toString();
  }
}

class $DbBookTranslatorsTableTable extends DbBookTranslatorsTable
    with TableInfo<$DbBookTranslatorsTableTable, DbBookTranslators> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbBookTranslatorsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _translatorsFirstNameMeta =
      const VerificationMeta('translatorsFirstName');
  @override
  late final GeneratedColumn<String> translatorsFirstName =
      GeneratedColumn<String>('translators_first_name', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _translatorsLastNameMeta =
      const VerificationMeta('translatorsLastName');
  @override
  late final GeneratedColumn<String> translatorsLastName =
      GeneratedColumn<String>('translators_last_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, translatorsFirstName, translatorsLastName];
  @override
  String get aliasedName => _alias ?? 'db_book_translators_table';
  @override
  String get actualTableName => 'db_book_translators_table';
  @override
  VerificationContext validateIntegrity(Insertable<DbBookTranslators> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('translators_first_name')) {
      context.handle(
          _translatorsFirstNameMeta,
          translatorsFirstName.isAcceptableOrUnknown(
              data['translators_first_name']!, _translatorsFirstNameMeta));
    } else if (isInserting) {
      context.missing(_translatorsFirstNameMeta);
    }
    if (data.containsKey('translators_last_name')) {
      context.handle(
          _translatorsLastNameMeta,
          translatorsLastName.isAcceptableOrUnknown(
              data['translators_last_name']!, _translatorsLastNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  DbBookTranslators map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbBookTranslators(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      translatorsFirstName: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}translators_first_name'])!,
      translatorsLastName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}translators_last_name']),
    );
  }

  @override
  $DbBookTranslatorsTableTable createAlias(String alias) {
    return $DbBookTranslatorsTableTable(attachedDatabase, alias);
  }
}

class DbBookTranslators extends DataClass
    implements Insertable<DbBookTranslators> {
  final int id;
  final String translatorsFirstName;
  final String? translatorsLastName;
  const DbBookTranslators(
      {required this.id,
      required this.translatorsFirstName,
      this.translatorsLastName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['translators_first_name'] = Variable<String>(translatorsFirstName);
    if (!nullToAbsent || translatorsLastName != null) {
      map['translators_last_name'] = Variable<String>(translatorsLastName);
    }
    return map;
  }

  DbBookTranslatorsTableCompanion toCompanion(bool nullToAbsent) {
    return DbBookTranslatorsTableCompanion(
      id: Value(id),
      translatorsFirstName: Value(translatorsFirstName),
      translatorsLastName: translatorsLastName == null && nullToAbsent
          ? const Value.absent()
          : Value(translatorsLastName),
    );
  }

  factory DbBookTranslators.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbBookTranslators(
      id: serializer.fromJson<int>(json['id']),
      translatorsFirstName:
          serializer.fromJson<String>(json['translatorsFirstName']),
      translatorsLastName:
          serializer.fromJson<String?>(json['translatorsLastName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'translatorsFirstName': serializer.toJson<String>(translatorsFirstName),
      'translatorsLastName': serializer.toJson<String?>(translatorsLastName),
    };
  }

  DbBookTranslators copyWith(
          {int? id,
          String? translatorsFirstName,
          Value<String?> translatorsLastName = const Value.absent()}) =>
      DbBookTranslators(
        id: id ?? this.id,
        translatorsFirstName: translatorsFirstName ?? this.translatorsFirstName,
        translatorsLastName: translatorsLastName.present
            ? translatorsLastName.value
            : this.translatorsLastName,
      );
  @override
  String toString() {
    return (StringBuffer('DbBookTranslators(')
          ..write('id: $id, ')
          ..write('translatorsFirstName: $translatorsFirstName, ')
          ..write('translatorsLastName: $translatorsLastName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, translatorsFirstName, translatorsLastName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbBookTranslators &&
          other.id == this.id &&
          other.translatorsFirstName == this.translatorsFirstName &&
          other.translatorsLastName == this.translatorsLastName);
}

class DbBookTranslatorsTableCompanion
    extends UpdateCompanion<DbBookTranslators> {
  final Value<int> id;
  final Value<String> translatorsFirstName;
  final Value<String?> translatorsLastName;
  const DbBookTranslatorsTableCompanion({
    this.id = const Value.absent(),
    this.translatorsFirstName = const Value.absent(),
    this.translatorsLastName = const Value.absent(),
  });
  DbBookTranslatorsTableCompanion.insert({
    required int id,
    required String translatorsFirstName,
    this.translatorsLastName = const Value.absent(),
  })  : id = Value(id),
        translatorsFirstName = Value(translatorsFirstName);
  static Insertable<DbBookTranslators> custom({
    Expression<int>? id,
    Expression<String>? translatorsFirstName,
    Expression<String>? translatorsLastName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (translatorsFirstName != null)
        'translators_first_name': translatorsFirstName,
      if (translatorsLastName != null)
        'translators_last_name': translatorsLastName,
    });
  }

  DbBookTranslatorsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? translatorsFirstName,
      Value<String?>? translatorsLastName}) {
    return DbBookTranslatorsTableCompanion(
      id: id ?? this.id,
      translatorsFirstName: translatorsFirstName ?? this.translatorsFirstName,
      translatorsLastName: translatorsLastName ?? this.translatorsLastName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (translatorsFirstName.present) {
      map['translators_first_name'] =
          Variable<String>(translatorsFirstName.value);
    }
    if (translatorsLastName.present) {
      map['translators_last_name'] =
          Variable<String>(translatorsLastName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbBookTranslatorsTableCompanion(')
          ..write('id: $id, ')
          ..write('translatorsFirstName: $translatorsFirstName, ')
          ..write('translatorsLastName: $translatorsLastName')
          ..write(')'))
        .toString();
  }
}

abstract class _$ModelGeneratorExampleDatabase extends GeneratedDatabase {
  _$ModelGeneratorExampleDatabase(QueryExecutor e) : super(e);
  late final $DbBookTableTable dbBookTable = $DbBookTableTable(this);
  late final $DbPersonTableTable dbPersonTable = $DbPersonTableTable(this);
  late final $DbBookEditorsTableTable dbBookEditorsTable =
      $DbBookEditorsTableTable(this);
  late final $DbBookTranslatorsTableTable dbBookTranslatorsTable =
      $DbBookTranslatorsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [dbBookTable, dbPersonTable, dbBookEditorsTable, dbBookTranslatorsTable];
}
