# flutter icapps generator

A dart package to automaticly generate new code when creating a new screen. 
This package should be used in combination with the [icapps template](https://github.com/icapps/flutter-template)

[![pub package](https://img.shields.io/pub/v/icapps_generator.svg)](https://pub.dartlang.org/packages/icapps_generator)

This repo contains an example how to use this package.

Packages used:
 - provider
 - kiwi
 - icapps_generator

## Setup

### Add dependency to pubspec

[![pub package](https://img.shields.io/pub/v/icapps_generator.svg)](https://pub.dartlang.org/packages/icapps_generator)
```
dev-dependencies:
  icapps_generator: <latest-version>
```
### Run package with Flutter

```
flutter packages pub run icapps_generator your_screen_name
```

### Run package with Dart

```
pub run icapps_generator your_screen_name
```

### Result

Code will be generated:

- Screen
- ViewModel
- Add @Register.factory to the injector file
- Add code to make sure you can navigate to your new screen in the MainNavigatorWidget
- Generate the dependecy tree

### Working on mac?

add this to you .bash_profile

```
fluttergenerator(){
 flutter packages pub run icapps_generator $1
}
```

now you can use the icapps generator with a single command.

```
fluttergenerator your_screen_name
```