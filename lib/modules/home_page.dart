import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:portfolio/core/helpers/messages.dart';
import 'package:portfolio/modules/home_controller.dart';
import 'package:reorderable_grid/reorderable_grid.dart';
import 'package:signals_flutter/signals_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MessageViewMixin {
  final controller = Injector.get<HomeController>();

  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();

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
      body: Column(
        children: [
          Flexible(
            child: Watch(
              (_) => ReorderableGridView.extent(
                key: _gridViewKey,
                childAspectRatio: 1,
                maxCrossAxisExtent: size.width / 14,
                onReorder: controller.onReorderCallback,
                children: controller.generatedChildren,
              ),
            ),
          ),
          Container(
            color: Colors.green,
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [SizedBox(height: 62)],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Align(
          alignment: Alignment.bottomLeft,
          widthFactor: 45,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.transparent,
            mouseCursor: SystemMouseCursors.click,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 45,
            ),
          ),
        ),
      ),
    );
  }
}
