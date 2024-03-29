# Changelog
## [7.0.0] - 2023-08-14
- *BREAKING CHANGE*: Every type is now defined inline, this means that 'required' is no longer supported, if a field isn't nullable it is automatically required. This also means that the 'array' type is no longer supported and is instead just defined like 'List<T>'.
- *BREAKING CHANGE*: The way enums are defined has changed, see readme for more information. You can now add properties to enums, optional and default values are supported.
- *BREAKING CHANGE*: Enums are now by default not uppercase anymore, you can still enable this my adding 'uppercase_enums: true' to your pubspec or enum configuration
- Logs of build runner now get shown in real time.
- You are now allowed to have no properties configured for a class.

## [6.3.0] - 2023-06-05
- Fixed the deprecated `ignore` field. Added
```yaml
    includeFromJson: false
    includeToJson: false
```

## [6.2.1] - 2023-03-07
- Updated the enum model generator to correctly generate the (reverse)Mapping based on the item_type

## [6.2.0] - 2023-02-23
- Better enum support. Right now, String, int, double can be used to map a value to an enum.

## [6.1.0] - 2022-10-14
- Support passing a directory instead of a file. All .yaml files inside this folder (recursively) will be used to build the final model data.

## [6.0.2] - 2022-10-06
- Updated travis to use linux instead of macOS

## [6.0.1] - 2022-10-05
- Don't create dart:core imports for custom objects

## [6.0.0] - 2022-10-04
- Added the ability to specify simple fields in a more compact way, inline.

Example: id and id2, name and name2 are equivalent notations
```yaml
ExampleModel:
  properties:
    id: string
    id2: 
      type: string
      required: true
    name: string?
    name2:
      type: string
      required: false
```

## [5.9.0] - 2022-03-29
- *POTENTIALLY BREAKING CHANGE*: By default, fields with a default value will now accept 'null' to use their default value
- Add options to control whether fields with default value accepts 'null' or not
  - `disallow_null` on fields
  - `disallow_null_for_defaults` on the root yml config or the object config

