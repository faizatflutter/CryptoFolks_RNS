import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rns_flutter_task/data/base/base_vm.dart';
import 'package:rns_flutter_task/data/models/coin_model.dart';
import 'package:rns_flutter_task/data/repo/crypto_coins/coins_repo_imp.dart';

class CoinsListingVm extends BaseVm {
  List<CoinModel> _coinsList = [];

  get coinsList => _coinsList;

  sortListBySymbol() {
    EasyLoading.show();
    _coinsList.sort((a, b) => a.symbol!.compareTo(b.symbol!));
    EasyLoading.dismiss();
    notifyListeners();
  }

  sortListByLastPrice() {
    EasyLoading.show();
    _coinsList.sort((a, b) => a.lastPrice!.compareTo(b.lastPrice!));
    EasyLoading.dismiss();
    notifyListeners();
  }

  addDataToCoinsList() async {
    CryptoRepoImp coinsRepo = CryptoRepoImp();
    _coinsList = await coinsRepo.getCoinsDataFromApi();

    notifyListeners();
  }

  updateCartAmountInList(int amountInCart, int index) {
    _coinsList[index].amount = amountInCart;
    notifyListeners();
  }
}
