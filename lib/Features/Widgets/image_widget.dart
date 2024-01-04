import 'package:flutter/material.dart';

class AssetImageWidget extends StatelessWidget {
  final String imgPath;
  final double width;
  final double height;
  final BoxFit? fit;
  final Color? color = Colors.transparent;
  const AssetImageWidget({
    super.key,
    required this.imgPath,
    required this.width,
    required this.height,
    this.fit = BoxFit.contain,
    color,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imgPath,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
    );
  }
}
