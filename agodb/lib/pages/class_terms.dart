import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/annual_students_model.dart';
import '../models/annual_subjects_model.dart';
import '../models/class_model.dart';
import '../store/colors.dart';
import '../store/store.dart';
import 'class_terms_inner/annual.dart';
import 'class_terms_inner/term_hub.dart';

class Term extends StatefulWidget {
  final String className;
  final int classKey;
  final int index;

  const Term({Key key, this.className, this.classKey, this.index})
      : super(key: key);

  @override
  State<Term> createState() => _TermState();
}

class _TermState extends State<Term> {
  String ftName = "";
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
                    widget.className,
                    style: TextStyle(
                        color: textColors,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5),
                  ),
                  Expanded(child: Container()),
                  /*  const Icon(
                    Icons.more_vert_rounded,
                    size: 24,
                  ), */
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
              child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Form Teacher's Name",
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
                  if (MainStore.classes.isNotEmpty) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(43, 173, 172, 172),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: borderColors)),
                              child: TextFormField(
                                onChanged: ((value) {
                                  ftName = value;
                                }),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration.collapsed(
                                    hintText: "Enter Form Teacher's Name"),
                                initialValue:
                                    MainStore.classes[widget.index].ftName ??
                                        "",
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
                                    MainStore.classes[widget.index].ftName =
                                        ftName;
                                    classBox.put(widget.classKey,
                                        MainStore.classes[widget.index]);
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
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          "You need to create atleast one Class before you can save the Head teacher's name."),
                    ));
                  }
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
                            MainStore.classes[widget.index].ftName ??
                                "No name yet",
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
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 20, bottom: 10),
                    child: Text(
                      "Terms",
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassPage(
                              name: widget.className,
                              classKey: widget.classKey,
                              classIndex: widget.index,
                              termName: "First Term",
                              termIndex: 0)));
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
                            spreadRadius: 0.5)
                      ],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: borderColors, width: 0.5),
                      color: Colors.white),
                  child: const Text(
                    "First Term",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassPage(
                              name: widget.className,
                              classKey: widget.classKey,
                              classIndex: widget.index,
                              termName: "Second Term",
                              termIndex: 1)));
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
                            spreadRadius: 0.5)
                      ],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: borderColors, width: 0.5),
                      color: Colors.white),
                  child: const Text(
                    "Second Term",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassPage(
                              name: widget.className,
                              classKey: widget.classKey,
                              classIndex: widget.index,
                              termName: "Third Term",
                              termIndex: 2)));
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
                            spreadRadius: 0.5)
                      ],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: borderColors, width: 0.5),
                      color: Colors.white),
                  child: const Text(
                    "Third Term",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (!checkNames()) {
                    if (emptyField()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Empty fields detected in one of the term's assessments. Please ensure that you fill in every required information before atempting to display results."),
                        ),
                      );
                    } else {
                      if (MainStore.annualCompiled == false) {
                        _computeAnnualResults();
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnnualPage(
                                    classIndex: widget.index,
                                  )));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "All terms must contain exactly the same students before annual results can be compiled. Please read the user manual of the app for more information ")));
                  }
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
                          spreadRadius: 0.5)
                    ],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: borderColors, width: 0.5),
                    color: Colors.white,
                  ),
                  child: const Text(
                    "Annual Results",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  _computeAnnualResults() {
    MainStore.annualCompiled = true;
    _addStudentsAnnualToClass();
    _addSubjectsAnnualToEachStudent();
    _setTermTotalForESubPStud();
    _computeYearTotalForESubPStud();
    _computeYearAverageForESubPStud();
    _computeYearPositionForESubPStud();
    _computeHighestForESubPStud();
    _computeLowestForESubPStud();
    _computeoverAllTotalForEStud();
    _computeoverAllAverageForEStud();
    _computeoverAllPositionForEStud();
  }

  _addStudentsAnnualToClass() {
    // Just to be sure
    MainStore.classes[widget.index].studentsAnnual.clear();

    List<String> annualStudentNames = [];

    List<StudentAnnual> annualStudents = [];

    for (int i = 0;
        i < MainStore.classes[widget.index].terms[2].students.length;
        i++) {
      annualStudentNames
          .add(MainStore.classes[widget.index].terms[2].students[i].name);
    }

    List<String> annualStudentNamesTrimmed =
        LinkedHashSet<String>.from(annualStudentNames).toList();

    for (int i = 0; i < annualStudentNamesTrimmed.length; i++) {
      annualStudents.add(StudentAnnual(annualStudentNamesTrimmed[i]));
    }

    MainStore.classes[widget.index].studentsAnnual.addAll(annualStudents);
  }

  _addSubjectsAnnualToEachStudent() {
    for (int i = 0;
        i < MainStore.classes[widget.index].studentsAnnual.length;
        i++) {
      for (int j = 0;
          j < MainStore.classes[widget.index].terms[2].subjects.length;
          j++) {
        MainStore.classes[widget.index].studentsAnnual[i].subjects.add(
            SubjectAnnual(
                MainStore.classes[widget.index].terms[2].subjects[j]));
      }
    }
  }

  _setTermTotalForESubPStud() {
    for (int i = 0;
        i < MainStore.classes[widget.index].studentsAnnual.length;
        i++) {
      for (int j = 0;
          j < MainStore.classes[widget.index].studentsAnnual[i].subjects.length;
          j++) {
        for (int k = 0; k < 3; k++) {
          MainStore.classes[widget.index].studentsAnnual[i].subjects[j]
                  .termTotal[k] =
              MainStore
                  .classes[widget.index].terms[k].students[i].subjects[j].total;
        }
      }
    }
  }

  _computeYearTotalForESubPStud() {
    int yearTotal = 0;
    for (int i = 0;
        i < MainStore.classes[widget.index].studentsAnnual.length;
        i++) {
      for (int j = 0;
          j < MainStore.classes[widget.index].studentsAnnual[i].subjects.length;
          j++) {
        for (int k = 0; k < 3; k++) {
          yearTotal += MainStore
              .classes[widget.index].studentsAnnual[i].subjects[j].termTotal[k];
        }
        MainStore.classes[widget.index].studentsAnnual[i].subjects[j]
            .yearTotal = yearTotal;
        yearTotal = 0;
      }
    }
  }

  _computeYearAverageForESubPStud() {
    for (int i = 0;
        i < MainStore.classes[widget.index].studentsAnnual.length;
        i++) {
      for (int j = 0;
          j < MainStore.classes[widget.index].studentsAnnual[i].subjects.length;
          j++) {
        MainStore.classes[widget.index].studentsAnnual[i].subjects[j].average =
            MainStore.classes[widget.index].studentsAnnual[i].subjects[j]
                    .yearTotal
                    .toDouble() /
                3.0;
      }
    }
  }

  _computeYearPositionForESubPStud() {
    List<String> sortedNames = [];
    List<SubPosList> namedScores = [];

    for (int b = 0;
        b < MainStore.classes[widget.index].studentsAnnual[0].subjects.length;
        b++) {
      for (int s = 0;
          s < MainStore.classes[widget.index].studentsAnnual.length;
          s++) {
        namedScores.add(SubPosList(
            MainStore.classes[widget.index].studentsAnnual[s].name,
            MainStore.classes[widget.index].studentsAnnual[s].subjects[b]
                .yearTotal));
      }
      namedScores.sort(((a, b) => b.subTotal.compareTo(a.subTotal)));

      for (int s = 0;
          s < MainStore.classes[widget.index].studentsAnnual.length;
          s++) {
        sortedNames.add(namedScores[s].studentName);
      }

      for (int s = 0;
          s < MainStore.classes[widget.index].studentsAnnual.length;
          s++) {
        MainStore.classes[widget.index].studentsAnnual[s].subjects[b].position =
            sortedNames.indexOf(
                    MainStore.classes[widget.index].studentsAnnual[s].name) +
                1;
      }
      namedScores.clear();
      sortedNames.clear();
    }
  }

  _computeHighestForESubPStud() {
    for (int i = 0;
        i < MainStore.classes[widget.index].studentsAnnual.length;
        i++) {
      for (int j = 0;
          j < MainStore.classes[widget.index].studentsAnnual[0].subjects.length;
          j++) {
        for (int k = 0;
            k < MainStore.classes[widget.index].studentsAnnual.length;
            k++) {
          if (MainStore.classes[widget.index].studentsAnnual[k].subjects[j]
                  .position ==
              1) {
            MainStore.classes[widget.index].studentsAnnual[i].subjects[j]
                    .higestInClass =
                MainStore.classes[widget.index].studentsAnnual[k].subjects[j]
                    .yearTotal;
            break;
          }
        }
      }
    }
  }

  _computeLowestForESubPStud() {
    for (int i = 0;
        i < MainStore.classes[widget.index].studentsAnnual.length;
        i++) {
      for (int j = 0;
          j < MainStore.classes[widget.index].studentsAnnual[0].subjects.length;
          j++) {
        for (int k = 0;
            k < MainStore.classes[widget.index].studentsAnnual.length;
            k++) {
          if (MainStore.classes[widget.index].studentsAnnual[k].subjects[j]
                  .position ==
              MainStore.classes[widget.index].studentsAnnual.length) {
            MainStore.classes[widget.index].studentsAnnual[i].subjects[j]
                    .loswetInClass =
                MainStore.classes[widget.index].studentsAnnual[k].subjects[j]
                    .yearTotal;
            break;
          }
        }
      }
    }
  }

  _computeoverAllTotalForEStud() {
    int overAllTotal = 0;
    for (int i = 0;
        i < MainStore.classes[widget.index].studentsAnnual.length;
        i++) {
      for (int j = 0;
          j < MainStore.classes[widget.index].studentsAnnual[0].subjects.length;
          j++) {
        overAllTotal += MainStore
            .classes[widget.index].studentsAnnual[i].subjects[j].yearTotal;
      }
      MainStore.classes[widget.index].studentsAnnual[i].overAllTotal =
          overAllTotal;
      overAllTotal = 0;
    }
  }

  _computeoverAllAverageForEStud() {
    for (int i = 0;
        i < MainStore.classes[widget.index].studentsAnnual.length;
        i++) {
      MainStore.classes[widget.index].studentsAnnual[i].overAllAverage =
          MainStore.classes[widget.index].studentsAnnual[i].overAllTotal
                  .toDouble() /
              (MainStore.classes[widget.index].studentsAnnual[0].subjects.length
                      .toDouble() *
                  3);
    }
  }

  _computeoverAllPositionForEStud() {
    List<StudentAnnual> sorted = [];
    sorted.addAll(MainStore.classes[widget.index].studentsAnnual);

    List<String> sortedNames = [];
    sorted.sort(((a, b) => b.overAllTotal.compareTo(a.overAllTotal)));
    for (int i = 0; i < sorted.length; i++) {
      sortedNames.add(sorted[i].name);
    }

    for (int i = 0;
        i < MainStore.classes[widget.index].studentsAnnual.length;
        i++) {
      MainStore.classes[widget.index].studentsAnnual[i].overAllPosition =
          sortedNames.indexOf(
                  MainStore.classes[widget.index].studentsAnnual[i].name) +
              1;
    }
  }

  bool emptyField() {
    bool isEmpty = false;
    for (int v = 0; v < 3; v++) {
      if (isEmpty) {
        break;
      } else {
        if (MainStore.classes[widget.index].terms[v].students.isEmpty ||
            MainStore.classes[widget.index].terms[v].subjects.isEmpty) {
          isEmpty = true;
        } else {
          for (int i = 0;
              i < MainStore.classes[widget.index].terms[v].students.length;
              i++) {
            if (isEmpty) {
              break;
            } else {
              if (MainStore.classes[widget.index].terms[v].students[i].subjects
                  .isEmpty) {
                isEmpty = true;
                break;
              } else {
                for (int j = 0;
                    j <
                        MainStore
                            .classes[widget.index].terms[v].subjects.length;
                    j++) {
                  if (isEmpty) {
                    break;
                  } else {
                    for (int k = 0; k < 2; k++) {
                      if (MainStore.classes[widget.index].terms[v].students[i]
                              .subjects[j].ass[k] ==
                          -1) {
                        isEmpty = true;
                        break;
                      } else {}
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    return isEmpty;
  }

  bool checkNames() {
    bool violation = true;
    if (MainStore.classes[widget.index].terms[0].students.length ==
            MainStore.classes[widget.index].terms[1].students.length &&
        MainStore.classes[widget.index].terms[1].students.length ==
            MainStore.classes[widget.index].terms[2].students.length) {
      for (int i = 0;
          i < MainStore.classes[widget.index].terms[0].students.length;
          i++) {
        if (MainStore.classes[widget.index].terms[0].students[i].name ==
                MainStore.classes[widget.index].terms[1].students[i].name &&
            MainStore.classes[widget.index].terms[1].students[i].name ==
                MainStore.classes[widget.index].terms[2].students[i].name) {
          violation = false;
        } else {
          violation = true;
          break;
        }
      }
      return violation;
    } else {
      return violation;
    }
  }
}
