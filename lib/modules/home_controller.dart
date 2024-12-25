import 'package:flutter/material.dart';
import 'package:portfolio/core/helpers/messages.dart';
import 'package:portfolio/core/local_storage/local_storage.dart';
import 'package:signals_flutter/signals_flutter.dart';

class HomeController with MessageStateMixin {
  final LocalStorage _localStorage;
  final Signal<List<String>> _items = Signal<List<String>>([]);

  final Signal<List<Widget>> _generatedChildren = Signal<List<Widget>>([]);

  HomeController({required LocalStorage localStorage})
      : _localStorage = localStorage {
    _initialize();
  }

  Future<void> _initialize() async {
    await init();
    _generatedChildren.set(
        _items.value
            .map(
              (e) => Container(
                key: Key(e),
                color: Colors.primaries[
                    (_items.value.indexOf(e) % Colors.primaries.length)],
                child: Center(
                  child: Text(
                    e,
                    style: TextStyle(
                      color:
                          e.contains("key") ? Colors.transparent : Colors.white,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        force: true);
  }

  List<String> get items => _items.value;
  List<Widget> get generatedChildren => _generatedChildren.value;

  void onReorderCallback(int oldIndex, int newIndex) {
    final childs = _generatedChildren.value;
    final items = _items.value;

    final child = childs.removeAt(oldIndex);
    final item = items.removeAt(oldIndex);

    childs.insert(newIndex, child);
    items.insert(newIndex, item);

    save();

    _generatedChildren.set(childs, force: true);
    _items.set(items, force: true);
  }

  Future<void> save() async {
    await _localStorage.writeList("items", _items.value);
  }

  Future<void> init() async {
    final items = await _localStorage.readList("items");
    if (items != null) {
      _items.set(items, force: true);
    } else {
      final items = [
        "MangaTrix",
        "Recibo Online",
        "Dashboard",
        "Perfil",
        "Certificados",
        for (var i = 0; i < 79; i++) "key $i",
      ]..shuffle();
      await _localStorage.writeList("items", items);
      _items.set(items, force: true);
    }
  }
}
