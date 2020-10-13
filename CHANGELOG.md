# Changelog

## [3.0.0] - 2020-10-06
### Breaking Change 
- renamed includeIfNull to include_if_nul to keep a consistent api
### Added
- Added unknown_enum_value support
- Added non_final support
- Added support for json_converter

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
- Change snake case to camelCase (Thanks to [NicolaChimerapps](https://github.com/NicolaChimerapps "Github NicolaChimerapps"))

## [1.6.0] - 2020-06-11
### Added 
- Custom jsonKey support (Thanks to [NicolaChimerapps](https://github.com/NicolaChimerapps "Github NicolaChimerapps"))

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
