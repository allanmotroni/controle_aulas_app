import 'package:flutter/material.dart';

class SubMenu extends StatelessWidget {
  final String title;
  final Widget? leading;
  final EdgeInsetsGeometry? edgeInsetsGeometry;

  const SubMenu(this.title, {super.key, this.leading, this.edgeInsetsGeometry});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: edgeInsetsGeometry,
      leading: leading,
      title: Text(title),
    );
  }
}
