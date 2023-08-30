import 'dart:async';
import 'dart:convert';
import 'dart:io';

class ProcessRunner {
  ProcessRunner._();

  static Future<void> runProcessVerbose(
      String command, List<String> args) async {
    print('\n$command ${args.join(' ')}\n');
    final completer = Completer<void>();
    final result = await Process.start(
      command,
      args,
      mode: ProcessStartMode.detachedWithStdio,
    );
    print(
        '======================================================================');
    final subscription = result.stdout
        .listen((codeUnits) => stdout.write(utf8.decode(codeUnits)));
    subscription.onDone(() {
      print(
          '======================================================================');
      completer.complete();
    });
    subscription.onError((dynamic error) =>
        completer.completeError('Failed to complete process run: $error'));
    return completer.future;
  }
}
