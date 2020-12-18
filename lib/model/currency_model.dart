


class CurrencyModel{
  final String name;
  final double value;
  final String base;
  CurrencyModel(this.name, this.value, this.base);
  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
      'base': base,
    };
  }
}