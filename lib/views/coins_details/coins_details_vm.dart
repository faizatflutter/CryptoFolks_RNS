import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rns_flutter_task/data/base/base_vm.dart';
import 'package:rns_flutter_task/data/models/coin_model.dart';
import 'package:rns_flutter_task/data/repo/crypto_coins/coins_repo_imp.dart';
import 'package:rns_flutter_task/views/crypto_coins/coins_listing_vm.dart';

class CoinsDetailsVm extends BaseVm {
  CoinModel _coinDetail = CoinModel();

  get coinDetail => _coinDetail;

  addDataToCoinDetail(CoinModel coinModel) async {
    _coinDetail = coinModel;
    notifyListeners();
  }

  incrementCartFromCoinDetail(BuildContext context, int index, int amountInCart) {
    // _coinDetail.amountInCart = _coinDetail.amountInCart! + 1;
    Provider.of<CoinsListingVm>(context, listen: false).updateCartAmountInList(amountInCart, index);
    notifyListeners();
  }

  decrementCartFromCoinDetail(BuildContext context, int index, int amountInCart) {
    // _coinDetail.amountInCart = _coinDetail.amountInCart = 1;
    Provider.of<CoinsListingVm>(context, listen: false).updateCartAmountInList(amountInCart, index);
    notifyListeners();
  }
}
