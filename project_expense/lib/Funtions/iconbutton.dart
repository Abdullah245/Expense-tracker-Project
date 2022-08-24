import 'package:flutter/material.dart';

iconbutton() {
  return Container(
    padding: EdgeInsets.all(4.7),
    margin: EdgeInsets.only(bottom: 14.5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
    ),
    child: IconButton(
      onPressed: () {},
      icon: Icon(Icons.watch_rounded),
      color: Colors.blueGrey,
      iconSize: 30,
    ),
  );
}
