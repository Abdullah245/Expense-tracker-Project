import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CusTextField extends StatelessWidget {
  var w;
  var h;
  var k;
  var d;
  var c;
  var max;
  var min;
  var i;
  var text;

  CusTextField({
    Key? key,
    required this.w,
    required this.h,
    required this.k,
    required this.d,
    required this.c,
    required this.max,
    required this.min,
    required this.i,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * w,
      height: MediaQuery.of(context).size.width * h,
      child: TextField(
        showCursor: d,
        controller: c,
        keyboardType: k,
        maxLines: max,
        minLines: min,
        inputFormatters: [LengthLimitingTextInputFormatter(i)],
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
