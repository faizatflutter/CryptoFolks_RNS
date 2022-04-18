import 'package:rns_flutter_task/data/base/base_repo.dart';
import 'package:rns_flutter_task/data/models/coin_model.dart';

abstract class CryptoRepo extends BaseRepo {

Future<List<CoinModel>>getCoinsDataFromApi();
Future postCoinsDataToApi(List<CoinModel> coinModel);
}
