class OrderModel {
  String? symbol;
  String? trader;
  int? amount;

  OrderModel({this.symbol, this.trader, this.amount});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['trader'] = trader;
    data['amount'] = amount;
    return data;
  }
}
