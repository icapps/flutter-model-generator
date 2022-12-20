import 'item_type.dart';

class IntegerType extends ItemType {
  IntegerType()
      : super(
          'int',
          driftColumn: 'IntColumn',
          driftType: 'integer',
        );
}
