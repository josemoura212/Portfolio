import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class Window {
  OverlayEntry? _overlayEntry;
  final Signal<Offset> _offset = Signal<Offset>(Offset.zero);

  void showWindows(
      BuildContext context, Widget Function(OverlayEntry) builder) {
    // Criar o OverlayEntry
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        key: UniqueKey(),
        top: _offset.value.dy,
        left: _offset.value.dx,
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 2,
        child: GestureDetector(
          onPanUpdate: (details) {
            _offset.set(details.globalPosition, force: true);
            _overlayEntry?.markNeedsBuild();
          },
          child: builder(_overlayEntry!),
        ),
      ),
    );

    // Inserir o OverlayEntry
    Overlay.of(context).insert(_overlayEntry!);
  }
}

mixin WindowStateMixin {
  final Signal<Widget Function(OverlayEntry)?> _builder = signal(null);
  Widget Function(OverlayEntry)? get builder => _builder.value;

  void showWindow(Widget Function(OverlayEntry) builder) {
    _builder.value = builder;
  }
}

mixin WindowViewMixin<T extends StatefulWidget> on State<T> {
  final window = Window();
  void windowListener(WindowStateMixin state) {
    effect(() {
      switch (state) {
        case WindowStateMixin(:final builder?):
          window.showWindows(context, builder);
      }
    });
  }
}
