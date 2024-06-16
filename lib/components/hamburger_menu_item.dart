import 'package:flutter/material.dart';

class HamburgerMenuItem extends StatelessWidget {
  final Widget widget;
  final String title;
  const HamburgerMenuItem(
      {super.key, required this.title, required this.widget});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => widget,
          ),
        );
      },
    );
  }
}
