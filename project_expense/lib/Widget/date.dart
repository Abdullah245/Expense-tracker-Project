// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_expense/Constants/colorconst.dart';
import 'package:project_expense/Constants/textconst.dart';

// ignore: must_be_immutable
class CusDate extends StatefulWidget {
  var textFieldHint;
  var cont;
  CusDate({Key? key, required this.textFieldHint, required this.cont})
      : super(key: key);

  @override
  State<CusDate> createState() => _CusDateState();
}

class _CusDateState extends State<CusDate> {
  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(ClrConst.white),
            ),
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.14,
            child: IconButton(
              onPressed: pickdate,
              icon: Icon(
                Icons.calendar_month,
                size: 25,
                color: Color(ClrConst.bluegrey2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.72,
              height: MediaQuery.of(context).size.height * 0.07,
              child: TextFormField(
                minLines: 1,
                maxLines: 1,
                controller: widget.cont,
                readOnly: true,
                onTap: pickdate,
                decoration: InputDecoration(
                  fillColor: Color(ClrConst.white),
                  filled: true,
                  hintText: widget.textFieldHint,
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Color(ClrConst.lightshadegray),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  pickdate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime.now());
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd MMM, yyyy').format(pickedDate);
      setState(() {
        widget.cont.text = formattedDate;
      });
    } else {
      return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(TextConst.msg1),
          actions: [
            TextButton(
              onPressed: (() => Navigator.pop(context)),
              child: Text(TextConst.ok),
            ),
          ],
        ),
      );
    }
  }
}
