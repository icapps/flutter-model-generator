import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:model_generator/model/model/enum_model.dart';
import 'package:model_generator/writer/enum_model_writer.dart';

class WriterTestHelper {
  static testEnumModelWriter(EnumModel enumModel, String resultFileName) {
    print(Directory.current);
    final file = File('writer/enum_model_writer/output/$resultFileName.txt');
    final output = file.readAsStringSync();
    expect(EnumModelWriter(enumModel).write(), output);
  }
}
