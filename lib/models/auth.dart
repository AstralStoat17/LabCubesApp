import 'dart:async';
import 'dart:convert';

import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:git_touch/models/account.dart';
import 'package:git_touch/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_io/io.dart';

class PlatformType {
  static const gitlab = 'gitlab';
}

class DataWithPage<T> {
  DataWithPage({
    required this.data,
    required this.cursor,
    required this.hasMore,
    required this.total,
  });
  T data;
  int cursor;
  bool hasMore;
  int total;
}

class AuthModel with ChangeNotifier {


  Future<void> loginToGitlab(String domain, String token) async {
    domain = domain.trim();
    token = token.trim();
    loading = true;
    notifyListeners();
    try {
      final res = await http.get(Uri.parse('$domain/api/v4/user'),
          headers: {'Private-Token': token});
      final info = json.decode(res.body);
      if (info['message'] != null) {
        throw info['message'];
      }
      if (info['error'] != null) {
        throw info['error'] + '. ' + (info['error_description'] ?? '');
      }
      final user = GitlabUser.fromJson(info);
      await _addAccount(Account(
        platform: PlatformType.gitlab,
        domain: domain,
        token: token,
        login: user.username!,
        avatarUrl: user.avatarUrl!,
        gitlabId: user.id,
      ));
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<String> fetchWithGitlabToken(String p) async {
    final res = await http.get(Uri.parse(p), headers: {'Private-Token': token});
    return res.body;
  }

  Future fetchGitlab(String p,
      {isPost = false, Map<String, dynamic> body = const {}}) async {
    http.Response res;
    if (isPost) {
      res = await http.post(
        Uri.parse('${activeAccount!.domain}/api/v4$p'),
        headers: {
          'Private-Token': token,
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: jsonEncode(body),
      );
    } else {
      res = await http.get(Uri.parse('${activeAccount!.domain}/api/v4$p'),
          headers: {'Private-Token': token});
    }
    final info = json.decode(utf8.decode(res.bodyBytes));
    if (info is Map && info['message'] != null) throw info['message'];
    return info;
  }

  Future<DataWithPage> fetchGitlabWithPage(String p) async {
    final res = await http.get(Uri.parse('${activeAccount!.domain}/api/v4$p'),
        headers: {'Private-Token': token});
    final next = int.tryParse(
        res.headers['X-Next-Pages'] ?? res.headers['x-next-page'] ?? '');
    final info = json.decode(utf8.decode(res.bodyBytes));
    if (info is Map && info['message'] != null) throw info['message'];
    return DataWithPage(
      data: info,
      cursor: next ?? 1,
      hasMore: next != null,
      total: int.tryParse(
              res.headers['X-Total'] ?? res.headers['x-total'] ?? '') ??
          kTotalCountFallback,
    );
  }



  Future<void> init() async {


    final prefs = await SharedPreferences.getInstance();

    // Read accounts
    try {
      final str = prefs.getString(StorageKeys.accounts);
      // Fimber.d('read accounts: $str');
      _accounts = (json.decode(str ?? '[]') as List)
          .map((item) => Account.fromJson(item))
          .toList();
      activeAccountIndex = prefs.getInt(StorageKeys.iDefaultAccount);

      if (activeAccount != null) {
        _activeTab = prefs.getInt(
                StorageKeys.getDefaultStartTabKey(activeAccount!.platform)) ??
            0;
      }
    } catch (err) {
      Fimber.e('prefs getAccount failed', ex: err);
      _accounts = [];
    }

    notifyListeners();
  }

    super.dispose();

  Future<void> setDefaultAccount(int v) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(StorageKeys.iDefaultAccount, v);
    Fimber.d('write default account: $v');
    notifyListeners();
  }

  var rootKey = UniqueKey();
  reloadApp() {
    rootKey = UniqueKey();
    notifyListeners();
  }

  setActiveAccountAndReload(int index) async {
    // https://stackoverflow.com/a/50116077
    rootKey = UniqueKey();
    activeAccountIndex = index;
    setDefaultAccount(activeAccountIndex!);
    final prefs = await SharedPreferences.getInstance();
    _activeTab = prefs.getInt(
            StorageKeys.getDefaultStartTabKey(activeAccount!.platform)) ??
        0;
    notifyListeners();

    // TODO: strategy
    // waiting for 1min to request review
    // if (!hasRequestedReview) {
    //   hasRequestedReview = true;
    //   Timer(Duration(minutes: 1), () async {
    //     if (await inAppReview.isAvailable()) {
    //       inAppReview.requestReview();
    //     }
    //   });
    // }
  }



  int _activeTab = 0;
  int get activeTab => _activeTab;

  Future<void> setActiveTab(int v) async {
    _activeTab = v;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        StorageKeys.getDefaultStartTabKey(activeAccount!.platform), v);
    Fimber.d('write default start tab for ${activeAccount!.platform}: $v');
    notifyListeners();
  }
}
