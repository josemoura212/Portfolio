import 'package:flutter/material.dart';
import 'package:portfolio/core/helpers/messages.dart';
import 'package:portfolio/core/local_storage/local_storage.dart';
import 'package:portfolio/modules/widgets/certificate_widget.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController with MessageStateMixin {
  HomeController({required LocalStorage localStorage})
      : _localStorage = localStorage {
    _init();
  }
  final LocalStorage _localStorage;

  late OverlayEntry _overlayEntry;

  final Signal<Offset> _offset = Signal<Offset>(Offset.zero);
  final Signal<List<String>> _items = Signal<List<String>>([]);
  final Signal<List<Widget>> _generatedChildren = Signal<List<Widget>>([]);
  final Signal<bool> _showCertificate = Signal<bool>(false);
  final Signal<Size> _size = Signal<Size>(Size.zero);

  Future<void> _launchUrl(String url) async {
    final Uri url0 = Uri.parse(url);
    if (!await launchUrl(url0)) {
      throw Exception('Could not launch $url');
    }
  }

  void _showOverlay(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _size.set(Size(size.width, size.height * .9), force: true);
    _overlayEntry = OverlayEntry(
      builder: (context) => Watch(
        (_) => Positioned(
          key: Key("Certificate"),
          top: _offset.value.dy,
          left: _offset.value.dx,
          width: _size.value.width,
          height: _size.value.height,
          child: GestureDetector(
            onPanUpdate: (details) {
              _offset.set(details.globalPosition, force: true);
              _overlayEntry.markNeedsBuild();
            },
            child: CertificateWidget(
              overlayEntry: _overlayEntry,
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry);
    setShowCertificate();
  }

  void generateChildrens(BuildContext context) {
    _generatedChildren.set(
        _items.value
            .map(
              (e) => e.contains("key")
                  ? Container(
                      key: UniqueKey(),
                    )
                  : InkWell(
                      key: UniqueKey(),
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
                            _showOverlay(context);
                            // showWindow(
                            //   (overlay) =>
                            //       CertificateWidget(overlayEntry: overlay),
                            // );
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
  bool get showCertificate => _showCertificate.value;
  Size get size => _size.value;

  void setShowCertificate() {
    _showCertificate.set(!_showCertificate.value, force: true);
  }

  void minimizer() {
    _offset.set(Offset(1000, 1000), force: true);
  }

  void maximizer() {
    _offset.set(Offset(0, 0), force: true);
  }

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

  Future<void> _init() async {
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
}
