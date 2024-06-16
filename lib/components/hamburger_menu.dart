import 'package:flutter/material.dart';

class HamburgerMenu extends StatefulWidget {
  final List<Widget> widgets;
  const HamburgerMenu({super.key, required this.widgets});

  @override
  State<HamburgerMenu> createState() => _HamburgerMenuState();
}

class _HamburgerMenuState extends State<HamburgerMenu> {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];

    widgets.add(
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.indigo,
        ),
        child: Text(
          'Menu',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );

    widgets.addAll(widget.widgets);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: widgets,
      ),
    );
  }
}
