import 'package:kiwi/kiwi.dart';
import 'package:model_generator_example/util/util.dart';

part 'injector.g.dart';

abstract class Injector {
  @Register.singleton(Util)
  void registerCommonDependencies();

  void registerViewModelFactories();
}

void setupDependencyTree() {
  _$Injector()
    ..registerCommonDependencies()
    ..registerViewModelFactories();
}
