import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:portfolio/modules/home_controller.dart';
import 'package:signals_flutter/signals_flutter.dart';

class CertificateWidget extends StatelessWidget {
  const CertificateWidget({super.key, required this.overlayEntry});
  final OverlayEntry overlayEntry;

  @override
  Widget build(BuildContext context) {
    final controller = Injector.get<HomeController>();
    return Watch(
      (_) => Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              AppBar(
                title: Text('Mini Tela'),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      overlayEntry.remove();
                    },
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Text('Conteúdo da mini tela'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
