import 'item_type.dart';

class DateTimeType extends ItemType {
  DateTimeType()
      : super(
          'DateTime',
          driftColumn: 'DateTimeColumn',
          driftType: 'dateTime',
        );
}
