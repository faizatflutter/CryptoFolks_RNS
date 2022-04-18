import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:rns_flutter_task/configurations/size_config.dart';
import 'package:rns_flutter_task/constants/app_colors.dart';
import 'package:rns_flutter_task/constants/app_strings.dart';
import 'package:rns_flutter_task/custom_widgets/custom_button.dart';
import 'package:rns_flutter_task/custom_widgets/custom_list_tile.dart';
import 'package:rns_flutter_task/data/models/coin_model.dart';
import 'package:rns_flutter_task/utilities/connectivity_utilities.dart';
import 'package:rns_flutter_task/views/cart/cart_vm.dart';
import 'package:rns_flutter_task/views/crypto_coins/coin_listing.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var cartVm = Provider.of<CoinsListingVm>(context, listen: false);
    SizeConfig().init(context);
    return Consumer<CartVm>(builder: (context, cartVm, _) {
      return Scaffold(
        appBar: AppBar(
          // backgroundColor: AppColors.appPrimaryBlueColor,
          elevation: 0.0,
          leading: null,
          title: Text(
            AppStrings.cart,
            style: TextStyle(
              color: AppColors.kWhiteColor,
              fontSize: SizeConfig.screenHeight! * 0.03,
              // fontWeight: FontWeight.w600,
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.1),
          child: CustomButton(
            onPressed: () async {
              await ConnectivityUtilities.checkInternetConnectivity().then((value) async => {
                    if (value == true)
                      {
                        EasyLoading.show(),
                        await cartVm.placeOrderForCoins().then((value) => {
                              cartVm.clearCart(),
                              EasyLoading.dismiss(),
                              EasyLoading.showToast('Order Placed Successfully!!'),
                              Navigator.pop(context),
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const CoinListingView()),
                              ),
                            }),
                      }
                    else
                      {EasyLoading.showToast("Please Check Your Internet Connection!")}
                  });
            },
            buttonText: "PlaceOrder",
          ),
        ),
        body: Container(
            color: AppColors.kSecondaryTextColor.withOpacity(0.3),
            height: SizeConfig.screenHeight,
            padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.02),
            child: cartVm.cartList.length == 0
                ? Center(
                    child: Text("Please Wait..",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.kTextColorGrey,
                          fontSize: SizeConfig.defaultSize! * 2.5,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        )),
                  )
                : ListView.builder(
                    itemCount: cartVm.cartList.length,
                    itemBuilder: (context, index) {
                      CoinModel coin = cartVm.cartList[index];
                      return CoinListTile(
                        coinModel: coin,
                        onTilePressed: () {},
                      );
                    })),
      );
    });
  }
}
