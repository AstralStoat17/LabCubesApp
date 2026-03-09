import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:git_touch/home.dart';
import 'package:git_touch/models/auth.dart';
import 'package:git_touch/models/theme.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthModel>(context);
    final theme = Provider.of<ThemeModel>(context);

    final LocaleListResolutionCallback localeListResolutionCallback =
        (locales, supportedLocales) {
      // 1. user set locale
      // 2. system locale

      // 3. if none match, use the default
      return supportedLocales.firstWhere((l) => l.languageCode == 'en');
    };

    return Container(
      key: auth.rootKey,
      child: theme.theme == AppThemeType.cupertino
          ? CupertinoApp(
              theme: CupertinoThemeData(brightness: theme.brightness),
              home: Home(),
              localeListResolutionCallback: localeListResolutionCallback,
            )
          : MaterialApp(
              theme: ThemeData(
                brightness: theme.brightness,
                primaryColor:
                    theme.brightness == Brightness.dark ? null : Colors.white,
                scaffoldBackgroundColor: theme.palette.background,
                pageTransitionsTheme: PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: ZoomPageTransitionsBuilder(),
                  },
                ),
              ),
              home: Home(),
              localeListResolutionCallback: localeListResolutionCallback,
            ),
    );
  }
}
