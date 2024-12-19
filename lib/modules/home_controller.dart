import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:portfolio/core/helpers/messages.dart';
import 'package:signals_flutter/signals_flutter.dart';

class HomeController with MessageStateMixin {
  final Signal<List<String>> _items = Signal<List<String>>([
    "MangaTrix",
    "Recibo Online",
    "Dashboard",
    "Perfil",
    "Certificados",
  ]);

  final Signal<List<Widget>> _generatedChildren = Signal<List<Widget>>([]);

  HomeController() {
    _generatedChildren.value = _items.value
        .map(
          (e) => Container(
            key: Key(e),
            color: Colors
                .primaries[(_items.value.indexOf(e) % Colors.primaries.length)],
            child: Center(
              child: Text(
                e,
              ),
            ),
          ),
        )
        .toList();
  }

  List<String> get items => _items.value;

  List<Widget> get generatedChildren => _generatedChildren.value;

  void onReorder(ReorderedListFunction reorderedListFunction) {
    _items.value = reorderedListFunction(_items.value) as List<String>;
  }
}
