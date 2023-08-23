import 'package:agodb/models/subject_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/class_model.dart';
import '../../models/student_model.dart';
import '../../store/colors.dart';
import '../../store/store.dart';

class StudentsPage extends StatefulWidget {
  final String className;
  final int classKey;
  final int classIndex;
  final int termIndex;

  const StudentsPage(
      {Key key, this.className, this.classKey, this.classIndex, this.termIndex})
      : super(key: key);

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  String variableN = "";
  String variableA = "";

  Box<Class> classBox;

  @override
  void initState() {
    super.initState();
    classBox = Hive.box<Class>("name");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      body: Column(
        children: [
          SafeArea(
            child: SizedBox(
              width: double.maxFinite,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 20, left: 15, bottom: 20, right: 5),
                      child: Icon(
                        Icons.arrow_back,
                        color: iconColor,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${widget.className} Students",
                    style: TextStyle(
                        color: textColors,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.1),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 0.5,
            width: double.maxFinite,
            color: const Color.fromARGB(255, 37, 29, 107),
          ),
          Expanded(
            child: MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students.isEmpty
                ? Center(
                    child: Text(
                      "You have not added any student's info yet.\nClick on the button below to add.",
                      style: TextStyle(
                          fontSize: 15, height: 1.25, color: textColors),
                    ),
                  )
                : ListView(
                    children: _listWidgets(MainStore.classes[widget.classIndex]
                        .terms[widget.termIndex].students),
                  ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Store.sex = "Male";
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: AlertDialog(
                      content: Flex(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          direction: Axis.vertical,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(43, 173, 172, 172),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: borderColors, width: 0.5)),
                              child: TextFormField(
                                onChanged: ((value) {
                                  variableN = value;
                                }),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration.collapsed(
                                    hintText: "Enter Student's Name"),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.18,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(43, 173, 172, 172),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: borderColors, width: 0.5)),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    onChanged: ((value) {
                                      variableA = value;
                                    }),
                                    cursorColor: Colors.black,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: "Age"),
                                  ),
                                ),
                                Expanded(child: Container()),
                                const Drop()
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Uncheck whichever subject does not apply to student.",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.33,
                                child: Check(
                                  classIndex: widget.classIndex,
                                  termIndex: widget.termIndex,
                                ))
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
                              MainStore.classes[widget.classIndex]
                                  .terms[widget.termIndex].students
                                  .add(Student(
                                      variableN.toUpperCase().trim(),
                                      Store.sex,
                                      variableA,
                                      MainStore.classes[widget.classIndex]
                                          .terms[widget.termIndex].students.length
                                          .toString(),
                                      _grabTheSubjects()));
                  
                              classBox.put(widget.classKey,
                                  MainStore.classes[widget.classIndex]);
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'ADD',
                            style: TextStyle(color: popTextColors),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          label: Text("Add Student",
              style: TextStyle(
                color: popTextColors,
              )),
          icon: Icon(
            Icons.add,
            color: popTextColors,
          ),
          backgroundColor: fabColor),
    );
  }

  _listWidget(String item, String sex, String age, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        width: double.maxFinite,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: Colors.black, blurRadius: 0.5, spreadRadius: 0.5)
            ],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColors, width: 0.5),
            color: Colors.white),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Sex: $sex",
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "|",
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Age: $age",
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(child: Container()),
            InkWell(
              onLongPress: () {
                setState(() {
                  MainStore.classes[widget.classIndex].terms[widget.termIndex]
                      .students
                      .removeAt(index);

                  classBox.put(
                      widget.classKey, MainStore.classes[widget.classIndex]);
                });
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border.all(color: borderColors, width: 0.5),
                    color: borderColors,
                    borderRadius: BorderRadius.circular(20)),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _listWidgets(List<Student> students) {
    List<Widget> temp = [];

    for (int i = 0; i < students.length; i++) {
      temp.add(_listWidget(
          students[i].name, students[i].gender, students[i].age, i));
    }
    return temp;
  }

// Utility . . .
  _grabTheSubjects() {
    List<Subject> selectedSubjects = [];
    for (int i = 0; i < Store.subjectsState.length; i++) {
      if (Store.subjectsState[i] == true) {
        selectedSubjects.add(Subject(MainStore
            .classes[widget.classIndex].terms[widget.termIndex].subjects[i]));
      }
    }
    return selectedSubjects;
  }
}

class Store {
  static String sex = "Male";
  static List<bool> subjectsState = [];
}

class Check extends StatefulWidget {
  final int classIndex;
  final int termIndex;
  const Check({Key key, this.classIndex, this.termIndex}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  void initState() {
    super.initState();
    Store.subjectsState.clear();
    for (int i = 0;
        i <
            MainStore.classes[widget.classIndex].terms[widget.termIndex]
                .subjects.length;
        i++) {
      Store.subjectsState.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> subs = [];
    for (int i = 0;
        i <
            MainStore.classes[widget.classIndex].terms[widget.termIndex]
                .subjects.length;
        i++) {
      subs.add(Row(
        children: [
          Checkbox(
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.orange.withOpacity(.32);
                }
                return Colors.orange;
              }),
              checkColor: Colors.white,
              value: Store.subjectsState[i],
              onChanged: ((value) {
                setState(() {
                  Store.subjectsState[i] = value;
                });
              })),
          const SizedBox(
            width: 10,
          ),
          Text(MainStore
              .classes[widget.classIndex].terms[widget.termIndex].subjects[i])
        ],
      ));
    }
    return ListView(children: subs);
  }
}

class Drop extends StatefulWidget {
  const Drop({Key key}) : super(key: key);

  @override
  State<Drop> createState() => _DropState();
}

class _DropState extends State<Drop> {
  String dropdownvalue = 'Male';
  var items = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        underline: Container(),
        value: dropdownvalue,
        icon: const Icon(Icons.arrow_drop_down_rounded),
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          );
        }).toList(),
        onChanged: (String newValue) {
          setState(() {
            dropdownvalue = newValue;
            Store.sex = newValue;
          });
        });
  }
}
