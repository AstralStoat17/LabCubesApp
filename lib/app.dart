import 'package:flutter/cupertino.dart';
import 'package:git_touch/models/auth.dart';
import 'package:git_touch/models/theme.dart';
import 'package:git_touch/router.dart';
import 'package:provider/provider.dart';
import 'package:git_touch/utils/utils.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthModel>(context);
    final theme = Provider.of<ThemeModel>(context);

    return AntTheme(
      key: auth.rootKey,
      data: AntThemeData(brightness: theme.brightness),
      child: Builder(
        builder: (context) {
          final antTheme = AntTheme.of(context);

          return CupertinoApp.router(
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            theme: CupertinoThemeData(
              brightness: theme.brightness,
              primaryColor: antTheme.colorPrimary,
              scaffoldBackgroundColor: antTheme.colorBox,
              textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(
                  fontSize: antTheme.fontSizeMain,
                  color: antTheme.colorText,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
