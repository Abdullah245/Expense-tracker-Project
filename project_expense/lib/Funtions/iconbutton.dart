import 'package:flutter/material.dart';
import 'package:project_expense/Constants/colorconst.dart';

iconbutton() {
  return Container(
    padding: const EdgeInsets.all(4.7),
    margin: const EdgeInsets.only(bottom: 14.5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Color(ClrConst.white),
    ),
    child: IconButton(
      onPressed: () {},
      icon: const Icon(Icons.watch_rounded),
      color: Color(ClrConst.bluegrey2),
      iconSize: 30,
    ),
  );
}
