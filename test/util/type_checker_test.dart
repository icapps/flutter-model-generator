import 'package:model_generator/util/type_checker.dart';
import 'package:test/test.dart';

void main() {
  group('String', () {
    test('Is String', () {
      expect(TypeChecker.isKnownDartType('String'), true);
    });
    test('Is No String', () {
      expect(TypeChecker.isKnownDartType('string'), false);
    });
  });
  group('Int', () {
    test('Is int', () {
      expect(TypeChecker.isKnownDartType('int'), true);
    });
    test('Is No int', () {
      expect(TypeChecker.isKnownDartType('Int'), false);
    });
  });
  group('bool', () {
    test('Is bool', () {
      expect(TypeChecker.isKnownDartType('bool'), true);
    });
    test('Is No bool', () {
      expect(TypeChecker.isKnownDartType('Bool'), false);
      expect(TypeChecker.isKnownDartType('Boolean'), false);
      expect(TypeChecker.isKnownDartType('boolean'), false);
    });
  });
  group('double', () {
    test('Is double', () {
      expect(TypeChecker.isKnownDartType('double'), true);
    });
    test('Is No double', () {
      expect(TypeChecker.isKnownDartType('Double'), false);
    });
  });
  group('number', () {
    test('Is number', () {
      expect(TypeChecker.isKnownDartType('number'), true);
    });
    test('Is No number', () {
      expect(TypeChecker.isKnownDartType('Number'), false);
    });
  });
  group('dynamic', () {
    test('Is dynamic', () {
      expect(TypeChecker.isKnownDartType('dynamic'), true);
    });
    test('Is No dynamic', () {
      expect(TypeChecker.isKnownDartType('Dynamic'), false);
    });
  });
  group('DateTime', () {
    test('Is DateTime', () {
      expect(TypeChecker.isKnownDartType('DateTime'), true);
    });
    test('Is No DateTime', () {
      expect(TypeChecker.isKnownDartType('dateTime'), false);
    });
  });
}
