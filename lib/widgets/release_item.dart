import 'package:flutter/widgets.dart';
import 'package:git_touch/widgets/avatar.dart';
import 'package:git_touch/widgets/markdown_view.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:git_touch/utils/utils.dart';

class ReleaseItem extends StatefulWidget {
  const ReleaseItem({
    required this.login,
    required this.publishedAt,
    required this.name,
    required this.tagName,
    required this.avatarUrl,
    required this.description,
  });
  final String? login;
  final DateTime? publishedAt;
  final String? name;
  final String? avatarUrl;
  final String? tagName;
  final String? description;

  @override
  State<ReleaseItem> createState() => _ReleaseItemState();
}

class _ReleaseItemState extends State<ReleaseItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Row(children: <Widget>[
          Avatar(url: widget.avatarUrl, size: AvatarSize.large),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      widget.tagName!,
                      style: TextStyle(
                        color: AntTheme.of(context).colorPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                DefaultTextStyle(
                  style: TextStyle(
                    color: AntTheme.of(context).colorTextSecondary,
                    fontSize: 16,
                  ),
                  child: Text(
                      '${widget.login!} Released ${timeago.format(widget.publishedAt!)}'),
                ),
              ],
            ),
          ),
        ]),
        if (widget.description != null && widget.description!.isNotEmpty) ...[
          MarkdownFlutterView(
            widget.description,
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}
