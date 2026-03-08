import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:git_touch/models/auth.dart';
import 'package:git_touch/models/code.dart';
import 'package:git_touch/models/theme.dart';
import 'package:git_touch/scaffolds/single.dart';
import 'package:git_touch/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeModel>(context);
    final auth = Provider.of<AuthModel>(context);
    final code = Provider.of<CodeModel>(context);
    return SingleScaffold(
      title: Text('Settings'),
      body: Column(
        children: <Widget>[
          CommonStyle.verticalGap,
          AntList(
            mode: AntListMode.card,
            header: Text('System'),
            children: [
              if (auth.activeAccount!.platform == PlatformType.gitlab)
                AntListItem(
                  onClick: () {
                    launchStringUrl('${auth.activeAccount!.domain}/help');
                  },
                  extra: FutureBuilder<String>(
                    future:
                        auth.fetchGitlab('/version').then((v) => v['version']),
                    builder: (context, snapshot) {
                      return Text(snapshot.data ?? '');
                    },
                  ),
                  child: Text('Gitlab Status'),
                ),
              AntListItem(
                onClick: () {
                  context.push('/login');
                },
                extra: Text(auth.activeAccount!.login),
                child: Text('Switch Accounts'),
              ),
            ],
          ),
          CommonStyle.verticalGap,
          AntList(
            mode: AntListMode.card,
            header: Text('Theme'),
            children: [
              AntListItem(
                extra: Text(theme.brighnessValue == AppBrightnessType.light
                    ? 'Light'
                    : theme.brighnessValue == AppBrightnessType.dark
                        ? 'Dark'
                        : 'Follow System'),
                onClick: () {
                  theme.showActions(context, [
                    for (var t in [
                      Tuple2('Follow System',
                          AppBrightnessType.followSystem),
                      Tuple2('Light',
                          AppBrightnessType.light),
                      Tuple2('Dark',
                          AppBrightnessType.dark),
                    ])
                      ActionItem(
                        text: t.item1,
                        onTap: (_) {
                          if (theme.brighnessValue != t.item2) {
                            theme.setBrightness(t.item2);
                          }
                        },
                      )
                  ]);
                },
                child: Text('Brightness'),
              ),
              AntListItem(
                onClick: () {
                  context.push('/choose-code-theme');
                },
                extra: Text('${code.fontFamily}, ${code.fontSize}pt'),
                child: Text('Code Theme'),
              ),
              AntListItem(
                extra: Text(theme.markdown == AppMarkdownType.flutter
                    ? 'Flutter'
                    : 'Webview'),
                onClick: () {
                  theme.showActions(context, [
                    for (var t in [
                      Tuple2('Flutter',
                          AppMarkdownType.flutter),
                      Tuple2('Webview',
                          AppMarkdownType.webview),
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
                child: Text('Markdown Render Engine'),
              ),
            ],
          ),
          CommonStyle.verticalGap,
          AntList(
            mode: AntListMode.card,
            header: Text('Feedback'),
            children: [
              AntListItem(
                extra: const Text(''),
                onClick: () {
                  const suffix = '';
                  launchStringUrl('https://github.com/$suffix');
                },
                child: Text('Submit An Issue'),
              ),
              AntListItem(
                child: Text('Rate This App'),
                onClick: () {
                  LaunchReview.launch(
                    androidAppId: '',
                    iOSAppId: '',
                  );
                },
              ),
              AntListItem(
                extra: const Text('[EMAIL_ADDRESS]'),
                arrow: const SizedBox(),
                onClick: () {
                  launchStringUrl('mailto:[EMAIL_ADDRESS]');
                },
                child: const Text('Email'),
              ),
            ],
          ),
          CommonStyle.verticalGap,
          AntList(
            mode: AntListMode.card,
            header: Text('About'),
            children: [
              AntListItem(
                extra: FutureBuilder<String>(
                  future:
                      PackageInfo.fromPlatform().then((info) => info.version),
                  builder: (context, snapshot) {
                    return Text(snapshot.data ?? '');
                  },
                ),
                child: Text('Version'),
              ),
              AntListItem(
                extra: const Text('git-touch/git-touch'),
                onClick: () {
                  const suffix = 'git-touch/git-touch';
                  launchStringUrl('https://github.com/$suffix');
                },
                child: Text('Source Code'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
