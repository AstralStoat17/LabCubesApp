import 'package:filesize/filesize.dart';
import 'package:flutter/widgets.dart';
import 'package:git_touch/utils/utils.dart';

AntListItem createObjectTreeItem({
  required String name,
  required String type,
  required String url,
  String? downloadUrl,
  int? size,
}) {
  return AntListItem(
    extra: size == null ? null : Text(filesize(size)),
    onClick: () async {
      final finalUrl = [
        // Let system browser handle these files
        //
        // TODO:
        // Unhandled Exception: PlatformException(Error, Error while launching
        // https://github.com/flutter/flutter/issues/49162

        // Docs
        'pdf', 'docx', 'doc', 'pptx', 'ppt', 'xlsx', 'xls',
        // Fonts
        'ttf', 'otf', 'eot', 'woff', 'woff2',
        'svg',
      ].contains(name.ext)
          ? downloadUrl
          : url;
      await launchStringUrl(finalUrl);
    },
    arrow: size == null ? const Icon(AntIcons.rightOutline) : null,
    child: Text(name),
  );
}
