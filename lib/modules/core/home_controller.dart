import 'package:flutter/material.dart';
import 'package:portfolio/core/helpers/messages.dart';
import 'package:portfolio/core/local_storage/local_storage.dart';
import 'package:portfolio/models/type_model.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController with MessageStateMixin {
  HomeController({
    required LocalStorage localStorage,
  }) : _localStorage = localStorage {
    _init();
  }
  final LocalStorage _localStorage;

  final Signal<Offset> _position1 = Signal<Offset>(Offset.zero);
  final Signal<Offset> _position2 = Signal<Offset>(Offset.zero);
  final Signal<Offset> _position3 = Signal<Offset>(Offset.zero);
  final Signal<Offset> _position4 = Signal<Offset>(Offset.zero);
  final Signal<Offset> _position5 = Signal<Offset>(Offset.zero);
  final Signal<TypeModel> _type = Signal<TypeModel>(TypeModel.certificados);
  final Signal<Size> _sizeWindow = Signal<Size>(Size.zero);
  final Signal<Offset> _offsetWindow = Signal<Offset>(Offset.zero);
  final Signal<bool> _showCertificate = Signal<bool>(false);

  Offset get position1 => _position1.value;
  Offset get position2 => _position2.value;
  Offset get position3 => _position3.value;
  Offset get position4 => _position4.value;
  Offset get position5 => _position5.value;
  Size get sizeWidnow => _sizeWindow.value;
  Offset get offsetWindow => _offsetWindow.value;
  TypeModel get type => _type.value;
  bool get showCertificate => _showCertificate.value;

  double _roundPosition(double position) {
    return (position / 100).round() * 100;
  }

  Future<void> launchUrlNew(String url) async {
    final Uri url0 = Uri.parse(url);
    if (!await launchUrl(url0)) {
      throw Exception('Could not launch $url');
    }
  }

  void updatePosition(DragUpdateDetails details, TypeModel type) {
    Offset offset = details.globalPosition;
    final newOffset = Offset(
      _roundPosition(offset.dx),
      _roundPosition(offset.dy),
    );
    switch (type) {
      case TypeModel.mangatrix:
        _position1.set(newOffset, force: true);
        break;
      case TypeModel.recibo:
        _position2.set(newOffset, force: true);
        break;
      default:
        break;
    }
    save(newOffset, type);
  }

  void setShowCertificate() {
    _showCertificate.set(!_showCertificate.value, force: true);
  }

  void setType(TypeModel type) {
    _type.set(type, force: true);
  }

  void setSizeWindow(Size size) {
    _sizeWindow.set(size, force: true);
  }

  void setOffsetWindow(Offset offset) {
    _offsetWindow.set(offset, force: true);
  }

  void minimizer() {
    _offsetWindow.set(Offset(1000, 1000), force: true);
  }

  void maximizer() {
    _offsetWindow.set(Offset(0, 0), force: true);
  }

  Future<void> save(Offset offset, TypeModel type) async {
    await _localStorage.writeList(type.name, [
      offset.dx.toString(),
      offset.dy.toString(),
    ]);
  }

  Future<void> _init() async {
    final results = await Future.wait([
      _localStorage.readList(TypeModel.mangatrix.name),
      _localStorage.readList(TypeModel.recibo.name),
      _localStorage.readList(TypeModel.dashboard.name),
      _localStorage.readList(TypeModel.github.name),
      _localStorage.readList(TypeModel.certificados.name),
    ]);
    var i = 0;
    for (var result in results) {
      if (result != null) {
        final offset = Offset(
          double.parse(result[0]),
          double.parse(result[1]),
        );
        switch (i) {
          case 0:
            _position1.set(offset, force: true);
            break;
          case 1:
            _position2.set(offset, force: true);
            break;
          case 2:
            _position3.set(offset, force: true);
            break;
          case 3:
            _position4.set(offset, force: true);
            break;
          case 4:
            _position5.set(offset, force: true);
            break;
        }
        i++;
      }
    }
  }

  List<String> get backgroundItems => _backgroundItems.value;
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
