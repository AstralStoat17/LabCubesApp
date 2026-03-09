import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:git_touch/models/auth.dart';
import 'package:git_touch/models/code.dart';
import 'package:git_touch/models/theme.dart';
import 'package:git_touch/scaffolds/single.dart';
import 'package:git_touch/utils/locale.dart';
import 'package:git_touch/utils/utils.dart';
import 'package:git_touch/widgets/action_button.dart';
import 'package:git_touch/widgets/app_bar_title.dart';
import 'package:git_touch/widgets/table_view.dart';

import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeModel>(context);
    final auth = Provider.of<AuthModel>(context);
    final code = Provider.of<CodeModel>(context);
    return SingleScaffold(
      title: AppBarTitle("settings"),
      body: Column(
        children: <Widget>[
          CommonStyle.verticalGap,
          TableView(
            hasIcon: false,
            headerText: "system",
            items: [
              if (auth.activeAccount!.platform == PlatformType.github) ...[
                TableViewItem(
                  text: Text("githubStatus"),
                  url: 'https://www.githubstatus.com/',
                ),
                TableViewItem(
                  text: Text("reviewPermissions"),
                  url:
                      'https://github.com/settings/connections/applications/$clientId',
                  rightWidget: Text(auth.activeAccount!.login),
                ),
              ],
              if (auth.activeAccount!.platform == PlatformType.gitlab)
                TableViewItem(
                  text: Text("gitlabStatus"),
                  url: '${auth.activeAccount!.domain}/help',
                  rightWidget: FutureBuilder<String>(
                    future:
                        auth.fetchGitlab('/version').then((v) => v['version']),
                    builder: (context, snapshot) {
                      return Text(snapshot.data ?? '');
                    },
                  ),
                ),
              if (auth.activeAccount!.platform == PlatformType.gitea)
                TableViewItem(
                  leftIconData: Octicons.info,
                  text: Text("giteaStatus"),
                  url: '/gitea/status',
                  rightWidget: FutureBuilder<String>(
                    future:
                        auth.fetchGitea('/version').then((v) => v['version']),
                    builder: (context, snapshot) {
                      return Text(snapshot.data ?? '');
                    },
                  ),
                ),
              TableViewItem(
                text: Text("switchAccounts"),
                url: '/login',
                rightWidget: Text(auth.activeAccount!.login),
              ),
              TableViewItem(
                text: Text('App Language'),
                rightWidget: Text(theme.locale == null
                    ? "followSystem"
                    : localeNameMap[theme.locale!] ?? theme.locale!),
                onTap: () {
                  theme.showActions(context, [
                    ActionItem(
                      text: key == null ? "followSystem" : localeNameMap[key],
                      onTap: (_) async {
                        final res = await theme.showConfirm(
                          context,
                          Text(
                              'The app will reload to make the language setting take effect'),
                        );
                        if (res == true && theme.locale != key) {
                          await theme.setLocale(key);
                          auth.reloadApp();
                        }
                      },
                    )
                  ]);
                },
              )
            ],
          ),
          CommonStyle.verticalGap,
          TableView(headerText: 'theme', items: [
            TableViewItem(
              text: Text("brightness"),
              rightWidget: Text(theme.brighnessValue == AppBrightnessType.light
                  ? 'Light'
                  : theme.brighnessValue == AppBrightnessType.dark
                      ? 'Dark'
                      : 'Follow system'),
              onTap: () {
                theme.showActions(context, [
                  for (var t in [
                    Tuple2("followSystem", AppBrightnessType.followSystem),
                    Tuple2("light", AppBrightnessType.light),
                    Tuple2("dark", AppBrightnessType.dark),
                  ])
                    ActionItem(
                      text: t.item1,
                      onTap: (_) {
                        if (theme.brighnessValue != t.item2)
                          theme.setBrightness(t.item2);
                      },
                    )
                ]);
              },
            ),
            TableViewItem(
              text: Text("scaffoldTheme"),
              rightWidget: Text(theme.theme == AppThemeType.cupertino
                  ? "cupertino"
                  : "material"),
              onTap: () {
                theme.showActions(context, [
                  for (var t in [
                    Tuple2("material", AppThemeType.material),
                    Tuple2("cupertino", AppThemeType.cupertino),
                  ])
                    ActionItem(
                      text: t.item1,
                      onTap: (_) {
                        if (theme.theme != t.item2) {
                          theme.setTheme(t.item2);
                        }
                      },
                    )
                ]);
              },
            ),
            TableViewItem(
              text: Text("codeTheme"),
              url: '/choose-code-theme',
              rightWidget: Text('${code.fontFamily}, ${code.fontSize}pt'),
            ),
            TableViewItem(
              text: Text("markdownRenderEngine"),
              rightWidget: Text(theme.markdown == AppMarkdownType.flutter
                  ? "flutter"
                  : "webview"),
              onTap: () {
                theme.showActions(context, [
                  for (var t in [
                    Tuple2("flutter", AppMarkdownType.flutter),
                    Tuple2("webview", AppMarkdownType.webview),
                  ])
                    ActionItem(
                      text: t.item1,
                      onTap: (_) {
                        if (theme.markdown != t.item2) {
                          theme.setMarkdown(t.item2);
                        }
                      },
                    )
                ]);
              },
            ),
          ]),
          CommonStyle.verticalGap,
          TableView(headerText: "feedback", items: []),
          CommonStyle.verticalGap,
          TableView(headerText: "about", items: [
            TableViewItem(
                text: Text("version"),
                rightWidget: FutureBuilder<String>(
                  future:
                      PackageInfo.fromPlatform().then((info) => info.version),
                  builder: (context, snapshot) {
                    return Text(snapshot.data ?? '');
                  },
                )),
          ])
        ],
      ),
    );
  }
}
