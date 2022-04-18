import 'package:rns_flutter_task/data/models/coin_model.dart';
import 'package:rns_flutter_task/data/repo/crypto_coins/coins_repo.dart';
import 'package:rns_flutter_task/data/services/web_service.dart';

class CryptoRepoImp extends CryptoRepo {
  @override
  Future<List<CoinModel>> getCoinsDataFromApi() {
    return WebService.fetchCoinsDetailsFromApis();
    //
    // throw UnimplementedError();
  }

  @override
  Future postCoinsDataToApi(List<CoinModel> coinModel) {
    return WebService.postCoinsData(coinModel);
  }
}
