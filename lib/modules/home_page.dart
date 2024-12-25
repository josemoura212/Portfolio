import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:portfolio/modules/widgets/background_widget.dart';
import 'package:portfolio/modules/widgets/clock_widget.dart';
import 'package:reorderable_grid/reorderable_grid.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'package:portfolio/core/helpers/custom_fab_location.dart';
import 'package:portfolio/core/helpers/messages.dart';
import 'package:portfolio/modules/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MessageViewMixin {
  final controller = Injector.get<HomeController>();

  final _scrollController = ScrollController();

  @override
  void initState() {
    messageListener(controller);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Watch(
        (_) => BackgroundImageWidget(
          child: Column(
            children: [
              Flexible(
                child: Watch(
                  (_) => ReorderableGridView.extent(
                    childAspectRatio: 1,
                    maxCrossAxisExtent: size.width / 14,
                    onReorder: controller.onReorderCallback,
                    children: controller.generatedChildren,
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
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 62),
                    Spacer(),
                    ClockWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButtonLocation: CustomFABLocation(),
      floatingActionButton: SizedBox(
        width: 90,
        height: 90,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.transparent,
          mouseCursor: SystemMouseCursors.click,
          foregroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const CircleAvatar(
            backgroundImage: AssetImage("assets/icons/windows.png"),
            radius: 50,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
