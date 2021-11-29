import 'package:model_generator/util/type_checker.dart';

class DartType {
  final String baseType;
  final List<DartType> generics;

  factory DartType(String type) {
    if (!type.contains('<')) return DartType._(type.trim(), []);

    final start = type.indexOf('<');
    final end = type.lastIndexOf('>');
    final typeArgumentList = type.substring(start + 1, end);
    final name = type.substring(0, start).trim();
    final arguments = _splitByComma(typeArgumentList);

    return DartType._(
        name, arguments.map((e) => DartType(e)).toList(growable: false));
  }

  DartType._(this.baseType, this.generics);

  Iterable<String> get leaves {
    if (generics.isEmpty) return [baseType];
    final leaves = <String>{};
    for (final element in generics) {
      leaves.addAll(element.leaves);
    }
    return leaves;
  }

  void checkTypesKnown(final Set<String> names) {
    if (generics.isEmpty) {
      if (!TypeChecker.isKnownDartType(baseType) && !names.contains(baseType)) {
        throw Exception(
            'Could not generate all models. `$baseType` is not added to the config file');
      }
    } else if (!TypeChecker.isKnownDartCollectionType(baseType)) {
      throw Exception(
          'Could not generate all models. `$baseType` is currently not supported as generic base type');
    } else {
      for (final e in generics) {
        e.checkTypesKnown(names);
      }
    }
  }

  @override
  String toString() {
    if (generics.isEmpty) {
      return baseType;
    }
    final builder = StringBuffer(baseType)..write('<');
    var c = 0;
    for (final element in generics) {
      if (c++ > 0) builder.write(', ');
      builder.write(element.toString());
    }
    builder.write('>');
    return builder.toString();
  }
}

const _openGenericsChar = 0x3C;
const _closeGenericsChar = 0x3E;
const _commaChar = 0x2C;

List<String> _splitByComma(String typeArgumentList) {
  final strings = <String>[];
  final stringBuffer = StringBuffer();
  var level = 0;

  for (var i = 0; i < typeArgumentList.length; ++i) {
    final c = typeArgumentList.codeUnitAt(i);
    if (c == _commaChar && level == 0) {
      strings.add(stringBuffer.toString().trim());
      stringBuffer.clear();
    } else {
      stringBuffer.write(String.fromCharCode(c));
    }

    if (c == _openGenericsChar) {
      level++;
    }
    if (c == _closeGenericsChar) {
      level--;
    }
  }

  strings.add(stringBuffer.toString().trim());
  return strings;
}
