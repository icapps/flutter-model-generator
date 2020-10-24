import 'package:model_generator/util/case_util.dart';
import 'package:model_generator/util/keyword_helper.dart';
import 'package:test/test.dart';

void main() {
  group('Default', () {
    test('KeywordHelper', () {
      KeywordHelper.instance.list.forEach((element) {
        expect(KeywordHelper.instance.getCorrectKeyword(element), '${element}Value');
      });
    });
  });
}
