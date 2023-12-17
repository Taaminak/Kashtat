import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: index.isEven ? ColorManager.mainlyBlueColor.withOpacity(0.7) : ColorManager.mainlyBlueColor.withOpacity(0.2),
          ),
        );
      },
    );
  }
}