## [5.8.1] - 2021-12-09
- Detect the current min dart version and use newer features when available. (Fixes #108)

## [5.8.0] - 2021-11-25
- Added `retrofit_compute` option to generate top-level functions compatible with retrofit's compute mode. (Fixes #106)

## [5.7.1] - 2021-11-13
- Fixed issue where default values would still throw missing key exceptions. (Fixes #103)

## [5.7.0] - 2021-11-02
- Added better support for import sorting. This way the analyzer won't break each time you build. (Fixes #101)

## [5.6.0] - 2021-10-22
- Support default values for properties. (Fixes #54)

## [5.5.0] - 2021-10-17
- Allow configuration that ignores certain fields for equals and hashCode generation. (Fixes #99)

## [5.4.0] - 2021-10-16
- Allow configuration that stops the automatic uppercasing of enums. (Fixes #97)

## [5.3.1] - 2021-09-19
- Fixed bug that caused the generation loop to prematurely exit when it encountered a custom or json converter model

## [5.3.0] - 2021-09-14
- Ensure the import directives are sorted (new lint rules)
- Ensure dynamic fields are not marked nullable (new lint rules)

## [5.2.0] - 2021-09-07
- fromJson & toJson custom override

## [5.1.1] - 2021-08-27
- Add support for adding `description` on fields to generate documentation entries
- Fix self references (#82)

## [5.0.0] - 2021-07-27
### Breaking
- include_if_null changed the default value to false
### Added
- explicit_to_json at global level (default is true)
- explicit_to_json at model level (default is true)

## [4.3.2] - 2021-05-06
### Added
- Added support for generating a mapping for enum's: `generate_map: true`
- Added support for generating extension methods using the enum's mapping: `generate_extensions: true`
### Fixed
- Custom models will not generate a new file

## [4.3.0] - 2021-04-20
### Added
- Added support for adding extra annotations and imports
- Added support for generating == and hashCode
- Added support for generating toString

## [4.2.0] - 2021-04-20
### Added
- Support Map support

## [4.1.0] - 2021-02-22
### Added
- Support for generatic generics fromJsonT()

## [4.0.0] - 2021-02-09
### Added
- Support for generating models with nullsafety support to support Flutter 2.0 & dart 2.12
###Removed
- nullsafe flag is removed because from this version we are targeting 2.12 which will use nullsafety by default

## [3.3.0] - 2020-10-24
### Added
- 100% test coverage
- Better error logging
- boolean list support
### Updated
- Travis scripts 
- Flutter Android Example project to use v2 embedding
- SDK constraints ">=2.2.0 <3.0.0" 
### Fixed
- Fvm was not always detected correctly
- Some bugs
- dynamic list support

## [3.2.0] - 2020-10-14
### Added
- Parameter and command line to specify your own config.yaml (#16 Thanks to [NicolaChimerapps](https://github.com/NicolaChimerapps))

## [3.1.0] - 2020-10-13
### Added
- Added support for importing other dart packages when using path (Thanks to [NicolaChimerapps](https://github.com/NicolaChimerapps))
- Added support for json_converter (#43 Thanks to [NicolaChimerapps](https://github.com/NicolaChimerapps))

## [3.0.0] - 2020-10-06
### Breaking Change
- renamed includeIfNull to include_if_nul to keep a consistent api
### Added
- Added unknown_enum_value support (#44 Thanks to [DimmyMaenhout](https://github.com/DimmyMaenhout))
- Added non_final support (#34 Thanks to [NicolaChimerapps](https://github.com/NicolaChimerapps))

## [2.3.0] - 2020-10-04
### Added
- FVM support

## [2.2.0] - 2020-10-04
### Added
- Travis CI support (badge)
- Coveralls test coverage support (badge) (no test yet [issue #38](https://github.com/icapps/flutter-model-generator/issues/38))
- MIT license (badge)
- Support for custom base_directory (Thanks to [JeremiFerre](https://github.com/JeremiFerre))
- Support for dynamic dart type (Thanks to [JeremiFerre](https://github.com/JeremiFerre))
- Support for includeIfNull annotation property (Thanks to [DimmyMaenhout](https://github.com/DimmyMaenhout))
### Fixed
- The removed .g.dart files (Thanks to [JeremiFerre](https://github.com/JeremiFerre))
### Updated
- Documentation updated
- Dependencies updated
- License

## [2.1.2] - 2020-07-24
### Fixed
- Formatting

## [2.1.1] - 2020-07-24
### Fixed
- Analyzer

## [2.1.0] - 2020-07-24
### Added
- #26 supprot for custom objects
- #28 support for custom fromJson & toJson objects

## [2.0.0] - 2020-06-11
### BREAKING 
### Added
- Change snake case to camelCase (Thanks to [NicolaChimerapps](https://github.com/NicolaChimerapps))

## [1.6.0] - 2020-06-11
### Added 
- Custom jsonKey support (Thanks to [NicolaChimerapps](https://github.com/NicolaChimerapps))

## [1.5.0] - 2020-05-19
### Fixed 
- Major bug when you did not specify object. (object is the default now)

## [1.4.1] - 2020-05-18
### Fixed
- Formatting

## [1.4.0] - 2020-05-18
### Added
- #19 Enum support you can now use add enums (with values) to your config.yaml 

## [1.3.0] - 2020-04-22
### Fixed
- #17 path ending with a / would crash your app 

## [1.2.0] - 2020-04-22
### Fixed
- #13 @JsonKey( ignore: true) should be a variable instead of a final field 

## [1.1.0] - 2020-02-01
### Added
- #11 option to ignore a field in the json serialization

## [1.0.0] - 2020-01-21
### Fixed
- #6 yield is not supported. (keywords are changed to `yieldValue` the jsonName will still be `yield`)
- #7 fixed readme
- #8 _ should be removed
- Some extra bugs and a more standard form is used.

## [0.4.2] - 2019-10-09
### Fixed
- Fixed import for @required

## [0.4.0] - 2019-10-09
### Added
- Named params to the models

## [0.3.0] - 2019-10-09
### Added
- Nullable fields added 

## [0.2.1] - 2019-10-09
### Fixed
- Crash when using keywords 

## [0.2.0] - 2019-10-09
### Added
- Custom Path 

## [0.1.0] - 2019-10-09
### Fixed
- Bugfixing for unknown types
- DateTime supported
- number supported

## [0.0.1] - 2019-09-27
### Added
-Initial release
