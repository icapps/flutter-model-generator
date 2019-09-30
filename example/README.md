# Example for the icapps generator

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