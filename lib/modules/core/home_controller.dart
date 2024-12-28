import 'package:flutter/material.dart';
import 'package:portfolio/core/helpers/messages.dart';
import 'package:portfolio/core/local_storage/local_storage.dart';
import 'package:portfolio/models/icon_model_controller.dart';
import 'package:portfolio/models/type_model.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController with MessageStateMixin {
  HomeController({
    required LocalStorage localStorage,
  }) : _localStorage = localStorage;
  final LocalStorage _localStorage;

  final Signal<List<IconModel>> _icons = Signal<List<IconModel>>([]);
  IconModel getIcon(TypeModel type) {
    return _icons.value.firstWhere((element) => element.type == type);
  }

  List<IconModel> get icons => _icons.value;

  void addIcon(List<TypeModel> models, Size size) {
    initPosition(size);
    _icons.set([
      ..._icons.value,
      ...models.map((e) {
        return IconModel(
          type: e,
          position: Offset.zero,
          showDetail: false,
          showMenu: false,
        );
      })
    ], force: true);
    _init();
  }

  final Signal<OverlayEntry?> _overlayEntryDetail = Signal<OverlayEntry?>(null);
  final Signal<OverlayEntry?> _overlayEntryMenu = Signal<OverlayEntry?>(null);

  final Signal<TypeModel?> _selectedType = Signal<TypeModel?>(null);
  final Signal<Size> _sizeWindow = Signal<Size>(Size.zero);
  final Signal<Offset> _offsetWindow = Signal<Offset>(Offset.zero);
  final Signal<bool> _showCertificate = Signal<bool>(false);
  final Signal<bool> _overlayDetail = Signal<bool>(false);

  Offset getPosition(TypeModel type) =>
      _icons.value.firstWhere((element) => element.type == type).position;

  OverlayEntry? get getOverlayEntryDetail => _overlayEntryDetail.value;
  OverlayEntry? get getOverlayEntryMenu => _overlayEntryMenu.value;

  Offset get offsetWindow => _offsetWindow.value;
  Size get sizeWidnow => _sizeWindow.value;
  TypeModel? get selectedType => _selectedType.value;
  bool get showCertificate => _showCertificate.value;
  bool get overlayDetail => _overlayDetail.value;

  set overlayEntryDetail(OverlayEntry overlayEntry) {
    _overlayEntryDetail.set(overlayEntry, force: true);
    _overlayDetail.set(true, force: true);
  }

  set overlayEntryMenu(OverlayEntry overlayEntry) {
    _overlayEntryMenu.set(overlayEntry, force: true);
  }

  void removeOverlayDetail() {
    _overlayEntryDetail.value?.remove();
    _overlayDetail.set(false, force: true);
  }

  void removeOverlayMenu() {
    _overlayEntryMenu.value?.remove();
  }

  double _roundPosition(double position) {
    return (position / 100).round() * 100;
  }

  void _setPosition(Offset offset, TypeModel type) {
    _icons.set(
      _icons.value.map((e) {
        if (e.type == type) {
          return e.copyWith(position: offset);
        }
        return e;
      }).toList(),
      force: true,
    );

    save(offset, type);
  }

  void updatePosition(Offset offset, TypeModel type) {
    var newOffset = Offset(
      _roundPosition(offset.dx),
      _roundPosition(offset.dy),
    );
    switch (type) {
      case TypeModel.mangatrix:
        if (_icons.value.any((element) =>
            element.position == newOffset && element.type != type)) {
          newOffset = Offset(newOffset.dx, newOffset.dy - 100);
        }
        _setPosition(newOffset, type);
        break;
      case TypeModel.recibo:
        if (_icons.value.any((element) =>
            element.position == newOffset && element.type != type)) {
          newOffset = Offset(newOffset.dx, newOffset.dy - 100);
        }
        _setPosition(newOffset, type);
        break;
      case TypeModel.dashboard:
        if (_icons.value.any((element) =>
            element.position == newOffset && element.type != type)) {
          newOffset = Offset(newOffset.dx, newOffset.dy - 100);
        }
        _setPosition(newOffset, type);
        break;
      case TypeModel.github:
        if (_icons.value.any((element) =>
            element.position == newOffset && element.type != type)) {
          newOffset = Offset(newOffset.dx, newOffset.dy - 100);
        }
        _setPosition(newOffset, type);
        break;
      case TypeModel.certificados:
        if (_icons.value.any((element) =>
            element.position == newOffset && element.type != type)) {
          newOffset = Offset(newOffset.dx, newOffset.dy - 100);
        }
        _setPosition(newOffset, type);
        break;
      default:
        break;
    }
  }

  void setShowCertificate() {
    _showCertificate.set(!_showCertificate.value, force: true);
  }

  void setType(TypeModel type) {
    _selectedType.set(type, force: true);
  }

  void removeType() {
    _selectedType.set(null, force: true);
  }

  void setSizeWindow(Size size) {
    _sizeWindow.set(Size(size.width, size.height * .9), force: true);
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

  void initPosition(Size size) {
    final offset = Offset(
      size.width / 2,
      size.height / 2,
    );
    var i = offset.dx - 200;
    for (var element in _icons.value) {
      if (element.position == Offset.zero) {
        updatePosition(Offset(i, offset.dy + 100), element.type);
        i += 100;
      }
    }
  }

  Future<void> clean() {
    return _localStorage.clear();
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
            _setPosition(offset, TypeModel.mangatrix);
            break;
          case 1:
            _setPosition(offset, TypeModel.recibo);
            break;
          case 2:
            _setPosition(offset, TypeModel.dashboard);
            break;
          case 3:
            _setPosition(offset, TypeModel.github);
            break;
          case 4:
            _setPosition(offset, TypeModel.certificados);
            break;
        }
        i++;
      }
    }
  }

  Future<void> launchUrlNew(String url) async {
    final Uri url0 = Uri.parse(url);
    if (!await launchUrl(url0)) {
      throw Exception('Could not launch $url');
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
