import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:git_touch/models/auth.dart';
import 'package:git_touch/models/theme.dart';
import 'package:git_touch/utils/utils.dart';
import 'package:git_touch/widgets/action_button.dart';
import 'package:git_touch/widgets/avatar.dart';
import 'package:git_touch/widgets/link.dart';
import 'package:git_touch/widgets/markdown_view.dart';
import 'package:git_touch/widgets/user_name.dart';
import 'package:primer/primer.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;



class CommentItem extends StatelessWidget {
  // TODO

  const CommentItem({
    required this.avatar,
    required this.login,
    required this.createdAt,
    required this.body,
    required this.prefix,
    this.widgets,
    this.commentActionItemList,
  });

  // p.author could be null (deleted user)
  CommentItem.gql(
      GCommentParts p, GReactableParts r, EmojiUpdateCallaback onReaction)
      : avatar = Avatar(
          url: p.author?.avatarUrl ?? '',
          linkUrl: '/gitlab/user/${p.author?.login ?? 'ghost'}',
        ),
        login = p.author?.login ?? 'ghost',
        createdAt = p.createdAt,
        body = p.body,
        widgets = [],
        prefix = 'gitlab',
        commentActionItemList = [];
  final Avatar avatar;
  final String? login;
  final DateTime? createdAt;
  final String? body;
  final String prefix;
  final List<Widget>? widgets;
  final List<ActionItem>? commentActionItemList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          avatar,
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UserName(login, prefix),
                const SizedBox(height: 2),
                Text(
                  timeago.format(createdAt!),
                  style: TextStyle(
                      color: AntTheme.of(context).colorWeak, fontSize: 13),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: ActionButton(
                iconData: Octicons.kebab_horizontal,
                title: 'Comment Actions',
                items: [
                  if (commentActionItemList != null) ...commentActionItemList!
                ],
              )),
        ]),
        const SizedBox(height: 12),
        MarkdownFlutterView(body, padding: EdgeInsets.zero), // TODO: link
        const SizedBox(height: 12),
        if (widgets != null) ...widgets!
      ],
    );
  }
}
