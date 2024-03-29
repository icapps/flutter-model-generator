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
    id: int
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
    include: String
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
    id: int
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
    id: int
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
    id: int
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
    id: int
```

## Extends

If you want your models to expand any other model use extends:

*Note: It is not supported to extend custom models*

```yaml
UserDetails:
  path: webservice/user
  extends: UserModel
  properties:
    name: String
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

## Default setup

Example of the `model_generator/config.yaml` file

```yaml
UserModel:
  path: webservice/user
  converters:
    - DateTimeConverter
  properties:
    id: int
    name: String
    salary: double
    something: dynamic
    isLoggedIn:
      type: bool
      default_value: false
    roles: List<String>
    birthday: date
    addresses: List<Address>
    idToAddress: Map<String, Address>
    securityRole:
      type: String
      jsonKey: securityIndicator
    dynamicField: dynamic
    includeIfNullField:
      include_if_null: false #If this field is null, this field will not be added to your json object (used for PATCH models)
      type: String
    ignoreField:
      ignore: false #This field is ignored in the to & from json methods
      type: String
    ignoreFieldOnlyInFrom:
      includeFromJson: false #This field is ignored in the from json method
      type: String
    ignoreFieldOnlyInTo:
      includeToJson: false #This field is ignored in the to json method
      type: String
    mutableField:
      non_final: true #Field will not be marked final
      type: String
    changedAt:
      type: DateTime
    idToAddressList: Map<String, List<Address>>

Address:
  path: webservice/user #Can also be package:... and/or end with the actual file (.dart)
  properties:
    street: String

#Custom base_directory
CustomBaseDirectoryObject:
  base_directory: custom_models
  path: webservice
  properties:
    path: String

#Custom json converter. Use with converters property on models
DateTimeConverter:
  type: json_converter
  path: converter/

```

## Inline types (since 6.0.0)

In some cases, writing the full specification for simple fields is very verbose. Since 6.0.0 it is possible to write simple fields inline, without nesting below the field name, since 7.0.0 nested lists and list in maps is also supported:

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
    customPropertiesList: Map<String, List<Property>>?
```
since 7.0.0 inline types are supported now even when adding extra configuration:

before:
```yaml
BookCase:
  path: webservice/BookCases
  properties:
    id: int
    books:
      type: array
      items:
        type: Book
      required: false
      include_if_null: false
```

now:
```yaml
BookCase:
  path: webservice/BookCases
  properties:
    id: int
    books:
      type: List<Book>?
      include_if_null: false
```

Currently all basic types are supported, simple Lists and Maps (no nullable generic parameters) as well as references to other objects.
Items post-fixed with `?` will be marked optional.

## Enum support (as of v7.0.0 enums now support properties)

Add simple enums, the name of the enum value (MALE, FEMALE, X, Y) will be used when parsing from json

```yaml
Gender:
  path: webservice/user
  type: enum
  values:
    MALE:
    FEMALE:
    X:
    Y:
```

By default enums will be generated with a property called jsonValue. this is the value of the enum used when parsing from json. This will only be used when there isn't already a custom jsonValue defined using 'is_json_value: true' in the properties of the enum. To turn this behavior of you can use 'use_default_json_value: false'.

```yaml
Gender:
  path: webservice/user
  use_default_json_value: false
  type: enum
  values:
    MALE:
    FEMALE:
    X:
    Y:
```

Add enums with custom properties (currently supported types are int, double, bool and String)

```yaml
Gender:
  path: webservice/user
  type: enum
  properties:
    abbreviation: String
  values:
    MALE:
      properties:
        abbreviation: m
    FEMALE:
      properties:
        abbreviation: f
    X:
      properties:
        abbreviation: x
    Y:
      properties:
        abbreviation: y
```

Define custom json key using is_json_value, the value of this property will then be used to parse from json

```yaml
Gender:
  path: webservice/user
  type: enum
  properties:
    key:
      type: String
      is_json_value: true
    abbreviation: String
  values:
    MALE:
      properties:
        key: male
        abbreviation: m
    FEMALE:
      properties:
        key: female
        abbreviation: f
    X:
      properties:
        key: x
        abbreviation: x
    Y:
      properties:
        key: y
        abbreviation: y
```

Optional and default values are supported. If value isn't defined for a property then it will use the defaultValue. If a property is optional and no value is given it is null.

```yaml
Gender:
  path: webservice/user
  type: enum
  properties:
    key:
      type: String
      is_json_value: true
    abbreviation:
      type: String
      default_value: m
    lastName: String?
  values:
    MALE:
      properties:
        key: male
    FEMALE:
      properties:
        key: female
        abbreviation: f
    X:
      properties:
        key: x
    Y:
      properties:
        key: y
        lastName: lastName
```

### Generate mapping extensions

It is possible to generate an extension for the enum that can turn the enum into it's corresponding jsonValue and the reverse.

```yaml
Person:
  path: test/enum/
  type: enum
  generate_extension: true
  properties:
    jsonValue: 
      is_json_value: true
      type: int
    firstName: String
    lastName: String
  values:
    MAN:
      properties:
        jsonKey: 1
        firstName: firstName1
        lastName: lastName1
    WOMAN:
      properties:
        jsonKey: 2
        firstName: firstName2
        lastName: lastName2

```
The above configuration will generate an enum with this extension.

```dart
extension PersonExtension on Person {
  static Person? fromJsonValue(int value) => Person.values.firstWhereOrNull((enumValue) => enumValue.jsonKey == value);

  int toJsonValue() => jsonKey;
}
```

### Generate mapping is no longer supported as of V7.0.0, use properties instead
### Use unknownEnumValue

```yaml
UnknownEnumTestObject:
  path: webservice
  properties:
    path:
      unknown_enum_value: X
      type: Gender
```

### Automatic case conversion(v7.0.0)

As of v7.0.0 by default all fields will be converted into lowercase camelcase instead of uppercase like before. You can control this behavior globally for all enums or per-enum by setting the `uppercase_enums` property to `false` (
default) or `true`. This only affects the name of the enum when using it in dart code. the jsonValue will still be the name you type in the config.

```yaml
model_generator:
  uppercase_enums: true
```

or

```yaml
UnknownEnumTestObject:
  path: webservice
  uppercase_enums: true
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
    changedAt: DateTime
```

Specify the custom JsonConverter object as a known type to resolve it

```yaml
DateTimeConverter:
  type: json_converter
  path: converter/
```

## Documentation support

You can specify `description` on models, enum, fields and on enum entries. This description will be used verbatim to generate a code comment for that class/enum/field

Example for a class:

```yaml
UserModel:
  path: webservice/user
  description: The model holding user data
  converters:
    - DateTimeConverter
  properties:
    description: The time at which the user has last updated his information
    changedAt: DateTime
```

Example for a enum:

```yaml
Person:
  path: test/enum/
  type: enum
  description: This is a enum of a person
  values:
    MAN:
      description: enum of a man
    WOMAN:
      description: enum of a woman
    OTHER:
      description: enum of a other
```


## Static creator support

You can specify `static_create` on objects or globally in the `pubspec.yaml` file. If this is specified, a static creator method called `create` will be generated referencing the
factory constructor. This static method can be used as a function reference. Defaults to false

```yaml
UserModel:
  path: webservice/user
  static_create: true
  properties:
    changedAt: DateTime
```

## Retrofit compute support

Retrofit has added compute function support for decoding json payload in version 3.0.0. This requires top-level functions with a certain signature. You can have model generator
generate these for you by setting `retrofit_compute: true` in the pubspec.yaml file:

```yaml
model_generator:
  retrofit_compute: true
```