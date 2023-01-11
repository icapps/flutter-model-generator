import 'dart:io';

import 'package:model_generator/model/model/enum_model.dart';
import 'package:model_generator/writer/enum_model_writer.dart';
import 'package:test/test.dart';

class WriterTestHelper {
  static testEnumModelWriter(EnumModel model, String resultFileName) {
    print(Directory.current);
    final file = File('test/writer/enum_model_writer/$resultFileName.txt');
    final output = file.readAsStringSync();
    final actual = EnumModelWriter(model).write();
    expect(actual, output);
  }
}
