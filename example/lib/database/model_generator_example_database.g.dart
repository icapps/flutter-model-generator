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

abstract class _$ModelGeneratorExampleDatabase extends GeneratedDatabase {
  _$ModelGeneratorExampleDatabase(QueryExecutor e) : super(e);
  late final $DbBookTableTable dbBookTable = $DbBookTableTable(this);
  late final $DbPersonTableTable dbPersonTable = $DbPersonTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [dbBookTable, dbPersonTable];
}
