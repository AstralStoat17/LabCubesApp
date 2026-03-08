import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:git_touch/models/gitlab.dart';
import 'package:git_touch/utils/utils.dart';
import 'package:git_touch/widgets/avatar.dart';

class RepoItem extends StatelessWidget {
  const RepoItem({
    required this.owner,
    required this.avatarUrl,
    required this.name,
    required this.description,
    required this.starCount,
    required this.forkCount,
    this.primaryLanguageName,
    this.primaryLanguageColor,
    this.note,
    this.iconData,
    required this.url,
    required this.avatarLink,
  });



  RepoItem.gl({
    required GitlabProject payload,
    this.primaryLanguageName,
    this.primaryLanguageColor,
    this.note,
  })  : owner = payload.namespace!.path,
        avatarUrl = payload.owner?.avatarUrl,
        name = payload.name,
        description = payload.description,
        starCount = payload.starCount,
        forkCount = payload.forksCount,
        url = '/gitlab/projects/${payload.id}',
        avatarLink = payload.namespace!.kind == 'group'
            ? '/gitlab/group/${payload.namespace!.id}'
            : '/gitlab/user/${payload.namespace!.id}',
        iconData = _buildGlIconData(payload.visibility);


  final String? owner;
  final String? avatarUrl;
  final String? name;
  final String? description;
  final IconData? iconData;
  final int? starCount;
  final int? forkCount;
  final String? primaryLanguageName;
  final String? primaryLanguageColor;
  final String? note;
  final String url;
  final String? avatarLink;



  static IconData _buildGlIconData(String? visibility) {
    switch (visibility) {
      case 'internal':
        return Ionicons.shield_outline;
      case 'public':
        return Ionicons.globe_outline;
      case 'private':
        return Ionicons.lock_closed_outline;
      default:
        return Octicons.repo;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = AntTheme.of(context);
    const bottomGap = SizedBox(width: 4);

    return AntListItem(
      arrow: null,
      onClick: () {
        context.pushUrl(url);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Avatar(
                url: avatarUrl,
                size: AvatarSize.small,
                linkUrl: avatarLink,
              ),
              Expanded(
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: '$owner / ',
                      style: TextStyle(
                          height: 1, fontSize: 18, color: theme.colorPrimary),
                    ),
                    TextSpan(
                      text: name,
                      style: TextStyle(
                        height: 1,
                        fontSize: 18,
                        color: theme.colorPrimary,
                        fontWeight: FontWeight.w600,
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (iconData != null)
                DefaultTextStyle(
                  style: TextStyle(color: theme.colorTextSecondary),
                  child:
                      Icon(iconData, size: 18, color: theme.colorTextSecondary),
                ),
            ].withSeparator(const SizedBox(width: 8)),
          ),
          if (description != null && description!.isNotEmpty)
            Text(
              description!,
              style: TextStyle(color: theme.colorTextSecondary, fontSize: 16),
            ),
          if (note != null)
            Text(note!, style: TextStyle(fontSize: 14, color: theme.colorWeak)),
          Builder(builder: (context) {
            return DefaultTextStyle(
              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 14),
              child: IconTheme(
                data: IconThemeData(size: 14, color: theme.colorText),
                child: Row(
                  children: <Widget>[
                    if (primaryLanguageName != null)
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: fromCssColor(primaryLanguageColor ?? '#000000'),
                              shape: BoxShape.circle,
                            ),
                          ),
                          bottomGap,
                          Text(primaryLanguageName!),
                        ],
                      ),
                    if (starCount! > 0)
                      Row(
                        children: [
                          const Icon(Octicons.star),
                          bottomGap,
                          Text(numberFormat.format(starCount)),
                        ],
                      ),
                    if (forkCount! > 0)
                      Row(
                        children: [
                          const Icon(Octicons.repo_forked),
                          bottomGap,
                          Text(numberFormat.format(forkCount)),
                        ],
                      ),
                  ].withSeparator(const SizedBox(width: 24)),
                ),
              ),
            );
          }),
        ].withSeparator(const SizedBox(height: 8)),
      ),
    );
  }
}
