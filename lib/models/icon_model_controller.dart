import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:portfolio/models/type_model.dart';

class IconModel {
  final TypeModel type;
  final String name;
  final String icon;
  final String url;
  final Offset position;
  final Size? size;
  final OverlayEntry? overlayEntry;
  final Offset overlayPosition;
  final bool showDetail;
  final bool showMenu;

  IconModel({
    required this.type,
    this.position = Offset.zero,
    this.size,
    this.overlayEntry,
    this.overlayPosition = Offset.zero,
    this.showDetail = false,
    this.showMenu = false,
  })  : name = type.name,
        icon = type.icon,
        url = type.url;

  IconModel copyWith({
    TypeModel? type,
    String? name,
    String? icon,
    String? url,
    Offset? position,
    ValueGetter<Size?>? size,
    ValueGetter<OverlayEntry?>? overlayEntry,
    Offset? overlayPosition,
    bool? showDetail,
    bool? showMenu,
  }) {
    return IconModel(
      type: type ?? this.type,
      position: position ?? this.position,
      size: size != null ? size() : this.size,
      overlayEntry: overlayEntry != null ? overlayEntry() : this.overlayEntry,
      overlayPosition: overlayPosition ?? this.overlayPosition,
      showDetail: showDetail ?? this.showDetail,
      showMenu: showMenu ?? this.showMenu,
    );
  }

  @override
  String toString() {
    return '==== IconModel(type: ${type.toString()}, position: $position)';
  }
}
