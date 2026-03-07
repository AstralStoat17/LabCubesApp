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
            AppLocalizations.of(context)!.removeAccount,
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
        prefix: Avatar(url: account.avatarUrl),
        extra: index == auth.activeAccountIndex
            ? const Icon(Ionicons.checkmark)
            : null,
        description: Text(account.domain),
        child: Text(account.login),
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
        Text('${AppLocalizations.of(context)!.somethingBadHappens}$err'));
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthModel>(context);
    final theme = Provider.of<ThemeModel>(context);
    return SingleScaffold(
      title: Text(AppLocalizations.of(context)!.selectAccount),
      body: auth.loading
          ? const Center(child: Loading())
          : Column(
              children: [
                AntList(
                  children: [
                    ...List.generate(auth.accounts!.length, _buildAccountItem),
                    _buildAddItem(
                      text: AppLocalizations.of(context)!.gitlabAccount,
                      brand: Ionicons.git_branch_outline,
                      onTap: () async {
                        _domainController.text = 'https://gitlab.com';
                        final result = await theme.showConfirm(
                          context,
                          _buildPopup(
                            context,
                            showDomain: true,
                            notes: [
                              Text(
                                AppLocalizations.of(context)!
                                    .permissionRequiredMessage,
                                style: const TextStyle(
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
