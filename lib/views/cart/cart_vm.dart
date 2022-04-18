import 'package:rns_flutter_task/data/base/base_vm.dart';
import 'package:rns_flutter_task/data/models/coin_model.dart';
import 'package:rns_flutter_task/data/repo/crypto_coins/coins_repo_imp.dart';

class CartVm extends BaseVm {
  List<CoinModel> _cartList = [];

  get cartList => _cartList;

  clearCart() {
    _cartList.clear();
  }

  addDataToCartList(CoinModel coinModel) async {
    if (isCoinPresent(coinModel)) {
      addQuantityInCart(coinModel);
    } else {
      _cartList.add(coinModel);
    }
    notifyListeners();
  }

  removeDataToCartList(CoinModel coinModel) async {
    if (isCoinPresent(coinModel)) {
      removeQuantityInCart(coinModel);
    } else {
      // _cartList.add(coinModel);
    }
    notifyListeners();
  }

  addQuantityInCart(CoinModel coinModel) {
    for (var element in _cartList) {
      if (element.symbol == coinModel.symbol) {
        element.amount = element.amount! + 1;
        break;
      }
    }
  }

  removeQuantityInCart(CoinModel coinModel) {
    for (var element in _cartList) {
      if (element.symbol == coinModel.symbol) {
        element.amount = element.amount! - 1;
        break;
      }
    }
  }

  bool isCoinPresent(CoinModel coinModel) {
    for (var element in _cartList) {
      if (element.symbol == coinModel.symbol) {
        return true;
      }
    }
    return false;
  }

  Future placeOrderForCoins() async {
    CryptoRepoImp coinsRepo = CryptoRepoImp();
    await coinsRepo.postCoinsDataToApi(_cartList);
  }
}
