import 'package:args/args.dart';
import 'package:model_generator/main.dart';

Future<void> main(List<String> args) async {
  final argParser = ArgParser()
    ..addOption('path',
        help:
            'Override the default model configuration path. This value will be used instead of the default OR what you have configured in pubspec.yaml')
    ..addFlag('help',
        help: 'Displays this help screen', defaultsTo: false, negatable: false);

  final results = argParser.parse(args);
  if (results['help']) {
    print(argParser.usage);
    return;
  }
  ModelGenerator.generate(results);
}
