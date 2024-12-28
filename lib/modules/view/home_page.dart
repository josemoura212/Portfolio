import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:portfolio/models/type_model.dart';
import 'package:portfolio/modules/view/widgets/background_widget.dart';
import 'package:portfolio/modules/view/widgets/clock_widget.dart';
import 'package:portfolio/modules/view/widgets/icon_widget.dart';
import 'package:portfolio/modules/view/widgets/windows_icon_widget.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'package:portfolio/core/helpers/custom_fab_location.dart';
import 'package:portfolio/core/helpers/messages.dart';
import 'package:portfolio/modules/core/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MessageViewMixin {
  final controller = Injector.get<HomeController>();

  @override
  void initState() {
    messageListener(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    controller.addIcon([
      TypeModel.mangatrix,
      TypeModel.recibo,
      TypeModel.dashboard,
      TypeModel.github,
      TypeModel.certificados,
    ], size);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: BackgroundImageWidget(
        child: Column(
          children: [
            Expanded(
              child: Watch(
                (_) => Stack(
                  children: [
                    ...controller.icons.map((e) {
                      return Positioned(
                        top: controller.getPosition(e.type).dy,
                        left: controller.getPosition(e.type).dx,
                        width: 100,
                        height: 100,
                        child: IconWidget(type: e.type),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0, -4),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: Watch(
                (_) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 62,
                      width: 100,
                    ),
                    ...controller.icons.where((e) => e.showMenu).map((e) {
                      return SideBarItem(controller: controller, type: e.type);
                    }),
                    Spacer(),
                    ClockWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButtonLocation: CustomFABLocation(),
      floatingActionButton: WindowsIconWidget(),
    );
  }
}

class SideBarItem extends StatelessWidget {
  const SideBarItem({
    super.key,
    required this.controller,
    required this.type,
  });

  final HomeController controller;
  final TypeModel type;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.maximizer(type);
      },
      child: Container(
        height: 62,
        width: 150,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          child: Image.asset(controller.getIcon(type).icon),
        ),
      ),
    );
  }
}
