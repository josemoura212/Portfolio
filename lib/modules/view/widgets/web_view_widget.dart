import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:portfolio/models/type_model.dart';
import 'package:portfolio/modules/core/home_controller.dart';
import 'package:webview_all/webview_all.dart';

class WebViewWidget extends StatelessWidget {
  const WebViewWidget({super.key, required this.url, required this.type});
  final String url;
  final TypeModel type;

  @override
  Widget build(BuildContext context) {
    final controller = Injector.get<HomeController>();
    return Material(
      elevation: 10.0,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            AppBar(
              title: Text(type.toString()),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () {
                    controller.minimizer(type);
                  },
                  icon: Icon(Icons.minimize),
                ),
                IconButton(
                  onPressed: () {
                    controller.maximizer(type);
                  },
                  icon: Icon(Icons.fullscreen),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    controller.removeOverlayMenu(type);
                  },
                ),
              ],
            ),
            Expanded(
              child: Webview(url: url),
            ),
          ],
        ),
      ),
    );
  }
}
