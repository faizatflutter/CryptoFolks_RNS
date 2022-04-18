import 'package:flutter/material.dart';
import 'package:rns_flutter_task/configurations/size_config.dart';
import 'package:rns_flutter_task/constants/app_colors.dart';
import 'package:rns_flutter_task/data/models/coin_model.dart';

class CoinListTile extends StatelessWidget {
  final Function() onTilePressed;
  final CoinModel coinModel;

  const CoinListTile({required this.onTilePressed, required this.coinModel});

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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      height: SizeConfig.defaultSize! * 10,
      margin: EdgeInsets.all(SizeConfig.defaultSize! * 0.8),
      decoration: getContainerDecoration(),
      child: Center(
        child: ListTile(
            // horizontalTitleGap: 3,
            onTap: () {
              onTilePressed();
            },
            leading: SizedBox(
              // color: Colors.red,
              width: SizeConfig.defaultSize! * 5,
              child: CircleAvatar(
                backgroundColor: AppColors.appPrimaryBlueColor,
                child: Text(
                  coinModel.symbol![0].toUpperCase(),
                  style: TextStyle(fontSize: SizeConfig.screenHeight! * 0.03, color: AppColors.kWhiteColor),
                ),
              ),
              // child:
            ),
            title: Text(
              'Last Price: ${coinModel.lastPrice!}',
              style: TextStyle(
                fontFamily: "Poppins",
                color: AppColors.kTextColorGrey,
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.defaultSize! * 2,
              ),
            ),
            trailing: Text(
              'Cart: ${coinModel.amount!}',
              style: TextStyle(
                fontFamily: "Poppins",
                color: AppColors.kTextColorGrey,
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.defaultSize! * 1.8,
              ),
            ),
            subtitle: SizedBox(
              width: SizeConfig.screenWidth! * 0.4,
              child: Row(
                children: [
                  Text(
                    '${coinModel.symbol!}',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: AppColors.kTextColorGrey,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.defaultSize! * 1.5,
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth! * 0.02,
                  ),
                  Text(
                    '${coinModel.trader!}',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: AppColors.kTextColorGrey,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.defaultSize! * 1.8,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
