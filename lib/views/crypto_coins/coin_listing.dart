import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rns_flutter_task/configurations/size_config.dart';
import 'package:rns_flutter_task/constants/app_colors.dart';
import 'package:rns_flutter_task/constants/app_strings.dart';
import 'package:rns_flutter_task/custom_widgets/custom_list_tile.dart';
import 'package:rns_flutter_task/data/models/coin_model.dart';
import 'package:rns_flutter_task/utilities/connectivity_utilities.dart';
import 'package:rns_flutter_task/views/coins_details/coins_details.dart';
import 'package:rns_flutter_task/views/coins_details/coins_details_vm.dart';
import 'package:rns_flutter_task/views/crypto_coins/coins_listing_vm.dart';

class CoinListingView extends StatefulWidget {
  const CoinListingView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  _CoinListingViewState createState() => _CoinListingViewState();
}

class _CoinListingViewState extends State<CoinListingView> {
  @override
  void initState() {
    checkInternetConnection();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getDataFromApi();
    });
    super.initState();
  }

  bool internetStatus = false;

  checkInternetConnection() async {
    await ConnectivityUtilities.checkInternetConnectivity().then((value) => {internetStatus = value!});
  }

  getDataFromApi() async {
    await Provider.of<CoinsListingVm>(context, listen: false).addDataToCoinsList();
  }

  Widget getInternetUnAvailableStamp() {
    return Center(
      child: Text("Please Check Your Internet Connection!",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.kTextColorGrey,
            fontSize: SizeConfig.defaultSize! * 2.5,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var coinVm = Provider.of<CoinsListingVm>(context, listen: false);
    SizeConfig().init(context);
    return Consumer<CoinsListingVm>(builder: (context, coinVm, _) {
      return Scaffold(
        appBar: AppBar(
          // backgroundColor: AppColors.appPrimaryBlueColor,
          elevation: 0.0,
          leading: null,
          title: Text(
            AppStrings.appTitle,
            style: TextStyle(
              color: AppColors.kWhiteColor,
              fontSize: SizeConfig.screenHeight! * 0.03,
              // fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                switch (value) {
                  case "sortBySymbol":
                    print('sortBySymbol');
                    coinVm.sortListBySymbol();
                    break;
                  case "sortByLastPrice":
                    print('sortByLastPrice');
                    coinVm.sortListByLastPrice();
                    break;
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  child: Text('Sort List By Symbol'),
                  value: 'sortBySymbol',
                ),
                const PopupMenuItem(
                  child: Text('Sort List By Last Price'),
                  value: 'sortByLastPrice',
                ),
              ],
            )
          ],
        ),
        body: internetStatus
            ? Container(
                color: AppColors.kSecondaryTextColor.withOpacity(0.3),
                height: SizeConfig.screenHeight,
                padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.02),
                child: coinVm.coinsList.length == 0
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
                        itemCount: coinVm.coinsList.length,
                        itemBuilder: (context, index) {
                          CoinModel coin = coinVm.coinsList[index];
                          return CoinListTile(
                            coinModel: coin,
                            onTilePressed: () {
                              // onTilePressed(filesQueueProvider.filesQueueList[index]);
                              // Navigator.pushNamed(
                              //   context,
                              //   CoinsDetailsView.routeName,
                              // );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CoinsDetailsView(
                                          coinModel: coin,
                                          index: index,
                                        )),
                              );
                            },
                          );
                        }))
            : getInternetUnAvailableStamp(),
      );
    });
  }
}
