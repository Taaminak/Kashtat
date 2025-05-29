import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/translations/locale_keys.g.dart';

import '../../Core/constants/ColorManager.dart';
import '../../Core/constants/FontManager.dart';
import '../../Core/constants/ImageManager.dart';
import '../../Core/constants/RoutesManager.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
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
              child: Container(
                // color: ColorManager.whiteColor,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: MediaQuery.of(context).viewPadding.top + 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(height: 20),
                      Image.asset(
                        ImageManager.logoWithTitleHColored,
                        width: 150,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        LocaleKeys.my_cards.tr(),
                        style: TextStyle(
                          fontSize: FontSize.s34,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorManager.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorManager.whiteColor,
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.2))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        LocaleKeys.card_number_masked.tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeightManager.bold,
                                            fontSize: FontSize.s16),
                                      ),
                                      const SizedBox(width: 20),
                                      Image.asset(ImageManager.masterCard,
                                          width: 30),
                                      const Spacer(),
                                      const FaIcon(
                                        FontAwesomeIcons.ellipsisV,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                  width: size.width,
                                  child: ElevatedButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xff482383),
                                    ),
                                    onPressed: () {
                                      context.push(ScreenName.addCard);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                          '+ ${LocaleKeys.add_new_card.tr()}'),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
