// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_generator_example_database.dart';

// ignore_for_file: type=lint
class DbBook extends DataClass implements Insertable<DbBook> {
  final String name;
  final DateTime publishingDate;
  final bool isAvailable;
  final double? price;
  final int? pages;
  const DbBook(
      {required this.name,
      required this.publishingDate,
      required this.isAvailable,
      this.price,
      this.pages});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['publishing_date'] = Variable<DateTime>(publishingDate);
    map['is_available'] = Variable<bool>(isAvailable);
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    if (!nullToAbsent || pages != null) {
      map['pages'] = Variable<int>(pages);
    }
    return map;
  }

  DbBookTableCompanion toCompanion(bool nullToAbsent) {
    return DbBookTableCompanion(
      name: Value(name),
      publishingDate: Value(publishingDate),
      isAvailable: Value(isAvailable),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      pages:
          pages == null && nullToAbsent ? const Value.absent() : Value(pages),
    );
  }

  factory DbBook.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbBook(
      name: serializer.fromJson<String>(json['name']),
      publishingDate: serializer.fromJson<DateTime>(json['publishingDate']),
      isAvailable: serializer.fromJson<bool>(json['isAvailable']),
      price: serializer.fromJson<double?>(json['price']),
      pages: serializer.fromJson<int?>(json['pages']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'publishingDate': serializer.toJson<DateTime>(publishingDate),
      'isAvailable': serializer.toJson<bool>(isAvailable),
      'price': serializer.toJson<double?>(price),
      'pages': serializer.toJson<int?>(pages),
    };
  }

  DbBook copyWith(
          {String? name,
          DateTime? publishingDate,
          bool? isAvailable,
          Value<double?> price = const Value.absent(),
          Value<int?> pages = const Value.absent()}) =>
      DbBook(
        name: name ?? this.name,
        publishingDate: publishingDate ?? this.publishingDate,
        isAvailable: isAvailable ?? this.isAvailable,
        price: price.present ? price.value : this.price,
        pages: pages.present ? pages.value : this.pages,
      );
  @override
  String toString() {
    return (StringBuffer('DbBook(')
          ..write('name: $name, ')
          ..write('publishingDate: $publishingDate, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('price: $price, ')
          ..write('pages: $pages')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(name, publishingDate, isAvailable, price, pages);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbBook &&
          other.name == this.name &&
          other.publishingDate == this.publishingDate &&
          other.isAvailable == this.isAvailable &&
          other.price == this.price &&
          other.pages == this.pages);
}

class DbBookTableCompanion extends UpdateCompanion<DbBook> {
  final Value<String> name;
  final Value<DateTime> publishingDate;
  final Value<bool> isAvailable;
  final Value<double?> price;
  final Value<int?> pages;
  const DbBookTableCompanion({
    this.name = const Value.absent(),
    this.publishingDate = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.price = const Value.absent(),
    this.pages = const Value.absent(),
  });
  DbBookTableCompanion.insert({
    required String name,
    required DateTime publishingDate,
    required bool isAvailable,
    this.price = const Value.absent(),
    this.pages = const Value.absent(),
  })  : name = Value(name),
        publishingDate = Value(publishingDate),
        isAvailable = Value(isAvailable);
  static Insertable<DbBook> custom({
    Expression<String>? name,
    Expression<DateTime>? publishingDate,
    Expression<bool>? isAvailable,
    Expression<double>? price,
    Expression<int>? pages,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (publishingDate != null) 'publishing_date': publishingDate,
      if (isAvailable != null) 'is_available': isAvailable,
      if (price != null) 'price': price,
      if (pages != null) 'pages': pages,
    });
  }

  DbBookTableCompanion copyWith(
      {Value<String>? name,
      Value<DateTime>? publishingDate,
      Value<bool>? isAvailable,
      Value<double?>? price,
      Value<int?>? pages}) {
    return DbBookTableCompanion(
      name: name ?? this.name,
      publishingDate: publishingDate ?? this.publishingDate,
      isAvailable: isAvailable ?? this.isAvailable,
      price: price ?? this.price,
      pages: pages ?? this.pages,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (publishingDate.present) {
      map['publishing_date'] = Variable<DateTime>(publishingDate.value);
    }
    if (isAvailable.present) {
      map['is_available'] = Variable<bool>(isAvailable.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (pages.present) {
      map['pages'] = Variable<int>(pages.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbBookTableCompanion(')
          ..write('name: $name, ')
          ..write('publishingDate: $publishingDate, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('price: $price, ')
          ..write('pages: $pages')
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
  @override
  List<GeneratedColumn> get $columns =>
      [name, publishingDate, isAvailable, price, pages];
  @override
  String get aliasedName => _alias ?? 'db_book_table';
  @override
  String get actualTableName => 'db_book_table';
  @override
  VerificationContext validateIntegrity(Insertable<DbBook> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    }
    if (data.containsKey('pages')) {
      context.handle(
          _pagesMeta, pages.isAcceptableOrUnknown(data['pages']!, _pagesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  DbBook map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbBook(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      publishingDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}publishing_date'])!,
      isAvailable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_available'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price']),
      pages: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pages']),
    );
  }

  @override
  $DbBookTableTable createAlias(String alias) {
    return $DbBookTableTable(attachedDatabase, alias);
  }
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
