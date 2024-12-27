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

    late OverlayEntry overlayEntry;
    final url = type.url;
    final name = type.toString();
    final icon = type.icon;
    final sizeWindow = controller.sizeWidnow;
    final offsetWindow = controller.offsetWindow;

    return GestureDetector(
      onPanUpdate: (details) =>
          controller.updatePosition(details.globalPosition, type),
      onSecondaryTapDown: (details) {
        Offset offset = details.globalPosition;
        offset = Offset(
          offset.dx + 10,
          offset.dy - 100,
        );
        overlayEntry = OverlayEntry(
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
                              overlayEntry.remove();
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
                          overlayEntry.remove();
                          // _showOverlay(context, url: type.url, type: type);
                        },
                      ),
                      ListTile(
                        title: Text(
                          "Abrir em nova aba",
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          overlayEntry.remove();
                          // launchUrlNew(
                          //   type.url
                          // );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        Overlay.of(context).insert(overlayEntry);
      },
      onDoubleTap: () {
        controller.setType(type);
        final size = MediaQuery.of(context).size;
        controller.setSizeWindow(size);
        overlayEntry = OverlayEntry(
          builder: (context) => Watch(
            (_) => Positioned(
              key: Key("Certificate"),
              top: offsetWindow.dy,
              left: offsetWindow.dx,
              width: sizeWindow.width,
              height: sizeWindow.height,
              child: GestureDetector(
                onPanUpdate: (details) {
                  controller.setOffsetWindow(details.globalPosition);
                  overlayEntry.markNeedsBuild();
                },
                child: url != ""
                    ? WebViewWidget(
                        overlayEntry: overlayEntry, url: url, type: type)
                    : CertificateWidget(
                        overlayEntry: overlayEntry,
                      ),
              ),
            ),
          ),
        );

        Overlay.of(context).insert(overlayEntry);
      },
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
    );
  }
}
