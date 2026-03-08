import 'package:flutter/material.dart';

class AntThemeData {
  final Brightness brightness;
  AntThemeData({required this.brightness});
}

class AntTheme extends StatelessWidget {
  final AntThemeData? data;
  final Widget? child;

  const AntTheme({Key? key, this.data, this.child}) : super(key: key);

  static _AntThemeColors of(BuildContext context) => _AntThemeColors(context);

  @override
  Widget build(BuildContext context) {
    return child ?? const SizedBox();
  }
}

class _AntThemeColors {
  final BuildContext context;
  _AntThemeColors(this.context);

  Color get colorPrimary => Theme.of(context).primaryColor;
  Color get colorText => Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
  Color get colorTextSecondary => Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey;
  Color get colorBackground => Theme.of(context).scaffoldBackgroundColor;
  Color get colorBorder => Theme.of(context).dividerColor;
  Color get colorWeak => Colors.grey;
  Color get colorDanger => Colors.red;
  Color get colorBox => Theme.of(context).cardColor;
  double get fontSizeMain => 16.0;
}

class AntListItem extends StatelessWidget {
  final Widget child;
  final Function()? onClick;
  final Widget? extra;
  final Widget? arrow;

  const AntListItem({
    Key? key,
    required this.child,
    this.onClick,
    this.extra,
    this.arrow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AntTheme.of(context).colorBorder)),
        ),
        child: Row(
          children: [
            Expanded(child: child),
            if (extra != null) Padding(padding: const EdgeInsets.only(left: 8), child: extra),
            if (arrow != null || onClick != null) ...[
              const SizedBox(width: 8),
              arrow ?? Icon(Icons.chevron_right, color: AntTheme.of(context).colorWeak),
            ],
          ],
        ),
      ),
    );
  }
}

enum AntListMode { card, plain }

class AntList extends StatelessWidget {
  final List<Widget> children;
  final Widget? header;
  final AntListMode mode;

  const AntList({Key? key, required this.children, this.header, this.mode = AntListMode.plain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null) Padding(padding: const EdgeInsets.all(16), child: header),
        Container(
          decoration: BoxDecoration(
            color: AntTheme.of(context).colorBox,
            borderRadius: mode == AntListMode.card ? BorderRadius.circular(8) : null,
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

enum AntButtonFill { solid, outline, none }
enum AntButtonShape { rounded, rectangle }
enum AntButtonSize { large, medium, small }

class AntButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final AntButtonFill fill;
  final AntButtonShape shape;
  final AntButtonSize size;
  final bool block;
  final Function()? onClick;

  const AntButton({
    Key? key,
    required this.child,
    this.color,
    this.fill = AntButtonFill.solid,
    this.shape = AntButtonShape.rounded,
    this.size = AntButtonSize.medium,
    this.block = false,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color effectiveColor = color ?? Theme.of(context).primaryColor;
    return MaterialButton(
      onPressed: onClick,
      color: fill == AntButtonFill.solid ? effectiveColor : Colors.transparent,
      elevation: 0,
      minWidth: block ? double.infinity : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(shape == AntButtonShape.rounded ? 8 : 0),
        side: (fill == AntButtonFill.outline || fill == AntButtonFill.none) ? BorderSide(color: effectiveColor) : BorderSide.none,
      ),
      child: child,
    );
  }
}

enum AntTagFill { solid, outline }

class AntTag extends StatelessWidget {
  final Widget child;
  final Color? color;
  final AntTagFill fill;
  final bool round;
  const AntTag({Key? key, required this.child, this.color, this.fill = AntTagFill.solid, this.round = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color effectiveColor = color ?? Theme.of(context).primaryColor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: fill == AntTagFill.solid ? effectiveColor.withValues(alpha: 0.1) : Colors.transparent,
        border: Border.all(color: effectiveColor),
        borderRadius: BorderRadius.circular(round ? 12 : 4),
      ),
      child: child,
    );
  }
}

class AntIcons {
  static const IconData folderOutline = Icons.folder_open;
  static const IconData fileOutline = Icons.insert_drive_file_outlined;
  static const IconData rightOutline = Icons.chevron_right;
}

class AntPopup {
  static Future<T?> show<T>({
    required BuildContext context,
    bool closeOnMaskClick = true,
    required WidgetBuilder builder,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: closeOnMaskClick,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: builder(context),
      ),
    );
  }
}

class AntActionSheetAction {
  final Widget text;
  final Function() onClick;
  AntActionSheetAction({required this.text, required this.onClick, Key? key});
}

class AntActionSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    Widget? extra,
    required List<AntActionSheetAction> actions,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (extra != null) Padding(padding: const EdgeInsets.all(16), child: extra),
            ...actions.map((a) => ListTile(title: a.text, onTap: () {
              Navigator.pop(context);
              a.onClick();
            })).toList(),
          ],
        ),
      ),
    );
  }
}

class AntCollapse extends StatelessWidget {
  final List<AntCollapsePanel>? panels;
  final Set<String> activeKey;
  final Function(Set<String>)? onChange;
  const AntCollapse({Key? key, this.panels, this.activeKey = const {}, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (panels == null) return const SizedBox();
    return ExpansionPanelList.radio(
      children: panels!.map((c) => ExpansionPanelRadio(value: c.hashCode, headerBuilder: (ctx, isExp) => ListTile(title: c.title), body: c.child)).toList(),
    );
  }
}

class AntCollapsePanel {
  final Widget title;
  final Widget child;
  final String key;
  AntCollapsePanel({required this.title, required this.child, required this.key});
}

class AntToast {
  static Future<void> show(BuildContext context, {required Widget content}) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: content));
  }
}
