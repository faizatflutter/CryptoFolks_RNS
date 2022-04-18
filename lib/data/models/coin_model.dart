class CoinModel {
  String? symbol;
  String? trader;
  String? openPrice;
  String? lowPrice;
  String? lastPrice;
  int? amount;

  CoinModel({
    this.symbol,
    this.trader,
    this.openPrice,
    this.lowPrice,
    this.lastPrice,
    this.amount,
  });

  CoinModel.fromJsonWazirX(Map<String, dynamic> json) {
    symbol = json['symbol'];
    trader = "WazirX";
    openPrice = json['openPrice'];
    lowPrice = json['lowPrice'];
    lastPrice = json['lastPrice'];
    amount = 0;
  }

  CoinModel.fromJsonBinance(Map<String, dynamic> json) {
    symbol = json['symbol'];
    trader = "Binance";
    openPrice = json['openPrice'];
    lowPrice = json['lowPrice'];
    lastPrice = json['lastPrice'];
    amount = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['symbol'] = symbol;
    data['traderName'] = trader;
    data['openPrice'] = openPrice;
    data['lowPrice'] = lowPrice;
    data['lastPrice'] = lastPrice;
    data['lastPrice'] = lastPrice;
    return data;
  }
}
