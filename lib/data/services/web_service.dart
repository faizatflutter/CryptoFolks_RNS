import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rns_flutter_task/constants/app_constants.dart';
import 'package:rns_flutter_task/data/models/coin_model.dart';
import 'package:rns_flutter_task/data/models/order_model.dart';
import 'package:rns_flutter_task/utilities/connectivity_utilities.dart';

class WebService {
  static Future<List<CoinModel>> fetchCoinsDetailsFromApis() async {
    if (await ConnectivityUtilities.checkInternetConnectivity() == true) {
      final responseFromWazirX = await http.get(Uri.parse(AppConstants.wazirxBaseUrl));
      final responseFromBinance = await http.get(Uri.parse(AppConstants.binanceBaseUrl));
      if (responseFromWazirX.statusCode == 200 || responseFromBinance.statusCode == 200) {
        final Iterable wazirXIterable = jsonDecode(responseFromWazirX.body.toString());
        final Iterable binanceIterable = jsonDecode(responseFromBinance.body.toString());
        List<CoinModel> coinListFromWazirX = wazirXIterable.map((coin) => CoinModel.fromJsonWazirX(coin)).toList();
        List<CoinModel> coinListFromBinance = binanceIterable.map((coin) => CoinModel.fromJsonBinance(coin)).toList();
        List<CoinModel> allCoinsList = [];

        allCoinsList.addAll(coinListFromWazirX);
        allCoinsList.addAll(coinListFromBinance);

        return allCoinsList;
      } else {
        throw Exception("Unable to perform request!");
      }
    } else {
      EasyLoading.showToast("Please Check Your Internet Connection!");
      return [];
    }
  }

  static Future postCoinsData(List<CoinModel> coinModel) async {
    try {
      List<Map<String, dynamic>> list = [];
      for (var element in coinModel) {
        list.add(OrderModel(symbol: element.symbol, trader: element.trader, amount: element.amount).toJson());
      }
      print('Lisy : $list');
      final uri = Uri.parse("https://httpbin.org/post");
      final headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> body = {
        "orders": list
        // [
        //   {"symbol": coinModel[0].symbol, "trader": coinModel[0].traderName, "amount": coinModel[0].amountInCart}
        // ]
      };

      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      Response response = await post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );

      int statusCode = response.statusCode;
      print('resp Status Code: $statusCode');

      if (statusCode == 200) {
        String responseBody = response.body;
        print('resp : $responseBody');
        if (response != null) {
          return response;
        }
      } else {
        EasyLoading.isShow ? EasyLoading.dismiss() : null;
      }
    } catch (e) {
      print('This is an error while posting: $e');
      EasyLoading.isShow ? EasyLoading.dismiss() : null;
    }
  }
}
