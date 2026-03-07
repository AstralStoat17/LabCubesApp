import 'package:flutter/widgets.dart';
import 'package:git_touch/utils/utils.dart';
import 'package:tuple/tuple.dart';



class NotificationModel with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  setCount(int v) {
    _count = v;
    notifyListeners();
  }
}
