# Model Generator

This model generator can be used to generate JsonSerializable models

[![pub package](https://img.shields.io/pub/v/model_generator.svg)](https://pub.dartlang.org/packages/model_generator)
[![Build Status](https://app.travis-ci.com/icapps/flutter-model-generator.svg?branch=master)](https://app.travis-ci.com/icapps/flutter-model-generator)
[![Coverage Status](https://coveralls.io/repos/github/icapps/flutter-model-generator/badge.svg?branch=master)](https://coveralls.io/github/icapps/flutter-model-generator?branch=master)
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

## Run

`flutter packages run model_generator`

## Model file(s)

By default, the model generator looks for the model yaml file in `model_generator/config.yaml`. If you want to overwrite this, specify it in your `pubspec.yaml` file by
using `config_path`. Example of the `pubspec.yaml` file if you want to use a custom model file location:

```yaml
model_generator:
  config_path: my_model_dir/config.yaml
```

You can also specify a command line parameter to override the location for a single run. For this, use the `--path` command line parameter. Example:

```bash
flutter packages run model_generator --path my_other_model_dir/config.yaml
```

**Note**: Since version 6.1.0, instead of a single model file, you can specify a directory containing multiple model files. 
The generator will then generate models for all `.yaml` (or `.yml`) files in the directory. References across files are supported.

## Default setup

Example of the `pubspec.yaml` file if you want to use a custom base_directory for all your models Default is `/lib/model` you can override it for all your models like this:

```yaml
model_generator:
  base_directory: custom_models
```

this will write all your models to /lib/custom_models
`path` will be added after the `base_directory`

Example of the `model_generator/config.yaml` file:

```yaml
UserModel:
  path: webservice/user
  converters:
    - DateTimeConverter
  properties:
    id:
      type: int
    name:
      type: String
    salary:
      type: double
    something:
      type: dynamic
    isLoggedIn:
      type: bool
      default_value: false
    roles:
      type: array
      items:
        type: String
    birthday:
      type: date
    addresses:
      type: array
      items:
        type: Address
    idToAddress:
      type: map
      items:
        key: String
        value: Address
    securityRole:
      type: String
      jsonKey: securityIndicator
    dynamicField:
      type: dynamic
    includeIfNullField:
      include_if_null: false #If this field is null, this field will not be added to your json object (used for PATCH models)
      type: String
    ignoreField:
      ignore: false #this field will not be final, and not be used in the json parsing
      type: String
    mutableField:
      non_final: true #Field will not be marked final
      type: String
    changedAt:
      type: datetime
    idToAddressList:
      type: map
      items:
        key: String
        value: List<Address>

Address:
  path: webservice/user #Can also be package:... and/or end with the actual file (.dart)
  properties:
    street:
      type: String

#Custom base_directory
CustomBaseDirectoryObject:
  base_directory: custom_models
  path: webservice
  properties:
    path:
      type: String

#Custom json converter. Use with converters property on models
DateTimeConverter:
  type: json_converter
  path: converter/

Book:
  path: book/
  generate_table: true # A Drift table will be generated
  properties:
    id:
      type: int
      required: true
      is_table_primary_key: true # This is the primary key, this can be set on any number of fields
    name: string
    publishingDate: datetime
    price: double? # nullable fields will generate nullable database columns
    pages: int?
    isAvailable: bool
    authors:
      type: array
      required: true # this is required, so will be added to the getModel method as required
      ignore_for_table: true # You can specify whether a field is added to the table or not. If it is not added, you can still specify it in the getModel method to convert between DB model and generated model
      items:
        type: Person
    publishers:
      type: array # Arrays will not be added to the table, but specified in the getModel method. You should add another table for them (manually or generated)
      required: false # this is NOT required, so will be added to the getModel method as optional
      items:
        type: Person
    category: BookCategory # Enums can be added and will be converted to a text and back
    secondCategory: BookCategory?

Person:
  path: user/person/
  type: object
  properties:
    firstName: string

BookCategory:
  path: book/
  type: enum
  properties:
    UNKOWN:
    FICTION:
    FANTASY:
```


## FVM support

If you are using fvm for managing your flutter version. You can add an option to the model generator as well to run with fvm. add an option `use_fvm` and set it to true. (by
default it is set to false)

```yaml
model_generator:
  use_fvm: true
```

## == and hashCode

If you want the generated models to include code for == and hashCode, you can turn it on in `pubspec.yaml`. Defaults to false. All fields are taken into consideration for the
generated code.

```yaml
model_generator:
  equals_and_hash_code: true
```

or to override the values per object:

```yaml
UserModel:
  path: webservice/user
  equals_and_hash_code: false
  properties:
    id:
      type: int
```

### Ignored fields

If you wish to ignore certain fields when generating the `==` and `hashCode` methods, you can mark those fields with `ignore_equality: true`.

**Note**: Models with all fields ignored will report a zero hash code and equal only on identity

```yaml
UserModel:
  path: webservice/user
  equals_and_hash_code: false
  properties:
    id:
      type: int
      ignore_equality: true
    include:
      type: String
```

## explicit_to_json

By default json_serializable will not generate the toJson methods on an other json_serializable object or list or map. With the model_generator we can enable this by default since
5.0.0 You can override it at a global level:

```yaml
model_generator:
  explicit_to_json: false
```

or to override the values per object:

```yaml
UserModel:
  path: webservice/user
  explicit_to_json: false
  properties:
    id:
      type: int
```

## toString

If you want the generated models to include generated toString code, you can turn it on in `pubspec.yaml`. Defaults to false. All fields are taken into consideration for the
generated code.

```yaml
model_generator:
  to_string: true
```

or to override the values per object:

```yaml
UserModel:
  path: webservice/user
  to_string: false
  properties:
    id:
      type: int
```

## Extra imports and annotations

If you wish for extra import statements in the generated files and/or extra annotations on the generated model classes, you can specify those in `pubspec.yaml`

```yaml
model_generator:
  extra_imports:
    - 'package:flutter/foundation.dart'
  extra_annotations:
    - '@immutable'
```

or to override the values per object:

```yaml
UserModel:
  path: webservice/user
  extra_imports:
  extra_annotations:
    - '@someAnnotation'
  properties:
    id:
      type: int
```

## Default values

Since version `5.6.0` default values are supported for properties. You can specify a default value for both required and optional properties by adding `default_value: ...` to the
property definition.

**Note:** Default values are taken exactly how they are specified in the yaml file, this means for example that you will need to quote strings correctly, ensure imports are there,
ensure the value is a constant, ...

```yaml
UserModel:
  path: webservice/user
  extra_imports:
  extra_annotations:
    - '@someAnnotation'
  properties:
    id:
      type: int
      default_value: 1
    name:
      type: String
      required: true
      default_value: "'an example quoted string'"
```

### Default values and null

Since version `5.9.0` fields with default values can accept null values in json. In which case the default value will be used instead.

If you wish to control this behaviour, you can add `disallow_null_for_defaults: true` to either the `model_generator` config or the model property. Alternatively you can specify
the behaviour per field by using `disallow_null`.

Example:

```yaml
model_generator:
  disallow_null_for_defaults: true
```

Example 2:

```yaml
UserModel:
  path: webservice/user
  disallow_null_for_defaults: true
  properties:
    id:
      type: int
      default_value: 1
    name:
      type: String
      required: true
      default_value: "'an example quoted string'"
```

Example 3:

```yaml
UserModel:
  path: webservice/user
  properties:
    id:
      type: int
      default_value: 1
    name:
      type: String
      required: true
      default_value: "'an example quoted string'"
      disallow_null: true
```

## Generics support support

If you want your models to generate code that can be used in combination with generics. use this:

```yaml
model_generator:
  generate_for_generics: true
```

or to override the default generate_for_generics value in the pubspec.yaml

```yaml
UserModel:
  path: webservice/user
  generate_for_generics: true
  converters:
    - DateTimeConverter
  properties:
    id:
      type: int
```

## Extends

If you want your models to expand any other model use extends:

*Note: It is not supported to extend custom models*

```yaml
UserDetails:
  path: webservice/user
  extends: UserModel
  properties:
    name:
      type: String
```

## Builtin types
The following framework types descriptors are known out of the box:
```
string/String
int/integer
bool/boolean
double
date/datetime
dynamic/object/any
array
map
```

## Inline types (since 6.0.0)

In some cases, writing the full specification for simple fields is very verbose. Since 6.0.0 it is possible to write simple fields inline, without nesting below the field name:

```yaml
UserModel:
  properties:
    id: int
    name: String
    age: int
    is_active: bool?
    created_at: DateTime
    roles: List<string>
    customProperties: Map<String, Property>?
```

Currently all basic types are supported, simple Lists and Maps (no nested types, no nullable generic parameters) as well as references to other objects.
Items post-fixed with `?` will be marked optional.

## Enum support

Add enums with custom values

```yaml
Gender:
  path: webservice/user
  type: enum
  properties:
    MALE:
      value: _mAl3
    FEMALE:
      value: femAle
    X:
      value: X
    Y:
```

### Generate mapping

For enums, it is also possible to have a map generated that maps from the enum value to its string representation and reverse. To enable this, use `generate_map: true`

```yaml
Gender:
  path: webservice/user
  type: enum
  generate_map: true
  properties:
    MALE:
      value: _mAl3
    FEMALE:
      value: femAle
    X:
      value: X
    Y:
```

### Generate mapping extensions

When generating maps, it is also possible to specify that special extension functions should be added that return either the string value or that takes a string value and tries to
convert it to the enum value. To enable this, use `generate_map: true` **AND** `generate_extensions: true`

```yaml
Gender:
  path: webservice/user
  type: enum
  generate_map: true
  generate_extensions: true
  properties:
    MALE:
      value: _mAl3
    FEMALE:
      value: femAle
    X:
      value: X
    Y:
```

### Use unknownEnumValue

```yaml
UnknownEnumTestObject:
  path: webservice
  properties:
    path:
      unknown_enum_value: X
      type: Gender
```

### Automatic case conversion

By default all fields will be converted into uppercase. You can control this behavior globally for all enums or per-enum by setting the `uppercase_enums` property to `true` (
default) or `false`

```yaml
model_generator:
  uppercase_enums: false
```

or

```yaml
UnknownEnumTestObject:
  path: webservice
  uppercase_enums: false
  properties:
    path:
```

## Custom object

Support for custom objects that are not generated by the model generator.

Paths are either local to the project, package specifications (package:...) or dart:core

```yaml
CustomObject:
  path: data/custom/
  type: custom
```

### Required methods inside your class

```
  factory {Model_Name}.fromJson(Map<String, dynamic> json) => _${Model_Name}FromJson(json);

  Map<String, dynamic> toJson() => _${Model_Name}ToJson(this);
```

## fromJson & toJson

Support for custom objects but use fromJson & toJson instead of full object parsing:

```yaml
CustomObjectFromToJson:
  path: data/custom/
  type: custom_from_to_json
```

### Required functions outside your class

```
{Model_Name} handle{Model_Name}FromJson(object) => {Model_Name}.fromJson(object);

{Original_Type} handle{Model_Name}ToJson({Model_Name} data) => data.toJson();

```

## fromJson & toJson override

Support for custom objects but use fromJson & toJson instead of full object parsing:

```yaml
UserModel:
  path: webservice/user
  properties:
    description: The time at which the user has last updated his information
    changedAt:
      type: datetime
      fromJson: handleFromJsonWithCustomCode
      toJson: handleToJsonWithCustomCode
```

### Required functions outside your file. (extra import should be used)

## JsonConverter support

You can specify custom json converters to be used for types that match

```yaml
UserModel:
  path: webservice/user
  converters:
    - DateTimeConverter
  properties:
    changedAt:
      type: datetime
```

Specify the custom JsonConverter object as a known type to resolve it

```yaml
DateTimeConverter:
  type: json_converter
  path: converter/
```

## Documentation support

You can specify `description` on models, enum, fields and on enum entries. This description will be used verbatim to generate a code comment for that class/enum/field

```yaml
UserModel:
  path: webservice/user
  description: The model holding user data
  converters:
    - DateTimeConverter
  properties:
    description: The time at which the user has last updated his information
    changedAt:
      type: datetime
```

## Static creator support

You can specify `static_create` on objects or globally in the `pubspec.yaml` file. If this is specified, a static creator method called `create` will be generated referencing the
factory constructor. This static method can be used as a function reference. Defaults to false

```yaml
UserModel:
  path: webservice/user
  static_create: true
  properties:
    changedAt:
      type: datetime
```

## Retrofit compute support

Retrofit has added compute function support for decoding json payload in version 3.0.0. This requires top-level functions with a certain signature. You can have model generator
generate these for you by setting `retrofit_compute: true` in the pubspec.yaml file:

```yaml
model_generator:
  retrofit_compute: true
```

## Drift table generation support

By adding `generate_table: true`, a drift table will be generated aswel as the regular model. It will contain all fields and have extensions made to convert between DB and Generated model. In case a field shouldn't be added to the database, you can specify `ignore_for_table: true` on the field. This will not add the field to the table, but will still be added to the getModel method. If the field is required, it will also be required in the getModel method. Otherwise it will be optional.

You can specify a primary key by setting `is_table_primary_key: true` on the field. This can be set on any number of fields. You can also specify a field as autoincrement by setting `table_auto_increment: true` on the field. This can only be set on one field and no primary key should be specified (this will not throw an error in the generator, but will throw an error when running the generated code).

You still need to manually add the table to the database and add the migrations (if applicable). See example/lib/database/model_generator_example_database.dart for an example.

```yaml
Book:
  path: book/
  generate_table: true # A Drift table will be generated
  properties:
    id:
      type: int
      required: true
      is_table_primary_key: true # This is the primary key, this can be set on any number of fields
    name: string
    publishingDate: datetime
    price: double? # nullable fields will generate nullable database columns
    pages: int?
    isAvailable: bool
    authors:
      type: array
      required: true # this is required, so will be added to the getModel method as required
      ignore_for_table: true # You can specify whether a field is added to the table or not. If it is not added, you can still specify it in the getModel method to convert between DB model and generated model
      items:
        type: Person
    publishers:
      type: array # Arrays will not be added to the table, but specified in the getModel method. You should add another table for them (manually or generated)
      required: false # this is NOT required, so will be added to the getModel method as optional
      items:
        type: Person
    category: BookCategory # Enums can be added and will be converted to a text and back
    secondCategory: BookCategory?

Person:
  path: user/person/
  type: object
  properties:
    firstName: string

BookCategory:
  path: book/
  type: enum
  properties:
    UNKOWN:
    FICTION:
    FANTASY:
```

The above yaml will result in the following dart code:

```dart
@DataClassName('DbBook')
class DbBookTable extends Table {
  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  TextColumn get name => text()();

  DateTimeColumn get publishingDate => dateTime()();

  BoolColumn get isAvailable => boolean()();

  TextColumn get category =>
      text().map(const BookTableBookCategoryConverter())();

  RealColumn get price => real().nullable()();

  IntColumn get pages => integer().nullable()();

  TextColumn get secondCategory =>
      text().map(const BookTableBookCategoryConverter()).nullable()();
}

extension DbBookExtension on DbBook {
  Book getModel({required List<Person> authors, List<Person>? publishers}) =>
      Book(
        id: id,
        name: name,
        publishingDate: publishingDate,
        isAvailable: isAvailable,
        authors: authors,
        category: category,
        price: price,
        pages: pages,
        publishers: publishers,
        secondCategory: secondCategory,
      );
}

extension BookExtension on Book {
  DbBook get dbModel => DbBook(
        id: id,
        name: name,
        publishingDate: publishingDate,
        isAvailable: isAvailable,
        category: category,
        price: price,
        pages: pages,
        secondCategory: secondCategory,
      );
}

class BookTableBookCategoryConverter
    extends TypeConverter<BookCategory, String> {
  const BookTableBookCategoryConverter();

  @override
  BookCategory fromSql(String fromDb) {
    for (final value in BookCategory.values) {
      if (value.toString() == fromDb) return value;
    }
    return BookCategory.values.first;
  }

  @override
  String toSql(BookCategory value) {
    return value.toString();
  }
}
```