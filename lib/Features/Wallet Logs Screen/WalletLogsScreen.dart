import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/Cubit/AppState.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/Features/Wallet%20Logs%20Screen/Widgets/WalletItemWidget.dart';
import 'package:kashtat/Features/Widgets/Loader.dart';
import 'package:kashtat/translations/locale_keys.g.dart';

import '../../Core/constants/ColorManager.dart';

class WalletRecordsScreen extends StatefulWidget {
  const WalletRecordsScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<WalletRecordsScreen> createState() => _WalletRecordsScreenState();
}

class _WalletRecordsScreenState extends State<WalletRecordsScreen> {
  @override
  void initState() {
    final cubit = BlocProvider.of<AppBloc>(context);
    cubit.getWalletLogs();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      body: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return state is LoadingWalletState
              ? Center(
                  child: Loader(),
                )
              : SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Image.asset(
                          ImageManager.logoHalfGrey,
                          height: size.height / 2.5,
                        ),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).viewPadding.top +
                                          15),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                    onTap: () {
                                      context.pop();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Image.asset(
                                        ImageManager.backIcon,
                                        width: 10,
                                      ),
                                    )),
                              ),
                              const SizedBox(height: 10),
                              Image.asset(
                                ImageManager.logoWithTitleHColored,
                                width: 150,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                LocaleKeys.wallet_records_title.tr(),
                                style: TextStyle(
                                  fontSize: FontSize.s34,
                                  fontWeight: FontWeightManager.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ContainerDecorated(
                                  content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImageManager.credit,
                                    width: 32,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LocaleKeys.wallet_balance.tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeightManager.bold),
                                      ),
                                      Text(
                                        '${cubit.walletLogs.isEmpty ? 0.0 : cubit.walletLogs.first.user?.wallet ?? 0.0} ${LocaleKeys.riyal.tr()}',
                                        style: TextStyle(
                                            fontWeight: FontWeightManager.bold),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Padding(
                                    padding: EdgeInsets.only(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        for (int i = 0;
                                            i < (cubit.walletLogs.length);
                                            i++)
                                          ContainerDecorated(
                                              content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              FaIcon(
                                                cubit.walletLogs[i].amount! > 0
                                                    ? FontAwesomeIcons
                                                        .plusCircle
                                                    : FontAwesomeIcons
                                                        .minusCircle,
                                                color: cubit.walletLogs[i]
                                                            .amount! >
                                                        0
                                                    ? ColorManager.greenColor
                                                    : Colors.red,
                                                size: 18,
                                              ),
                                              Text(
                                                '${cubit.walletLogs[i].amount} ${LocaleKeys.riyal.tr()}',
                                                style: TextStyle(
                                                  fontWeight:
                                                      FontWeightManager.medium,
                                                  color: cubit.walletLogs[i]
                                                              .amount! >
                                                          0
                                                      ? ColorManager.greenColor
                                                      : Colors.red,
                                                ),
                                              ),
                                              Text(
                                                DateFormat('yMMMMEEEEd').format(
                                                    cubit.walletLogs[i]
                                                            .createdAt ??
                                                        DateTime.now()),
                                                style: TextStyle(
                                                  fontWeight:
                                                      FontWeightManager.medium,
                                                  color: cubit.walletLogs[i]
                                                              .amount! >
                                                          0
                                                      ? ColorManager.greenColor
                                                      : Colors.red,
                                                ),
                                              ),
                                            ],
                                          )),
                                        SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
