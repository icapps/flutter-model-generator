import 'item_type.dart';

class StringType extends ItemType {
  StringType()
      : super(
          'String',
          driftColumn: 'TextColumn',
          driftType: 'text',
        );
}
