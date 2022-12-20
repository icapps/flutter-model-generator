import 'item_type.dart';

class BooleanType extends ItemType {
  BooleanType()
      : super(
          'bool',
          driftColumn: 'BoolColumn',
          driftType: 'boolean',
        );
}
