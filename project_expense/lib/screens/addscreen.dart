// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_expense/Constants/colorconst.dart';
import 'package:project_expense/Constants/textconst.dart';
import 'package:project_expense/screens/homescreen.dart';
import '../Widget/cusbutton.dart';
import '../Widget/date.dart';
import '../Widget/textfield.dart';
import '../Widget/time.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  CollectionReference exp =
      FirebaseFirestore.instance.collection(TextConst.expensetracker);

  Future<void> add() {
    return exp
        .add(
          {
            TextConst.title: titleController.text,
            TextConst.description: descripController.text,
            TextConst.date: dateController.text,
            TextConst.time: timeController.text,
            TextConst.dropdown: dropdownvalue,
            TextConst.amount: amountController.text,
            TextConst.uid: FirebaseAuth.instance.currentUser?.uid
          },
        )
        .then((value) => print(TextConst.done))
        .catchError((error) => print(TextConst.error));
  }

  var choice = [TextConst.income, TextConst.expense];
  var dropdownvalue = TextConst.income;
  TextEditingController titleController = TextEditingController();
  TextEditingController descripController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (titleController.text != '' &&
                descripController.text != '' &&
                dateController.text != '' &&
                timeController.text != '' &&
                amountController.text != '') {
              add();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            } else {
              return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(TextConst.alert),
                    content: Text(TextConst.msg3),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          TextConst.ok,
                          style: TextStyle(
                            color: Color(ClrConst.bluegrey),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: const Icon(Icons.check),
        ),
        backgroundColor: Color(ClrConst.clr1),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: CusTextField(
                    w: 0.9,
                    h: 0.14,
                    k: TextInputType.multiline,
                    d: true,
                    c: titleController,
                    max: 1,
                    min: 1,
                    i: 30,
                    text: TextConst.title2),
              ),
              CusTextField(
                  w: 0.9,
                  h: 0.42,
                  k: TextInputType.multiline,
                  d: true,
                  c: descripController,
                  max: 6,
                  min: 6,
                  i: 100,
                  text: TextConst.description2),
              CusDate(
                textFieldHint: TextConst.date,
                cont: dateController,
              ),
              CusTime(
                textFieldHint: TextConst.time,
                time: timeController,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Color(ClrConst.white),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: dropdownvalue,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(ClrConst.bluegrey),
                        ),
                        items: choice.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: TextStyle(
                                  color: Color(ClrConst.lightshadegray)),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownvalue = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: CusTextField(
                    w: 0.9,
                    h: 0.14,
                    k: TextInputType.none,
                    d: true,
                    c: amountController,
                    max: 1,
                    min: 1,
                    i: null,
                    text: TextConst.amount2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 1; i <= 3; i++)
                    CusButton(
                      number: i,
                      onPressed: () {
                        var cursorPos = amountController.selection.base.offset;
                        if (cursorPos > 0) {
                          String suffixText =
                              amountController.text.substring(cursorPos);

                          String prefixText =
                              amountController.text.substring(0, cursorPos);

                          amountController.text =
                              prefixText + i.toString() + suffixText;

                          amountController.selection = TextSelection(
                            baseOffset: cursorPos + 1,
                            extentOffset: cursorPos + 1,
                          );
                        } else {
                          amountController.text += i.toString();
                        }
                      },
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 4; i <= 6; i++)
                    CusButton(
                      number: i,
                      onPressed: () {
                        var cursorPos = amountController.selection.base.offset;
                        if (cursorPos > 0) {
                          String suffixText =
                              amountController.text.substring(cursorPos);

                          String prefixText =
                              amountController.text.substring(0, cursorPos);

                          amountController.text =
                              prefixText + i.toString() + suffixText;

                          amountController.selection = TextSelection(
                            baseOffset: cursorPos + 1,
                            extentOffset: cursorPos + 1,
                          );
                        } else {
                          amountController.text += i.toString();
                        }
                      },
                    ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (int i = 7; i <= 9; i++)
                  CusButton(
                    number: i,
                    onPressed: () {
                      var cursorPos = amountController.selection.base.offset;
                      if (cursorPos > 0) {
                        String suffixText =
                            amountController.text.substring(cursorPos);

                        String prefixText =
                            amountController.text.substring(0, cursorPos);

                        amountController.text =
                            prefixText + i.toString() + suffixText;

                        amountController.selection = TextSelection(
                          baseOffset: cursorPos + 1,
                          extentOffset: cursorPos + 1,
                        );
                      } else {
                        amountController.text += i.toString();
                      }
                    },
                  ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CusButton(
                      number: 0,
                      onPressed: () {
                        var cursorPos = amountController.selection.base.offset;
                        if (cursorPos > 0) {
                          String suffixText =
                              amountController.text.substring(cursorPos);

                          String prefixText =
                              amountController.text.substring(0, cursorPos);

                          amountController.text =
                              prefixText + 0.toString() + suffixText;

                          amountController.selection = TextSelection(
                            baseOffset: cursorPos + 1,
                            extentOffset: cursorPos + 1,
                          );
                        } else {
                          amountController.text += 0.toString();
                        }
                      }),
                  ElevatedButton(
                    onPressed: () {
                      amountController.text = amountController.text
                          .substring(0, amountController.text.length - 1);
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(10),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(
                        const Size(130, 40),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Color(ClrConst.red),
                      ),
                    ),
                    child: Text(TextConst.delete),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
