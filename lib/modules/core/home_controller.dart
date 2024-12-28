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
  List<IconModel> get icons => _icons.value;

  IconModel getIcon(TypeModel type) {
    return _icons.value.firstWhere((element) => element.type == type);
  }

  void addIcon(List<TypeModel> models, Size size) {
    _icons.set([
      ..._icons.value,
      ...models.map((e) {
        return IconModel(
          type: e,
          position: Offset.zero,
          overlayPosition: Offset.zero,
        );
      })
    ], force: true);
    _init();
    initPosition(size);
  }

  final Signal<OverlayEntry?> _overlayEntryDetail = Signal<OverlayEntry?>(null);
  OverlayEntry? get getOverlayEntryDetail => _overlayEntryDetail.value;
  final Signal<bool> _overlayDetail = Signal<bool>(false);
  bool get overlayDetail => _overlayDetail.value;
  final Signal<List<TypeModel>> _showMenu = Signal<List<TypeModel>>([]);
  List<TypeModel> get showMenu => _showMenu.value;

  final Signal<TypeModel?> _selectedType = Signal<TypeModel?>(null);
  TypeModel? get selectedType => _selectedType.value;

  Offset getPosition(TypeModel type) =>
      _icons.value.firstWhere((element) => element.type == type).position;

  OverlayEntry? getOverlayEntryMenu(TypeModel type) =>
      _icons.value.firstWhere((element) => element.type == type).overlayEntry;
  Offset offsetWindow(TypeModel type) => _icons.value
      .firstWhere((element) => element.type == type)
      .overlayPosition;

  set overlayEntryDetail(OverlayEntry overlayEntry) {
    _overlayEntryDetail.set(overlayEntry, force: true);
    _overlayDetail.set(true, force: true);
  }

  void removeOverlayDetail() {
    _overlayEntryDetail.value?.remove();
    _overlayDetail.set(false, force: true);
  }

  void setOverlayEntryMenu(OverlayEntry overlayEntry, TypeModel type) {
    _showMenu.set([..._showMenu.value, type], force: true);
    _icons.set(
      _icons.value.map((e) {
        if (e.type == type) {
          return e.copyWith(overlayEntry: () => overlayEntry, showMenu: true);
        }
        return e;
      }).toList(),
      force: true,
    );
  }

  void removeOverlayMenu(TypeModel type) {
    _showMenu.set(_showMenu.value.where((element) => element != type).toList());
    final overlay =
        _icons.value.firstWhere((element) => element.type == type).overlayEntry;

    if (overlay != null) {
      overlay.remove();
    }
    _icons.set(
      _icons.value.map((e) {
        if (e.type == type) {
          return e.copyWith(overlayEntry: null, showMenu: false);
        }
        return e;
      }).toList(),
      force: true,
    );
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
    if (_icons.value.any(
        (element) => element.position == newOffset && element.type != type)) {
      newOffset = Offset(newOffset.dx, newOffset.dy - 100);
    }
    _setPosition(newOffset, type);
  }

  void selectType(TypeModel type) {
    _selectedType.set(type, force: true);
  }

  void removeType() {
    _selectedType.set(null, force: true);
  }

  void setOffsetOverlayMenu(Offset offset, TypeModel type) {
    _icons.set(
      _icons.value.map((e) {
        if (e.type == type) {
          return e.copyWith(overlayPosition: offset);
        }
        return e;
      }).toList(),
      force: true,
    );
  }

  void minimizer(TypeModel type) {
    _icons.set(
      _icons.value.map((e) {
        if (e.type == type) {
          return e.copyWith(overlayPosition: Offset(1000, 1000));
        }
        return e;
      }).toList(),
      force: true,
    );
  }

  void maximizer(TypeModel type) {
    _icons.set(
      _icons.value.map((e) {
        if (e.type == type) {
          return e.copyWith(overlayPosition: Offset.zero);
        }
        return e;
      }).toList(),
      force: true,
    );
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
