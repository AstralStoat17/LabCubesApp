import 'dart:io';

String uncamelcase(String text) {
  if (text.isEmpty) return text;
  final result = text.replaceAllMapped(RegExp(r'[A-Z]'), (match) => ' ${match.group(0)}');
  return result[0].toUpperCase() + result.substring(1);
}

void main() {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));

  final regExp = RegExp(r"AppLocalizations\.of\(context\)\!?\.([a-zA-Z0-9_]+)");

  for (final file in files) {
    String content = file.readAsStringSync();
    if (content.contains('AppLocalizations')) {
      bool changed = false;
      content = content.replaceAllMapped(regExp, (match) {
        changed = true;
        final key = match.group(1)!;
        final englishText = uncamelcase(key);
        return "'$englishText'";
      });
      if (changed) {
        file.writeAsStringSync(content);
      }
    }
  }
  print('Done replacing AppLocalizations');
}
