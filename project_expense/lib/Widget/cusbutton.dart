// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:project_expense/Constants/colorconst.dart';

class CusButton extends StatefulWidget {
  final int number;
  final Function()? onPressed;

  CusButton({
    Key? key,
    required this.number,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CusButton> createState() => _CusButtonState();
}

class _CusButtonState extends State<CusButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, right: 5),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(10),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          fixedSize: MaterialStateProperty.all(
            const Size.square(40),
          ),
          backgroundColor: MaterialStateProperty.all(
            Color(ClrConst.white),
          ),
        ),
        child: Text(
          widget.number.toString(),
          style: TextStyle(
            color: Color(ClrConst.bluegrey2),
          ),
        ),
      ),
    );
  }
}
