import 'package:flutter/material.dart';
import 'package:portfolio/models/type_model.dart';

class IconModel {
  final TypeModel type;
  final String name;
  final String icon;
  final String url;
  final Offset position;
  final Size? size;
  final OverlayEntry? overlayEntry;
  final bool showDetail;
  final bool showMenu;

  IconModel({
    required this.type,
    this.position = Offset.zero,
    this.size,
    this.overlayEntry,
    this.showDetail = false,
    this.showMenu = false,
  })  : name = type.name,
        icon = type.icon,
        url = type.url;
}
