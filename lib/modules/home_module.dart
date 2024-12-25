import 'package:flutter_getit/flutter_getit.dart';
import 'package:portfolio/modules/home_controller.dart';
import 'package:portfolio/modules/home_page.dart';

class HomeModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => "/home";

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => HomeController(
              localStorage: i(),
            )),
      ];

  @override
  List<FlutterGetItPageRouter> get pages => [
        FlutterGetItPageRouter(
          name: "/",
          builder: (context) => HomePage(),
        ),
      ];
}
