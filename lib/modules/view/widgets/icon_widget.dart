import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'package:portfolio/models/type_model.dart';
import 'package:portfolio/modules/core/home_controller.dart';
import 'package:portfolio/modules/view/widgets/certificate_widget.dart';
import 'package:portfolio/modules/view/widgets/web_view_widget.dart';
import 'package:signals_flutter/signals_flutter.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
    required this.type,
  });
  final TypeModel type;

  @override
  Widget build(BuildContext context) {
    final controller = Injector.get<HomeController>();

    final url = type.url;
    final name = type.toString();
    final icon = type.icon;

    return GestureDetector(
      onPanUpdate: (details) =>
          controller.updatePosition(details.globalPosition, type),
      onSecondaryTapDown: (details) {
        showDetail(controller, details, context);
      },
      onDoubleTap: () {
        showWindow(context, controller, url);
      },
      onTap: () {
        controller.setType(type);
      },
      child: Watch(
        (_) => Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
                  controller.type == type ? Colors.white54 : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage(icon),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 0),
                      blurRadius: 3.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showWindow(
    BuildContext context,
    HomeController controller,
    String url,
  ) {
    if (type == TypeModel.github) {
      controller.launchUrlNew(url);
      return;
    }
    final size = MediaQuery.of(context).size;
    controller.setType(type);
    controller.overlayEntryMenu = OverlayEntry(
      builder: (context) => Watch(
        (_) => Positioned(
          key: Key("Certificate"),
          top: controller.offsetWindow.dy,
          left: controller.offsetWindow.dx,
          width: size.width,
          height: size.height * .89,
          child: GestureDetector(
            onPanUpdate: (details) {
              controller.setOffsetWindow(details.globalPosition);
              controller.getOverlayEntryMenu?.markNeedsBuild();
            },
            child: url != ""
                ? WebViewWidget(url: url, type: type)
                : CertificateWidget(),
          ),
        ),
      ),
    );
    controller.setShowCertificate();
    Overlay.of(context).insert(controller.getOverlayEntryMenu!);
  }

  void showDetail(
      HomeController controller, TapDownDetails details, BuildContext context) {
    if (controller.overlayDetail) {
      controller.removeOverlayDetail();
    }
    controller.setType(type);
    Offset offset = details.globalPosition;
    offset = Offset(
      offset.dx,
      offset.dy - 200,
    );
    controller.overlayEntryDetail = OverlayEntry(
      builder: (context) => Watch(
        (_) => Positioned(
          key: UniqueKey(),
          top: offset.dy,
          left: offset.dx,
          width: 200,
          height: 200,
          child: Material(
            child: Container(
              width: 200,
              height: 200,
              color: Colors.white,
              child: Column(
                children: [
                  AppBar(
                    toolbarHeight: 40,
                    title: Text(type.toString()),
                    automaticallyImplyLeading: false,
                    actions: [
                      IconButton(
                        onPressed: () {
                          controller.removeOverlayDetail();
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text(
                      "Abrir",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      controller.removeOverlayDetail();
                      showWindow(context, controller, type.url);
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Abrir em nova aba",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      controller.removeOverlayDetail();
                      controller.launchUrlNew(type.url);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(controller.getOverlayEntryDetail!);
  }
}
