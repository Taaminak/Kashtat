import 'package:flutter/material.dart';

extension MediaValues on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
    Size get size => MediaQuery.of(this).size;
}
