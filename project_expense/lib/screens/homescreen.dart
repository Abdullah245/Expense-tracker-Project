// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_expense/Constants/colorconst.dart';
import 'package:project_expense/Constants/textconst.dart';
import '../Class/exp.dart';
import 'addscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int key = 0;
  late List<ExpenseClass> _exp = [];
  Map<String, double> getData() {
    Map<String, double> catchMap = {};
    for (var item in _exp) {
      if (catchMap.containsKey(item.dropDownValue) == false) {
        catchMap[item.dropDownValue] = double.parse(item.amount);
      } else {
        catchMap.update(
            item.dropDownValue,
            (String) =>
                catchMap[item.dropDownValue]! + double.parse(item.amount));
      }
    }
    return catchMap;
  }

  Widget pieChartExampleOne() {
    return PieChart(
      colorList: [
        Color(ClrConst.red),
        Color(ClrConst.green),
      ],
      chartValuesOptions: const ChartValuesOptions(showChartValues: false),
      key: ValueKey(key),
      dataMap: getData(),
      animationDuration: const Duration(milliseconds: 1000),
      chartType: ChartType.ring,
      chartRadius: MediaQuery.of(context).size.width / 3,
      ringStrokeWidth: 12,
      chartLegendSpacing: 30,
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendPosition: LegendPosition.right,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> exp = FirebaseFirestore.instance
        .collection(TextConst.expensetracker)
        .where(TextConst.uid, isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .orderBy(TextConst.time, descending: true)
        .orderBy(TextConst.date, descending: true);
    void getExpfromSanapshot(snapshot) {
      if (snapshot.docs.isNotEmpty) {
        _exp = [];
        for (int i = 0; i < snapshot.docs.length; i++) {
          var a = snapshot.docs[i];
          ExpenseClass exp = ExpenseClass.fromMap(a.data());
          _exp.add(exp);
        }
      }
    }

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(elevation: MaterialStateProperty.all(10)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddScreen()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.add,
                        size: 15,
                      ),
                      Text(TextConst.add),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: exp.get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.requireData;
                  getExpfromSanapshot(data);
                  return Column(
                    children: [
                      pieChartExampleOne(),
                      Expanded(
                        child: ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                          Map<String, dynamic> ab =
                              document.data()! as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.12,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  Color(ClrConst.clr2),
                                              radius: 22,
                                              child: ab[TextConst.dropdown] ==
                                                      TextConst.expense
                                                  ? Icon(
                                                      Icons.arrow_back,
                                                      color:
                                                          Color(ClrConst.red),
                                                      size: 30,
                                                    )
                                                  : Icon(
                                                      Icons.arrow_forward,
                                                      color: Color(
                                                          ClrConst.lightgreen),
                                                      size: 30,
                                                    ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .4,
                                                    child: Text(
                                                      ab[TextConst.title],
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Color(
                                                              ClrConst.black1)),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .4,
                                                    child: Text(
                                                      ab[TextConst.description],
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color(
                                                              ClrConst.black2)),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${ab[TextConst.date]} at ${ab[TextConst.time]}',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: Color(
                                                          ClrConst.black3),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                ab[TextConst.amount],
                                                style: TextStyle(
                                                  color: Color(ClrConst.black1),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                          );
                        }).toList()),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    ));
  }
}
