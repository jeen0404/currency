
class HistoryModel{
  final int id;
  final String username;
  final String fromCurrency;
  final String toCurrency;
  final double fromValue;
  final double toValue;
  final double exchangeRate;

  HistoryModel(this.id,this.username, this.fromCurrency, this.toCurrency, this.fromValue, this.toValue, this.exchangeRate);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'from_currency': fromCurrency,
      'to_currency': toCurrency,
      'from_value': fromValue,
      'to_value': toValue,
      'exchange_rate': exchangeRate,
    };
  }
}