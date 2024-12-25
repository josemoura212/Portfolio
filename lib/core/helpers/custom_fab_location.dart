import 'package:flutter/material.dart';

class CustomFABLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double x = scaffoldGeometry.scaffoldSize.width -
        scaffoldGeometry.scaffoldSize.width +
        15; // Posição horizontal
    final double y =
        scaffoldGeometry.scaffoldSize.height - 85; // Posição vertical
    return Offset(x, y);
  }
}
