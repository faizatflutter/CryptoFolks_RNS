import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rns_flutter_task/configurations/size_config.dart';
import 'package:rns_flutter_task/constants/app_colors.dart';
import 'package:rns_flutter_task/constants/app_strings.dart';
import 'package:rns_flutter_task/custom_widgets/custom_button.dart';
import 'package:rns_flutter_task/data/models/coin_model.dart';
import 'package:rns_flutter_task/views/cart/cart_view.dart';
import 'package:rns_flutter_task/views/cart/cart_vm.dart';
import 'package:rns_flutter_task/views/coins_details/coins_details_vm.dart';

class CoinsDetailsView extends StatefulWidget {
  static const routeName = 'coin_details';

  final int index;
  final CoinModel coinModel;

  const CoinsDetailsView({required this.coinModel, required this.index});

  @override
  State<CoinsDetailsView> createState() => _CoinsDetailsViewState();
}

class _CoinsDetailsViewState extends State<CoinsDetailsView> {
  BoxDecoration getContainerDecoration() {
    return BoxDecoration(
        color: AppColors.kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(10)));
  }

  Widget buildText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: "Poppins",
          color: AppColors.kTextColorGrey,
          fontWeight: FontWeight.w500,
          fontSize: SizeConfig.defaultSize! * 2,
        ),
      ),
    );
  }

  Widget buildCartRow(String text, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Cart",
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: AppColors.kTextColorGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.defaultSize! * 2,
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  _incrementCart(context);
                },
                icon: const Icon(Icons.add)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: AppColors.kTextColorGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.defaultSize! * 2,
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  _decrementCart(context);
                },
                icon: const Icon(Icons.remove))
          ],
        ));
  }

  _incrementCart(BuildContext context) {
    widget.coinModel.amount = widget.coinModel.amount! + 1;

    Provider.of<CoinsDetailsVm>(context, listen: false)
        .incrementCartFromCoinDetail(context, widget.index, widget.coinModel.amount!);

    Provider.of<CartVm>(context, listen: false).addDataToCartList(widget.coinModel);
    setState(() {});
  }

  _decrementCart(BuildContext context) {
    if (widget.coinModel.amount == 0) {
    } else {
      widget.coinModel.amount = widget.coinModel.amount! - 1;

      Provider.of<CoinsDetailsVm>(context, listen: false)
          .decrementCartFromCoinDetail(context, widget.index, widget.coinModel.amount!);

      Provider.of<CartVm>(context, listen: false).removeDataToCartList(widget.coinModel);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppColors.appPrimaryBlueColor,
        elevation: 0.0,
        leading: null,
        title: Text(
          AppStrings.buyCoins,
          style: TextStyle(
            color: AppColors.kWhiteColor,
            fontSize: SizeConfig.screenHeight! * 0.03,
            // fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: SizeConfig.defaultSize! * 30,
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.all(SizeConfig.defaultSize! * 3),
              decoration: getContainerDecoration(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Trader: ${widget.coinModel.trader!}',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: AppColors.kTextColorGrey,
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.defaultSize! * 2.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Symbol: ${widget.coinModel.symbol!}',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: AppColors.kTextColorGrey,
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.defaultSize! * 2,
                      ),
                    ),
                  ),
                  buildText('Last Price: ${widget.coinModel.lastPrice!}'),
                  buildText('Open Price: ${widget.coinModel.openPrice!}'),
                  buildText('Low Price: ${widget.coinModel.lowPrice!}'),
                  buildCartRow('${widget.coinModel.amount!}', context),
                ],
              )),
          SizedBox(
            height: SizeConfig.screenHeight! * 0.1,
          ),
          CustomButton(
            buttonText: "See Cart",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
