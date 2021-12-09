import 'package:model_generator/util/language_version.dart';
import 'package:test/test.dart';

void main() {
  group('Language version tests', () {
    test('Test at least', () {
      final version = LanguageVersion(2, 14, 3);

      expect(version.isAtLeast(1), true);
      expect(version.isAtLeast(2), true);
      expect(version.isAtLeast(3), false);
      expect(version.isAtLeast(2, 13), true);
      expect(version.isAtLeast(2, 14), true);
      expect(version.isAtLeast(2, 15), false);
      expect(version.isAtLeast(2, 14, 2), true);
      expect(version.isAtLeast(2, 14, 3), true);
      expect(version.isAtLeast(2, 14, 4), false);
    });
  });
}
