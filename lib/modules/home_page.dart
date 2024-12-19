import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();

  var _items = <String>[
    "MangaTrix",
    "Recibo Online",
    "Dashboard",
    "Perfil",
    "Certificados",
  ];

  @override
  Widget build(BuildContext context) {
    final generatedChildren = List.generate(
      _items.length,
      (index) => Container(
        key: Key(_items.elementAt(index)),
        color: Colors.lightBlue,
        child: Text(
          _items.elementAt(index),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: ReorderableBuilder(
        scrollController: _scrollController,
        onReorder: (ReorderedListFunction reorderedListFunction) {
          setState(() {
            _items = reorderedListFunction(_items) as List<String>;
          });
        },
        children: generatedChildren,
        builder: (children) {
          return GridView(
            key: _gridViewKey,
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 8,
            ),
            children: children,
          );
        },
      ),
    );
  }
}
