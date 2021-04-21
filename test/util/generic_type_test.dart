import 'package:flutter_test/flutter_test.dart';
import 'package:model_generator/util/generic_type.dart';

void main() {
  group('Dart type tests', () {
    test('Test non generic', () {
      expect(DartType('int').generics.isEmpty, true);
      expect(DartType('MyModel').generics.isEmpty, true);
      expect(DartType('MyModel').baseType, 'MyModel');
      expect(DartType('int').baseType, 'int');
    });
    test('Test single generic', () {
      expect(DartType('List<int>').generics[0].baseType, 'int');
      expect(DartType('Map<int, String>').generics[0].baseType, 'int');
      expect(DartType('Map<int, String>').generics[1].baseType, 'String');
      expect(DartType('Map<int, String>').baseType, 'Map');
      expect(DartType('Set<MyModel>').generics[0].baseType, 'MyModel');
      expect(DartType('List<MyModel>').baseType, 'List');
      expect(DartType('Set < int   >').baseType, 'Set');
    });
    test('Test nested generic', () {
      expect(DartType('Map<int, List<String>>').generics[0].baseType, 'int');
      expect(DartType('Map<int, List<String>>').generics[1].baseType, 'List');
      expect(
          DartType('Map<int, List<String>>').generics[1].generics[0].baseType,
          'String');
    });
    test('Check type known non generic', () {
      DartType('int').checkTypesKnown(<String>{});
      DartType('String').checkTypesKnown(<String>{});
      DartType('MyType').checkTypesKnown(<String>{'MyType'});
      expect(() => DartType('Unknown').checkTypesKnown(<String>{'MyType'}),
          throwsA(isA<Exception>()));
    });
    test('Check type known generic', () {
      DartType('List<int>').checkTypesKnown(<String>{});
      DartType('Set<String>').checkTypesKnown(<String>{});
      DartType('Map<String, MyType>').checkTypesKnown(<String>{'MyType'});
      DartType('Map<MyType2, MyType>')
          .checkTypesKnown(<String>{'MyType', 'MyType2'});
      expect(
          () => DartType('List<Unknown>').checkTypesKnown(<String>{'MyType'}),
          throwsA(isA<Exception>()));
      expect(
          () => DartType('SpecialType<MyType>')
              .checkTypesKnown(<String>{'MyType'}),
          throwsA(isA<Exception>()));
    });
    test('Non generic to string', () {
      expect(DartType('int').toString(), 'int');
      expect(DartType('String').toString(), 'String');
      expect(DartType('MyType').toString(), 'MyType');
    });
    test('Generic to string', () {
      expect(DartType('List<int>').toString(), 'List<int>');
      expect(DartType('Set<String>').toString(), 'Set<String>');
      expect(DartType('Map<MyType, String>').toString(), 'Map<MyType, String>');
    });
    test('Generics leaves', () {
      expect(DartType('List<int>').leaves.toList(), ['int']);
      expect(DartType('Set<String>').leaves.toList(), ['String']);
      expect(DartType('Map<MyType, String>').leaves.toList(),
          ['MyType', 'String']);
    });
    test('Nested Generics leaves', () {
      expect(DartType('Map<MyType, List<MyOtherType>>').leaves.toList(),
          ['MyType', 'MyOtherType']);
    });
  });
}
