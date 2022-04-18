import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rns_flutter_task/views/coins_details/coins_details.dart';
import 'package:rns_flutter_task/views/crypto_coins/coin_listing.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case CoinListingView.routeName:
      return MaterialPageRoute(builder: (context) => const CoinListingView());
    // case CoinsDetailsView.routeName:
    //   return MaterialPageRoute(builder: (context) => const CoinsDetailsView());

    default:
      return errorRoute();
  }
}

Route<dynamic> errorRoute() {
  return MaterialPageRoute(
    builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Arggg!'),
        ),
        body: const Center(
          child: Text('Oh No! You should not be here! '),
        ),
      );
    },
  );
}
