// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable
import 'package:flutter/material.dart';
import 'package:project_expense/Constants/colorconst.dart';
import 'package:project_expense/Constants/textconst.dart';

class CusTime extends StatefulWidget {
  var textFieldHint;
  var time;
  CusTime({Key? key, required this.textFieldHint, required this.time})
      : super(key: key);

  @override
  State<CusTime> createState() => _CusTimeState();
}

class _CusTimeState extends State<CusTime> {
  late TimeOfDay selectedTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(ClrConst.white),
              borderRadius: BorderRadius.circular(10),
            ),
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.14,
            child: IconButton(
              onPressed: pickTime,
              icon: Icon(
                Icons.access_time,
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
                controller: widget.time,
                readOnly: true,
                onTap: pickTime,
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

  pickTime() async {
    TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (timeOfDay != null) {
      setState(() {
        String formattedTime = timeOfDay.format(context);
        widget.time.text = formattedTime;
      });
    } else {
      return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(TextConst.msg2),
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
