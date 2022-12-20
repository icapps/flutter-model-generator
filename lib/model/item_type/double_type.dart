import 'item_type.dart';

class DoubleType extends ItemType {
  DoubleType()
      : super(
          'double',
          driftColumn: 'RealColumn',
          driftType: 'real',
        );
}
