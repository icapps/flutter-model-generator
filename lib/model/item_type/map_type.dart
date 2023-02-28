import 'item_type.dart';

class MapType extends ItemType {
  final String valueName;

  const MapType({required String key, required this.valueName}) : super(key);
}
