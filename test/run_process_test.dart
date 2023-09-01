import 'package:model_generator/run_process/run_process.dart';
import 'package:test/test.dart';

void main() {
  test('test run process', () async {
    final lines = [];
    await ProcessRunner.runProcessVerbose(
      'echo',
      [
        'hello',
        'world',
      ],
      (line) => lines.add(line),
    );

    expect(lines.join('\n'), 'hello world\n');
  });
}
