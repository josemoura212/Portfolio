import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:portfolio/models/type_model.dart';
import 'package:portfolio/modules/core/home_controller.dart';

class CertificateWidget extends StatelessWidget {
  const CertificateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Injector.get<HomeController>();
    return Material(
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
              title: Text('Certificados'),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () {
                    controller.minimizer(TypeModel.certificados);
                  },
                  icon: Icon(Icons.minimize),
                ),
                IconButton(
                  onPressed: () {
                    controller.maximizer(TypeModel.certificados);
                  },
                  icon: Icon(Icons.fullscreen),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    controller.removeOverlayMenu(TypeModel.certificados);
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
    );
  }
}
