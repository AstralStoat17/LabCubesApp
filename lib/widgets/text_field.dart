import 'package:flutter/cupertino.dart';
import 'package:git_touch/utils/utils.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({required this.controller, this.placeholder});
  final TextEditingController controller;
  final String? placeholder;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      style: TextStyle(color: AntTheme.of(context).colorText),
    );
  }
}
