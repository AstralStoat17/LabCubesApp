import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:git_touch/models/auth.dart';
import 'package:git_touch/models/theme.dart';
import 'package:git_touch/scaffolds/single.dart';
import 'package:git_touch/utils/utils.dart';
import 'package:git_touch/widgets/action_button.dart';
import 'package:git_touch/widgets/avatar.dart';
import 'package:git_touch/widgets/loading.dart';
import 'package:git_touch/widgets/text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _tokenController = TextEditingController();
  final _domainController = TextEditingController();

  Widget _buildAccountItem(int index) {
    final auth = Provider.of<AuthModel>(context);
    final account = auth.accounts![index];
    return Dismissible(
      key: ValueKey(index),
      direction: DismissDirection.endToStart,
      background: Container(
        color: AntTheme.of(context).colorDanger,
        padding: const EdgeInsets.only(right: 12),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Remove Account',
            style: TextStyle(
              fontSize: 16,
              color: AntTheme.of(context).colorBackground,
            ),
          ),
        ),
      ),
      onDismissed: (_) {
        auth.removeAccount(index);
      },
      child: AntListItem(
        onClick: () {
          auth.setActiveAccountAndReload(index);
        },
        arrow: null,
        extra: index == auth.activeAccountIndex
            ? const Icon(Ionicons.checkmark)
            : null,
        child: Row(
          children: [
            Avatar(url: account.avatarUrl),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(account.login),
                Text(account.domain, style: TextStyle(fontSize: 12, color: AntTheme.of(context).colorTextSecondary)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddItem({
    IconData? brand,
    required String text,
    void Function()? onTap,
  }) {
    return AntListItem(
      onClick: onTap,
      child: Row(
        children: <Widget>[
          const Icon(Ionicons.add),
          const SizedBox(width: 4),
          Icon(brand),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildPopup(
    BuildContext context, {
    List<Widget>? notes,
    bool showDomain = false,
  }) {
    return Column(
      children: <Widget>[
        if (showDomain)
          MyTextField(controller: _domainController, placeholder: 'Domain'),
        const SizedBox(height: 8),
        MyTextField(placeholder: 'Access token', controller: _tokenController),
        const SizedBox(height: 8),
        if (notes != null) ...notes,
      ],
    );
  }

  void showError(err) {
    context.read<ThemeModel>().showConfirm(context,
        Text('${'Something Bad Happens'}$err'));
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthModel>(context);
    final theme = Provider.of<ThemeModel>(context);
    return SingleScaffold(
      title: Text('Select Account'),
      body: auth.loading
          ? const Center(child: Loading())
          : Column(
              children: [
                AntList(
                  children: [
                    ...List.generate(auth.accounts!.length, _buildAccountItem),
                    _buildAddItem(
                      text: 'Gitlab Account',
                      brand: Ionicons.git_branch_outline,
                      onTap: () async {
                        _domainController.text = 'https://gitlab.com';
                        final result = await theme.showConfirm(
                          context,
                          _buildPopup(
                            context,
                            showDomain: true,
                            notes: [
                              const Text(
                                'Personal access token is required',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'api, read_user, read_repository',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AntTheme.of(context).colorPrimary),
                              )
                            ],
                          ),
                        );
                        if (result == true) {
                          try {
                            await auth.loginToGitlab(
                                _domainController.text, _tokenController.text);
                            _tokenController.clear();
                          } catch (err) {
                            showError(err);
                          }
                        }
                      },
                    ),
                  ],
                ),
                Container(
                  padding: CommonStyle.padding,
                  child: Text(
                    'Swipe to left to remove account',
                    style: TextStyle(
                      fontSize: 16,
                      color: AntTheme.of(context).colorTextSecondary,
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
