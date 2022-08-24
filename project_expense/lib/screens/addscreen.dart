// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      FirebaseFirestore.instance.collection('expense_tracker');

  Future<void> add() {
    
    return exp
        .add({
          'title': titleController.text,
          'descrip': descripController.text,
          'date': dateController.text,
          'time': timeController.text,
          'dropdown': dropdownvalue,
          'amount': amountController.text,
          'uid': FirebaseAuth.instance.currentUser?.uid
        },)
        .then((value) => print("Done"))
        .catchError((error) => print("couldn't be added."));
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
                      title: const Text('Alert'),
                      content: Text(TextConst.alert),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Ok',
                              style: TextStyle(color: Colors.blueGrey),
                            ),),
                      ],
                    );
                  },);
            }
          },
          child: Icon(Icons.check),
        ),
        backgroundColor: Color(0xFFC9CCCE),
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
                    text: "Title"),
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
                  text: "Description"),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: dropdownvalue,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.blueGrey,
                        ),
                        items: choice.map((String items){
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items,
                              // TextConst.expense,
                              style: TextStyle(color: Colors.grey),
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
                    text: "Amount"),
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
                    child: Text(TextConst.delete),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(10),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(
                        Size(130, 40),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
