import 'package:model_generator/util/case_util.dart';
import 'package:test/test.dart';

void main() {
  group('Default', () {
    test('Case Util normal text all lowercase', () {
      expect(CaseUtil('hallokes').originalText, 'hallokes');
      expect(CaseUtil('hallokes').camelCase, 'hallokes');
      expect(CaseUtil('hallokes').pascalCase, 'Hallokes');
      expect(CaseUtil('hallokes').snakeCase, 'hallokes');
    });

    test('Case Util normal text all uppercase', () {
      expect(CaseUtil('HALLOKES').originalText, 'HALLOKES');
      expect(CaseUtil('HALLOKES').camelCase, 'hallokes');
      expect(CaseUtil('HALLOKES').pascalCase, 'Hallokes');
      expect(CaseUtil('HALLOKES').snakeCase, 'hallokes');
    });

    test('Case Util camel case', () {
      expect(CaseUtil('hiThere').originalText, 'hiThere');
      expect(CaseUtil('hiThere').camelCase, 'hiThere');
      expect(CaseUtil('hiThere').pascalCase, 'HiThere');
      expect(CaseUtil('hiThere').snakeCase, 'hi_there');
    });

    test('Case Util pascal case', () {
      expect(CaseUtil('HiThere').originalText, 'HiThere');
      expect(CaseUtil('HiThere').camelCase, 'hiThere');
      expect(CaseUtil('HiThere').pascalCase, 'HiThere');
      expect(CaseUtil('HiThere').snakeCase, 'hi_there');
    });

    test('Case Util snake case', () {
      expect(CaseUtil('hi_there').originalText, 'hi_there');
      expect(CaseUtil('hi_there').camelCase, 'hiThere');
      expect(CaseUtil('hi_there').pascalCase, 'HiThere');
      expect(CaseUtil('hi_there').snakeCase, 'hi_there');
    });

    test('Case Util ', () {
      expect(CaseUtil('hi-there').originalText, 'hi-there');
      expect(CaseUtil('hi-there').camelCase, 'hiThere');
      expect(CaseUtil('hi-there').pascalCase, 'HiThere');
      expect(CaseUtil('hi-there').snakeCase, 'hi_there');
    });
  });
}
