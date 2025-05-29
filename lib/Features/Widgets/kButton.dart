import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../Core/constants/ColorManager.dart';
import '../../translations/locale_keys.g.dart';

class KButton extends StatefulWidget {
  const KButton(
      {super.key,
      required this.onTap,
      required this.title,
      this.width = 130,
      this.paddingH = 15,
      this.paddingV = 8,
      this.clr = const Color(0xff482383),
      this.txtClr = Colors.white,
      this.icon,
      this.hasBorder = false,
      this.isLoading = false});
  final Function() onTap;
  final String title;
  final double width;
  final double paddingH;
  final double paddingV;
  final Color clr;
  final Color txtClr;
  final IconData? icon;
  final bool hasBorder;
  final bool isLoading;

  @override
  State<KButton> createState() => _KButtonState();
}

class _KButtonState extends State<KButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      // height: widget.height,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(widget.clr),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
          side: MaterialStateProperty.resolveWith<BorderSide>((states) =>
              BorderSide(color: widget.hasBorder ? widget.txtClr : widget.clr)),
        ),
        onPressed: widget.onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: widget.paddingH, vertical: widget.paddingV),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isLoading)
                const SizedBox(
                  height: 10,
                  width: 10,
                  child: SpinKitCircle(
                    color: Colors.white,
                    size: 10.0,
                  ),
                ),
              if (widget.isLoading)
                SizedBox(
                  width: 10,
                ),
              Text(widget.title,
                style: TextStyle(
                  fontSize: FontSize.s12,
                  color: widget.txtClr,
                ),
              ),
              if (widget.icon != null)
                Icon(
                  widget.icon!,
                  color: widget.txtClr,
                  size: 15,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
