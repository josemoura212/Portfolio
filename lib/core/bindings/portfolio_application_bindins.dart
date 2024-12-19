import 'package:flutter_getit/flutter_getit.dart';
import 'package:portfolio/core/constants/local_storage_constants.dart';
import 'package:portfolio/core/local_storage/local_storage.dart';
import 'package:portfolio/core/local_storage/local_storage_impl.dart';
import 'package:portfolio/core/rest_client/rest_client.dart';
import 'package:portfolio/core/ui/theme_manager.dart';

class PortfolioApplicationBindins extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.lazySingleton<RestClient>(
            (i) => RestClient(LocalStorageConstants.baseUrl)),
        Bind.lazySingleton<LocalStorage>((i) => SharedPreferenceImpl()),
        Bind.lazySingleton<ThemeManager>((i) => ThemeManager(
              initialDarkMode: true,
              localStorage: i(),
            )),
      ];
}
