import 'package:model_generator/util/keyword_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Default', () {
    test('KeywordHelper', () {
      KeywordHelper.instance.list.forEach((element) {
        expect(KeywordHelper.instance.getCorrectKeyword(element),
            '${element}Value');
      });
    });
  });
}
