import 'package:flutter/material.dart';
import 'package:portfolio/core/helpers/messages.dart';
import 'package:portfolio/core/local_storage/local_storage.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController with MessageStateMixin {
  final LocalStorage _localStorage;
  final Signal<List<String>> _items = Signal<List<String>>([]);
  final Signal<List<String>> _backgroundItems = Signal<List<String>>([
    "1.png",
    "2.jpg",
    "3.png",
    "4.png",
    "5.jpg",
    "6.jpg",
    "7.jpg",
    "8.jpg",
    "9.jpg",
    "10.png",
    "11.jpg",
    "12.png",
    "13.jpg",
    "14.jpg",
    "15.png",
    "16.png",
    "17.png",
    "18.png",
    "19.png",
    "20.png",
    "22.jpg",
    "23.jpeg",
    "24.jpeg",
    "25.png",
    "26.jpeg",
    "27.png",
    "28.png",
    "29.png",
    "30.png",
    "31.png",
    "32.png",
    "33.png",
    "34.png",
    "35.png",
    "36.png",
    "37.png",
    "38.png",
    "39.png",
    "40.png",
    "41.png",
    "42.png",
    "43.png",
  ]);

  final Signal<List<Widget>> _generatedChildren = Signal<List<Widget>>([]);

  HomeController({required LocalStorage localStorage})
      : _localStorage = localStorage {
    _initialize();
  }

  Future<void> _launchUrl(String url) async {
    final Uri url0 = Uri.parse(url);
    if (!await launchUrl(url0)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _initialize() async {
    await init();
    _generatedChildren.set(
        _items.value
            .map(
              (e) => e.contains("key")
                  ? Container(
                      key: Key(e),
                    )
                  : InkWell(
                      key: Key(e),
                      onDoubleTap: () async {
                        switch (e) {
                          case "MangaTrix":
                            _launchUrl("https://leitor.mangatrix.net");
                            break;
                          case "Recibo Online":
                            _launchUrl("https://recibo.mangatrix.net");
                            break;
                          case "Dashboard":
                            _launchUrl("https://google.com");
                            break;
                          case "GitHub":
                            _launchUrl("https://github.com/josemoura212");
                            break;
                          case "Certificados":
                            _launchUrl("https://google.com");
                            break;
                        }
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: switch (e) {
                                  "MangaTrix" => DecorationImage(
                                      image: AssetImage(
                                          "assets/icons/mangatrix.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  "Recibo Online" => DecorationImage(
                                      image: AssetImage(
                                          "assets/icons/recibo-online.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  "Dashboard" => DecorationImage(
                                      image: AssetImage(
                                          "assets/icons/dashboard.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  "GitHub" => DecorationImage(
                                      image:
                                          AssetImage("assets/icons/github.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  "Certificados" => DecorationImage(
                                      image: AssetImage(
                                          "assets/icons/certificate.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  _ => null,
                                }),
                          ),
                          Text(
                            e,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
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
                    ),
            )
            .toList(),
        force: true);
  }

  List<String> get items => _items.value;
  List<Widget> get generatedChildren => _generatedChildren.value;
  List<String> get backgroundItems => _backgroundItems.value;

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
        for (var i = 0; i <= 59; i++) "key $i",
        "MangaTrix",
        "Recibo Online",
        "Dashboard",
        "GitHub",
        "Certificados",
        for (var i = 0; i < 19; i++) "key $i",
      ];
      // ]..shuffle();
      await _localStorage.writeList("items", items);
      _items.set(items, force: true);
    }
  }
}
