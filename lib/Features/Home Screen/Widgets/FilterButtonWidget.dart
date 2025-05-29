import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({Key? key, required this.onTap, required this.title})
      : super(key: key);
  final Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.mainlyBlueColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                    color: ColorManager.whiteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: ColorManager.whiteColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
