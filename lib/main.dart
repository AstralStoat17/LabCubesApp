import 'package:flutter/widgets.dart';
import 'package:git_touch/app.dart';
import 'package:git_touch/models/auth.dart';
import 'package:git_touch/models/code.dart';
import 'package:git_touch/models/notification.dart';
import 'package:git_touch/models/theme.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notificationModel = NotificationModel();
  final themeModel = ThemeModel();
  final authModel = AuthModel();
  final codeModel = CodeModel();
  await Future.wait([
    themeModel.init(),
    authModel.init(),
    codeModel.init(),
  ]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => notificationModel),
      ChangeNotifierProvider(create: (context) => themeModel),
      ChangeNotifierProvider(create: (context) => authModel),
      ChangeNotifierProvider(create: (context) => codeModel),
    ],
    child: const MyApp(),
  ));
}
