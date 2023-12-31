import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:kashtat/Core/models/UnitModel.dart';
import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

extension Capitalize on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension TransformWidget on Widget {
  Transform transformWidget(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(context.locale.languageCode == 'ar' ? 0:math.pi),
      child: this,
    );
  }
}

Future<void> launchURL(String url)async {
  final Uri uri = Uri.parse(url);
  if (kDebugMode) {
    print('URL Launcher: $url');
  }
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $url');
  }
}

Future<void> shareKashtatToAnyApp()async {
  Share.share('You Can Download KASHTAT From https://apps.apple.com/us/app/kashtat/id6461691005', subject: 'KASHTAT');
}


CalculatedPrice calculatePrice(List<String> dates,Price price){
  List<int> allPrices = [int.parse(price.friday??'0'),int.parse(price.saturday??'0'),int.parse(price.thursday??'0'),int.parse(price.others??'0')];

  int total = 0;

  for (var date in dates) {
    String dayOfWeek = DateFormat.EEEE().format(DateTime.parse(date));
    if(dayOfWeek.toLowerCase().contains('fri')){
      total += int.parse(price.friday??'0');
    }else if(dayOfWeek.toLowerCase().contains('satu')){
      total += int.parse(price.saturday??'0');
    }else if(dayOfWeek.toLowerCase().contains('thur')){
      total += int.parse(price.thursday??'0');
    }else{
      total += int.parse(price.others??'0');
    }
  }

  int max =  allPrices.reduce(math.max);
  int min = allPrices.reduce(math.min);
  double average = dates.isEmpty? double.parse(max.toString()):total/dates.length;
  total = dates.isEmpty?0:total;
  return CalculatedPrice(max: double.parse(max.toString()), min: double.parse(min.toString()), total: double.parse(total.toString()),average: average);
}


extension ArabicDateConversion on String {
  String convertToEnglishDate() {
    try {
      DateFormat arabicFormat = DateFormat('yyyy-MM-dd', 'ar');

      DateTime dateTime = arabicFormat.parseLoose(this);

      DateFormat englishFormat = DateFormat('yyyy-MM-dd', 'en_US');

      String englishDate = englishFormat.format(dateTime);

      return englishDate;
    } catch (e) {
      return this;
    }
  }
}