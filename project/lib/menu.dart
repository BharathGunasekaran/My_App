import 'package:flutter/material.dart';

Drawer drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: const[
        DrawerHeader(
          child: Text(
            'This is Google Fonts',
            style: TextStyle(fontFamily: 'Times New Roman'),
          ),
        ),
        ListTile(
          leading: Text("1 page"),
        ),
        ListTile(
          leading: Text("1 page"),
        ),
        ListTile(
          leading: Text("1 page"),
        ),
        ListTile(
          leading: Text("1 page"),
        ),
      ],
    ),
  );
}
