import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:portfolio/core/bindings/portfolio_application_bindins.dart';
import 'package:portfolio/core/ui/loader.dart';
import 'package:portfolio/core/ui/theme_manager.dart';
import 'package:portfolio/core/ui/ui_config.dart';
import 'package:portfolio/modules/home_module.dart';
import 'package:asyncstate/asyncstate.dart' as asyncstate;
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterGetIt(
        bindings: PortfolioApplicationBindins(),
        modules: [
          HomeModule(),
        ],
        builder: (context, routes, isReady) {
          final themeManager = Injector.get<ThemeManager>()..getDarkMode();
          return asyncstate.AsyncStateBuilder(
              loader: PortfolioLoader(),
              builder: (asyncNavigatorObserver) {
                return Watch(
                  (_) => MaterialApp(
                    localizationsDelegates: const [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('pt', 'BR'),
                    ],
                    scrollBehavior: MaterialScrollBehavior().copyWith(
                      dragDevices: {
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.touch,
                        PointerDeviceKind.stylus,
                        PointerDeviceKind.unknown
                      },
                    ),
                    debugShowCheckedModeBanner: false,
                    title: "José Augusto ",
                    theme: UiConfig.lightTheme,
                    darkTheme: UiConfig.darkTheme,
                    themeMode: themeManager.isDarkMode
                        ? ThemeMode.dark
                        : ThemeMode.light,
                    navigatorObservers: [
                      asyncNavigatorObserver,
                    ],
                    routes: routes,
                    initialRoute: "/home/",
                  ),
                );
              });
        });
  }
}
