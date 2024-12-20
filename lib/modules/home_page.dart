import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:portfolio/core/helpers/messages.dart';
import 'package:portfolio/modules/home_controller.dart';
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
      body: SizedBox(
        height: size.height * .9,
        child: Watch(
          (_) => ReorderableBuilder(
            scrollController: _scrollController,
            onReorder: controller.onReorder,
            longPressDelay: Duration(milliseconds: 250),
            builder: (children) {
              return GridView(
                key: _gridViewKey,
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 15,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 8,
                ),
                children: children,
              );
            },
            children: controller.generatedChildren,
          ),
        ),
      ),
    );
  }
}
