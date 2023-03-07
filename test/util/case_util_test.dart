import 'package:model_generator/util/case_util.dart';
import 'package:test/test.dart';

void main() {
  group('Default', () {
    test('Case Util normal text all lowercase', () {
      expect(CaseUtil('hallokes').originalText, 'hallokes');
      expect(CaseUtil('hallokes').lowerCamelCase, 'hallokes');
      expect(CaseUtil('hallokes').upperCamelCase, 'Hallokes');
      expect(CaseUtil('hallokes').snakeCase, 'hallokes');
    });

    test('Case Util normal text all uppercase', () {
      expect(CaseUtil('HALLOKES').originalText, 'HALLOKES');
      expect(CaseUtil('HALLOKES').lowerCamelCase, 'hallokes');
      expect(CaseUtil('HALLOKES').upperCamelCase, 'Hallokes');
      expect(CaseUtil('HALLOKES').snakeCase, 'hallokes');
    });

    test('Case Util lower camel case', () {
      expect(CaseUtil('hiThere').originalText, 'hiThere');
      expect(CaseUtil('hiThere').lowerCamelCase, 'hiThere');
      expect(CaseUtil('hiThere').upperCamelCase, 'HiThere');
      expect(CaseUtil('hiThere').snakeCase, 'hi_there');
    });

    test('Case Util upper camel case', () {
      expect(CaseUtil('HiThere').originalText, 'HiThere');
      expect(CaseUtil('HiThere').lowerCamelCase, 'hiThere');
      expect(CaseUtil('HiThere').upperCamelCase, 'HiThere');
      expect(CaseUtil('HiThere').snakeCase, 'hi_there');
    });

    test('Case Util snake case', () {
      expect(CaseUtil('hi_there').originalText, 'hi_there');
      expect(CaseUtil('hi_there').lowerCamelCase, 'hiThere');
      expect(CaseUtil('hi_there').upperCamelCase, 'HiThere');
      expect(CaseUtil('hi_there').snakeCase, 'hi_there');
    });

    test('Case Util ', () {
      expect(CaseUtil('hi-there').originalText, 'hi-there');
      expect(CaseUtil('hi-there').lowerCamelCase, 'hiThere');
      expect(CaseUtil('hi-there').upperCamelCase, 'HiThere');
      expect(CaseUtil('hi-there').snakeCase, 'hi_there');
    });
  });
}
