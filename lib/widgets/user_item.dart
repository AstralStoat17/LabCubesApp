import 'package:flutter/widgets.dart';
import 'package:git_touch/utils/utils.dart';
import 'package:git_touch/widgets/avatar.dart';

class UserItem extends StatelessWidget {

  const UserItem.gitlab({
    required this.login,
    required this.name,
    required this.avatarUrl,
    required this.bio,
    required int? id,
  }) : url = '/gitlab/user/$id';

  const UserItem.gitlabGroup({
    required this.login,
    required this.name,
    required this.avatarUrl,
    required this.bio,
    required int? id,
  }) : url = '/gitlab/group/$id';


  final String? login;
  final String? name;
  final String? avatarUrl;
  final Widget? bio;
  final String url;

  @override
  Widget build(BuildContext context) {
    final theme = AntTheme.of(context);

    return AntListItem(
      onClick: () {
        context.pushUrl(url);
      },
      child: Row(
        children: <Widget>[
          Avatar(url: avatarUrl, size: AvatarSize.large),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    if (name != null)
                      Text(
                        name!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    Expanded(
                      child: Text(
                        login!,
                        style:
                            TextStyle(fontSize: 16, color: theme.colorPrimary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ].withSeparator(const SizedBox(width: 8)),
                ),
                if (bio != null)
                  Builder(builder: (context) {
                    return DefaultTextStyle(
                      style: DefaultTextStyle.of(context).style.copyWith(
                          color: theme.colorTextSecondary, fontSize: 16),
                      child: bio!,
                    );
                  }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
