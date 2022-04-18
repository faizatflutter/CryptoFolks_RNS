import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:rns_flutter_task/views/cart/cart_vm.dart';
import 'package:rns_flutter_task/views/coins_details/coins_details_vm.dart';
import 'package:rns_flutter_task/views/crypto_coins/coin_listing.dart';
import 'package:rns_flutter_task/views/crypto_coins/coins_listing_vm.dart';

import 'data/route/route_setting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CoinsListingVm()),
          ChangeNotifierProvider(create: (_) => CoinsDetailsVm()),
          ChangeNotifierProvider(create: (_) => CartVm()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: CoinListingView.routeName,
          onGenerateRoute: (settings) => generateRoute(settings),
          builder: EasyLoading.init(),
        ));
  }
}
