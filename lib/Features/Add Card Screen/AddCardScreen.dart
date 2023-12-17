import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kashtat/translations/locale_keys.g.dart';
import 'dart:ui' as ui;

import '../../Core/constants/ColorManager.dart';
import '../../Core/constants/FontManager.dart';
import '../../Core/constants/ImageManager.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({Key? key}) : super(key: key);

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {

  TextEditingController holder = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController validThru = TextEditingController();
  TextEditingController cvv = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(left: 0,top: 0,child:  Image.asset(ImageManager.logoHalfGrey,height: size.height/2.5,),),
            Positioned.fill(
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.only(left: 15.0,right: 15.0,top: MediaQuery.of(context).viewPadding.top+15,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                            onTap: (){
                              context.pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset(ImageManager.backIcon,width: 10,),
                            )),
                      ),
                      const SizedBox(height: 20),
                      Image.asset(ImageManager.logoWithTitleHColored,width: 150,),
                      const SizedBox(height: 20),
                      Text(LocaleKeys.my_cards.tr(),style: TextStyle(
                        fontSize: FontSize.s34,
                        fontWeight: FontWeightManager.bold,
                      ),),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorManager.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Directionality(
                            textDirection: ui.TextDirection.ltr,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name on Card',style: TextStyle(
                                    color: ColorManager.darkGreyColor,
                                    fontWeight: FontWeightManager.bold
                                ),),
                                TextField(
                                  cursorColor: ColorManager.orangeColor,
                                  style: TextStyle(
                                      fontWeight: FontWeightManager.bold,
                                      fontFamily: GoogleFonts.lato().fontFamily,
                                      fontSize: FontSize.s14
                                  ),
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: ColorManager.greyColor), //<-- SEE HERE
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: ColorManager.greyColor), //<-- SEE HERE
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: ColorManager.greyColor), //<-- SEE HERE
                                    ),
                                  ),
                                ),
                                const SizedBox(height:40),
                                Text('Card Number',style: TextStyle(
                                    color: ColorManager.darkGreyColor,
                                    fontWeight: FontWeightManager.bold
                                ),),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 16,
                                  cursorColor: ColorManager.orangeColor,
                                  decoration: InputDecoration(
                                    suffixIcon: Image.asset(ImageManager.masterCard,width: 5),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: ColorManager.greyColor), //<-- SEE HERE
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: ColorManager.greyColor), //<-- SEE HERE
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: ColorManager.greyColor), //<-- SEE HERE
                                    ),
                                  ),
                                ),
                                const SizedBox(height:40),
                                Row(
                                  children: [
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Expiry Date',style: TextStyle(
                                            color: ColorManager.darkGreyColor,
                                            fontWeight: FontWeightManager.bold
                                        ),),
                                        TextField(
                                          maxLength: 5,
                                          controller: validThru,
                                          keyboardType: TextInputType.number,
                                          cursorColor: ColorManager.orangeColor,
                                          inputFormatters: [
                                            new CardExpirationFormatter(),
                                          ],
                                          onChanged: (v){
                                          },
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: ColorManager.greyColor), //<-- SEE HERE
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: ColorManager.greyColor), //<-- SEE HERE
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: ColorManager.greyColor), //<-- SEE HERE
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ),

                                    const SizedBox(width:20),
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('CVV',style: TextStyle(
                                            color: ColorManager.darkGreyColor,
                                            fontWeight: FontWeightManager.bold
                                        ),),
                                        TextField(
                                          maxLength: 3,
                                          keyboardType: TextInputType.number,
                                          cursorColor: ColorManager.orangeColor,
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: ColorManager.greyColor), //<-- SEE HERE
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: ColorManager.greyColor), //<-- SEE HERE
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: ColorManager.greyColor), //<-- SEE HERE
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                                const SizedBox(height: 70),
                                SizedBox(
                                    width: size.width,
                                    child: ElevatedButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: const Color(0xff482383),
                                      ),
                                      onPressed: (){
                                        context.pop();
                                      }, child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(LocaleKeys.add.tr()),
                                      ),
                                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}
class CardExpirationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueString = newValue.text;
    String valueToReturn = '';

    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != '/') valueToReturn += newValueString[i];
      var nonZeroIndex = i + 1;
      final contains = valueToReturn.contains(RegExp(r'\/'));
      if (nonZeroIndex % 2 == 0 &&
          nonZeroIndex != newValueString.length &&
          !(contains)) {
        valueToReturn += '/';
      }
    }
    return newValue.copyWith(
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}