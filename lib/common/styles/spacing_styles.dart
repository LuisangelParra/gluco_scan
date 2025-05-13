import 'package:flutter/material.dart';
import 'package:gluco_scan/utils/constants/sizes.dart';

class LSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: LSizes.appBarHeight,
    left: LSizes.defaultSpace,
    bottom: LSizes.defaultSpace,
    right: LSizes.defaultSpace,
  );
}