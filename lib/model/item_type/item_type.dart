abstract class ItemType {
  final String name;
  final String? driftColumn;
  final String? driftType;

  ItemType(
    this.name, {
    this.driftColumn,
    this.driftType,
  });
}
