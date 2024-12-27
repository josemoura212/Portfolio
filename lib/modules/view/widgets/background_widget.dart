import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:portfolio/modules/core/home_controller.dart';

class BackgroundImageWidget extends StatelessWidget {
  const BackgroundImageWidget({
    super.key,
    this.child,
  });
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final controller = Injector.get<HomeController>();
    return StreamBuilder<String>(
      stream: Stream.periodic(
        const Duration(minutes: 1),
        (_) => "",
      ),
      builder: (context, snapshot) {
        final list = controller.backgroundItems;
        final image = list[(Random().nextInt(list.length))];
        return GestureDetector(
          onTap: () {
            controller.removeOverlayDetail();
            controller.removeType();
          },
          onSecondaryTap: () {
            controller.removeOverlayDetail();
            controller.removeType();
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background/$image"),
                // image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
