import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/class_model.dart';
import '../models/term_model.dart';
import '../store/colors.dart';
import '../store/store.dart';
import 'class_terms.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String variable = "";
  String variableSess = "";

  String htName = "";
  int schoolKey;
  List<int> keys;

  Box<Class> classBox;
  Box<String> schoolBox;

  @override
  void initState() {
    super.initState();
    classBox = Hive.box<Class>("name");
    schoolBox = Hive.box<String>("school");
    if (schoolBox.isNotEmpty) {
      schoolKey = schoolBox.keyAt(0);
      MainStore.htName = schoolBox.get(schoolKey);
    }
    keys = classBox.keys.cast<int>().toList();
    for (int i = 0; i < keys.length; i++) {
      MainStore.classes.add(classBox.get(keys[i]));
    }
  }

  updateKeys() {
    keys.clear();
    keys = classBox.keys.cast<int>().toList();
  }

  @override
  void dispose() {
    super.dispose();
    classBox.close();
    schoolBox.close();
  }

  Future<bool> _onBack() async {
    bool goBack = true;
    SystemNavigator.pop();
    classBox.close();
    schoolBox.close();
    return goBack;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        backgroundColor: appBackground,
        body: SizedBox(
          height: double.maxFinite,
          child: Column(
            children: [
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'AGGO COLLEGE DB',
                            style: TextStyle(
                                color: Color.fromARGB(255, 221, 248, 252),
                                fontSize: 23,
                                fontWeight: FontWeight.w700,
                                shadows: [
                                  Shadow(
                                      color: Color.fromARGB(255, 37, 37, 37),
                                      blurRadius: 5.0,
                                      offset: Offset(1, 1))
                                ],
                                letterSpacing: 0.5),
                          ),
                          SizedBox(height: 1),
                          Text(
                            "An Automatic results computation platform.\nPowered by Virtous Children School, Gboko.",
                            style: TextStyle(
                                color: Color.fromARGB(255, 252, 253, 255),
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic),
                          ),
                          Text(
                            "Developed by the Orbital Node Tech Team 2022",
                            style: TextStyle(
                                color: Color.fromARGB(255, 236, 240, 252),
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 0.5),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: Color.fromARGB(255, 66, 247, 81)),
                margin: const EdgeInsets.only(left: 0, right: 0, top: 15),
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 7),
                child: const Text(
                  "SECONDARY SCHOOLS",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 0.5,
                width: double.maxFinite,
                color: const Color.fromARGB(255, 37, 29, 107),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Principal's Name",
                      style: TextStyle(
                        color: textColors,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(43, 173, 172, 172),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: borderColors)),
                            child: TextFormField(
                              onChanged: ((value) {
                                htName = value;
                              }),
                              cursorColor: Colors.black,
                              decoration: const InputDecoration.collapsed(
                                  hintText: "Enter Principal's Name"),
                              initialValue: schoolBox.isNotEmpty
                                  ? schoolBox.get(schoolKey)
                                  : "",
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'CANCEL',
                                style: TextStyle(color: popTextColors),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  if (schoolBox.isEmpty) {
                                    schoolBox.add(htName);
                                    MainStore.htName = htName;
                                  } else {
                                    schoolBox.put(schoolKey, htName);
                                    MainStore.htName = htName;
                                  }
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'SAVE',
                                style: TextStyle(color: popTextColors),
                              ),
                            ),
                          ],
                        );
                      });
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 0.5,
                            spreadRadius: 0.3)
                      ],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: borderColors, width: 0.3),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            schoolBox.isNotEmpty
                                ? schoolBox.get(schoolKey) ?? "No name yet"
                                : "No name yet",
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.0),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Tap to change",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () {
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: borderColors),
                              color: borderColors,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            Icons.refresh_rounded,
                            color: iconColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 20),
                    child: Text(
                      "Classes",
                      style: TextStyle(
                        color: textColors,
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: MainStore.classes.isEmpty
                      ? Center(
                          child: Text(
                            "You have not added any class yet.\nTap the button below to add a class.",
                            style: TextStyle(
                                fontSize: 15, height: 1.25, color: textColors),
                          ),
                        )
                      : ListView(
                          children: _listWidgets(),
                        ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: ListView(shrinkWrap: true, children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(43, 173, 172, 172),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: borderColors)),
                          child: TextFormField(
                            onChanged: ((value) {
                              variable = value;
                            }),
                            cursorColor: Colors.black,
                            decoration: const InputDecoration.collapsed(
                                hintText: "Enter Class Name"),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(43, 173, 172, 172),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: borderColors)),
                              child: TextFormField(
                                onChanged: ((value) {
                                  variableSess = value;
                                }),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration.collapsed(
                                    hintText: "Session"),
                              ),
                            ),
                          ],
                        ),
                      ]),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'CANCEL',
                            style: TextStyle(color: popTextColors),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              Class newClass = Class(variable, variableSess);
                              MainStore.classes.add(newClass);
                              classBox.add(newClass);
                              updateKeys();
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'SAVE',
                            style: TextStyle(color: popTextColors),
                          ),
                        ),
                      ],
                    );
                  });
            },
            label: Text("Add Class",
                style: TextStyle(
                  color: popTextColors,
                )),
            icon: Icon(
              Icons.add,
              color: popTextColors,
            ),
            backgroundColor: fabColor),
      ),
    );
  }

  _listWidget(String item, String session, int index) {
    for (int i = 0; i < 3; i++) {
      switch (i) {
        case 0:
          MainStore.classes[index].terms.add(TermClass("First Term"));
          break;
        case 1:
          MainStore.classes[index].terms.add(TermClass("Second Term"));
          break;
        case 2:
          MainStore.classes[index].terms.add(TermClass("Third Term"));
          break;
      }
    }
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Term(
                      className: item,
                      classKey: keys[index],
                      index: index,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: double.maxFinite,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: Colors.black, blurRadius: 0.5, spreadRadius: 0.3)
            ],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: borderColors, width: 0.3),
            color: Colors.white),
        child: Row(
          children: [
            Text(
              "$item ($session)",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(child: Container()),
            InkWell(
              onLongPress: () {
                setState(() {
                  MainStore.classes.removeAt(index);
                  classBox.delete(keys[index]);
                  updateKeys();
                });
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: borderColors),
                    color: borderColors,
                    borderRadius: BorderRadius.circular(20)),
                child: Icon(
                  Icons.delete,
                  color: iconColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _listWidgets() {
    List<Widget> temp = [];

    for (int i = 0; i < MainStore.classes.length; i++) {
      temp.add(_listWidget(
          MainStore.classes[i].className, MainStore.classes[i].session, i));
    }
    return temp;
  }
}

/* 
*** Hive adaptor generator codes ***
flutter packages pub run build_runner build
 */