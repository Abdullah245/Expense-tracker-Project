// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.14,
            child: IconButton(
              onPressed: pickTime,
              icon: const Icon(
                Icons.access_time,
                size: 25,
                color: Colors.blueGrey,
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
                  fillColor: Colors.white,
                  filled: true,
                  hintText: widget.textFieldHint,
                  hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
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
          title: const Text("No Time Selected"),
          actions: [
            TextButton(
              onPressed: (() => Navigator.pop(context)),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }
  }
}
