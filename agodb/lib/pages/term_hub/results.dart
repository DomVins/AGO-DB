import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/class_model.dart';
import '../../models/student_model.dart';
import '../../store/colors.dart';
import '../../store/store.dart';
import 'results_inner/score_sheets.dart';
import 'results_inner/show_result.dart';

class Results extends StatefulWidget {
  final String className;
  final int classKey;
  final int classIndex;
  final int termIndex;

  const Results(
      {Key key, this.className, this.classKey, this.classIndex, this.termIndex})
      : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
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
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
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
                        "Results",
                        style: TextStyle(
                            color: textColors,
                            fontSize: 22,
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
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  if (emptyField()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Empty fields detected. Please ensure that you fill in every required information before atempting to display results.'),
                      ),
                    );
                  } else {
                    _computeResults();
                    classBox.put(
                        widget.classKey, MainStore.classes[widget.classIndex]);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScoreSheets(
                                  classIndex: widget.classIndex,
                                  termIndex: widget.termIndex,
                                )));
                  }
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 0.5,
                            spreadRadius: 0.5)
                      ],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderColors, width: 0.5),
                      color: Colors.white),
                  child: const Text(
                    "Master Score Sheet",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (emptyField()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Empty fields detected. Please ensure that you fill in every required information before atempting to display results.'),
                      ),
                    );
                  } else {
                    _computeResults();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowResult(
                                  index: widget.classIndex,
                                  termIndex: widget.termIndex,
                                )));
                  }
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 0.5,
                            spreadRadius: 0.5)
                      ],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderColors, width: 0.5),
                      color: Colors.white),
                  child: const Text(
                    "Preview Students Results",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _computeResults() {
    // Subjects total score . . .
    _subjectTotal();

    // Term total score . . .
    _termTotal();

    // Term position . . .
    _termPosition();

    // Term average . . .
    _termAverage();

    // Subject position . . .
    _subjectPosition();

    // Subject average . . .
    _subjectAverage();

    // Subject grade . . .
    _subjectGrade();

    // Highest in class . . .
    _highest();

    // Lowest in class . . .
    _lowest();

    // Term Remarks . . .
    _remarks();
  }

  _remarks() {
    for (int i = 0;
        i <
            MainStore.classes[widget.classIndex].terms[widget.termIndex]
                .students.length;
        i++) {
      if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[i].average >
              80 &&
          MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[i].average <=
              100) {
        MainStore.classes[widget.classIndex].terms[widget.termIndex].students[i]
            .remark = "An Outstanding result. Keep it up.";
      } else if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[i].average >
              74 &&
          MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[i].average <
              80) {
        MainStore.classes[widget.classIndex].terms[widget.termIndex].students[i]
            .remark = "An Excellent Performance. Keep it up.";
      } else if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[i].average >
              64 &&
          MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[i].average <
              75) {
        MainStore.classes[widget.classIndex].terms[widget.termIndex].students[i]
            .remark = "A very Good Result.";
      } else if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[i].average >
              49 &&
          MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[i].average <
              65) {
        MainStore.classes[widget.classIndex].terms[widget.termIndex].students[i]
            .remark = "A Good Performance. You can do better.";
      } else if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[i].average >
              40 &&
          MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[i].average <
              50) {
        MainStore.classes[widget.classIndex].terms[widget.termIndex].students[i]
            .remark = "A fair performance. Improve next time.";
      } else if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[i].average >=
              0 &&
          MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[i].average <=
              40) {
        MainStore.classes[widget.classIndex].terms[widget.termIndex].students[i]
            .remark = "Poor result. Sit up.";
      }
    }
  }

  _highest() {
    for (int i = 0;
        i <
            MainStore.classes[widget.classIndex].terms[widget.termIndex]
                .students.length;
        i++) {
      for (int j = 0;
          j <
              MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[i].subjects.length;
          j++) {
        for (int k = 0;
            k <
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students.length;
            k++) {
          for (int l = 0;
              l <
                  MainStore.classes[widget.classIndex].terms[widget.termIndex]
                      .students[k].subjects.length;
              l++) {
            if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[k].subjects[l].name ==
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[i].subjects[j].name) {
              if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                      .students[k].subjects[l].pos ==
                  1) {
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                        .students[i].subjects[j].highest =
                    MainStore.classes[widget.classIndex].terms[widget.termIndex]
                        .students[k].subjects[l].total;
              }
              break;
            }
          }
        }
      }
    }
  }

  _lowest() {
    int takers = 0;
    for (int i = 0;
        i <
            MainStore.classes[widget.classIndex].terms[widget.termIndex]
                .students.length;
        i++) {
      for (int j = 0;
          j <
              MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[i].subjects.length;
          j++) {
        // Takers . . .
        for (int innerStd = 0;
            innerStd <
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students.length;
            innerStd++) {
          for (int sub2 = 0;
              sub2 <
                  MainStore.classes[widget.classIndex].terms[widget.termIndex]
                      .students[innerStd].subjects.length;
              sub2++) {
            if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[innerStd].subjects[sub2].name ==
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[i].subjects[j].name) {
              takers++;
              break;
            }
          }
        }
        for (int k = 0;
            k <
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students.length;
            k++) {
          for (int l = 0;
              l <
                  MainStore.classes[widget.classIndex].terms[widget.termIndex]
                      .students[k].subjects.length;
              l++) {
            if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[k].subjects[l].name ==
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[i].subjects[j].name) {
              if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                      .students[k].subjects[l].pos ==
                  takers) {
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                        .students[i].subjects[j].lowest =
                    MainStore.classes[widget.classIndex].terms[widget.termIndex]
                        .students[k].subjects[l].total;
              }
              break;
            }
          }
        }
        takers = 0;
      }
    }
  }

  _subjectTotal() {
    int total = 0;
    for (int i = 0;
        i <
            MainStore.classes[widget.classIndex].terms[widget.termIndex]
                .students.length;
        i++) {
      for (int j = 0;
          j <
              MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[i].subjects.length;
          j++) {
        for (int k = 0; k < 4; k++) {
          total += MainStore.classes[widget.classIndex].terms[widget.termIndex]
              .students[i].subjects[j].ass[k];
        }
        MainStore.classes[widget.classIndex].terms[widget.termIndex].students[i]
            .subjects[j].total = total;
        total = 0;
      }
    }
  }

  _subjectPosition() {
    List<String> sortedNames = [];
    List<SubPosList> namedScores = [];

    for (int std = 0;
        std <
            MainStore.classes[widget.classIndex].terms[widget.termIndex]
                .students.length;
        std++) {
      for (int sub = 0;
          sub <
              MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[std].subjects.length;
          sub++) {
        for (int innerStd = 0;
            innerStd <
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students.length;
            innerStd++) {
          for (int sub2 = 0;
              sub2 <
                  MainStore.classes[widget.classIndex].terms[widget.termIndex]
                      .students[innerStd].subjects.length;
              sub2++) {
            if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[innerStd].subjects[sub2].name ==
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[std].subjects[sub].name) {
              namedScores.add(SubPosList(
                  MainStore.classes[widget.classIndex].terms[widget.termIndex]
                      .students[innerStd].name,
                  MainStore.classes[widget.classIndex].terms[widget.termIndex]
                      .students[innerStd].subjects[sub2].total));
              break;
            }
          }
        }
        namedScores.sort(((a, b) => b.subTotal.compareTo(a.subTotal)));

        for (int innerStd2 = 0; innerStd2 < namedScores.length; innerStd2++) {
          sortedNames.add(namedScores[innerStd2].studentName);
        }

        MainStore.classes[widget.classIndex].terms[widget.termIndex]
            .students[std].subjects[sub]
            .setPos(sortedNames.indexOf(MainStore.classes[widget.classIndex]
                    .terms[widget.termIndex].students[std].name) +
                1);
        namedScores.clear();
        sortedNames.clear();
      }
    }
  }

  _termTotal() {
    int total = 0;
    for (int i = 0;
        i <
            MainStore.classes[widget.classIndex].terms[widget.termIndex]
                .students.length;
        i++) {
      for (int j = 0;
          j <
              MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[i].subjects.length;
          j++) {
        total += MainStore.classes[widget.classIndex].terms[widget.termIndex]
            .students[i].subjects[j].total;
      }
      MainStore.classes[widget.classIndex].terms[widget.termIndex].students[i]
          .total = total;
      total = 0;
    }
  }

  _termPosition() {
    List<Student> sorted = [];
    sorted.addAll(
        MainStore.classes[widget.classIndex].terms[widget.termIndex].students);

    List<String> sortedNames = [];
    sorted.sort(((a, b) => b.total.compareTo(a.total)));
    for (int i = 0; i < sorted.length; i++) {
      sortedNames.add(sorted[i].name);
    }

    for (int i = 0;
        i <
            MainStore.classes[widget.classIndex].terms[widget.termIndex]
                .students.length;
        i++) {
      MainStore.classes[widget.classIndex].terms[widget.termIndex].students[i]
          .position = sortedNames.indexOf(MainStore.classes[widget.classIndex]
              .terms[widget.termIndex].students[i].name) +
          1;
    }
  }

  _termAverage() {
    for (int i = 0;
        i <
            MainStore.classes[widget.classIndex].terms[widget.termIndex]
                .students.length;
        i++) {
      MainStore.classes[widget.classIndex].terms[widget.termIndex].students[i]
          .average = MainStore.classes[widget.classIndex]
              .terms[widget.termIndex].students[i].total
              .toDouble() /
          MainStore.classes[widget.classIndex].terms[widget.termIndex].subjects
              .length
              .toDouble();
    }
  }

  _subjectAverage() {
    double total = 0.0;
    int takers = 0;

    for (int std = 0;
        std <
            MainStore.classes[widget.classIndex].terms[widget.termIndex]
                .students.length;
        std++) {
      for (int sub = 0;
          sub <
              MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[std].subjects.length;
          sub++) {
        // Takers . . .
        for (int innerStd = 0;
            innerStd <
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students.length;
            innerStd++) {
          for (int sub2 = 0;
              sub2 <
                  MainStore.classes[widget.classIndex].terms[widget.termIndex]
                      .students[innerStd].subjects.length;
              sub2++) {
            if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[innerStd].subjects[sub2].name ==
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[std].subjects[sub].name) {
              takers++;
              break;
            }
          }
        }
        for (int innerStd = 0;
            innerStd <
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students.length;
            innerStd++) {
          for (int sub2 = 0;
              sub2 <
                  MainStore.classes[widget.classIndex].terms[widget.termIndex]
                      .students[innerStd].subjects.length;
              sub2++) {
            if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[innerStd].subjects[sub2].name ==
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[std].subjects[sub].name) {
              total += MainStore
                  .classes[widget.classIndex]
                  .terms[widget.termIndex]
                  .students[innerStd]
                  .subjects[sub2]
                  .total;
              break;
            }
          }
        }
        MainStore
            .classes[widget.classIndex]
            .terms[widget.termIndex]
            .students[std]
            .subjects[sub]
            .average = (total.toDouble() / takers.toDouble());

        total = 0;
        takers = 0;
      }
    }
  }

  _subjectGrade() {
    for (int i = 0;
        i <
            MainStore.classes[widget.classIndex].terms[widget.termIndex]
                .students.length;
        i++) {
      for (int j = 0;
          j <
              MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students[i].subjects.length;
          j++) {
        if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[i].subjects[j].total >=
                75 &&
            MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[i].subjects[j].total <=
                100) {
          MainStore.classes[widget.classIndex].terms[widget.termIndex]
              .students[i].subjects[j].grade = "A";
        } else if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[i].subjects[j].total >=
                65 &&
            MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[i].subjects[j].total <=
                74) {
          MainStore.classes[widget.classIndex].terms[widget.termIndex]
              .students[i].subjects[j].grade = "B";
        } else if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[i].subjects[j].total >=
                55 &&
            MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[i].subjects[j].total <=
                64) {
          MainStore.classes[widget.classIndex].terms[widget.termIndex]
              .students[i].subjects[j].grade = "C";
        } else if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[i].subjects[j].total >=
                40 &&
            MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[i].subjects[j].total <=
                54) {
          MainStore.classes[widget.classIndex].terms[widget.termIndex]
              .students[i].subjects[j].grade = "D";
        } else if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[i].subjects[j].total >=
                0 &&
            MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[i].subjects[j].total <=
                39) {
          MainStore.classes[widget.classIndex].terms[widget.termIndex]
              .students[i].subjects[j].grade = "E";
        } else {}
      }
    }
  }

  bool emptyField() {
    bool isEmpty = false;
    if (MainStore.classes[widget.classIndex].terms[widget.termIndex].students
            .isEmpty ||
        MainStore.classes[widget.classIndex].terms[widget.termIndex].subjects
            .isEmpty) {
      isEmpty = true;
    } else {
      for (int i = 0;
          i <
              MainStore.classes[widget.classIndex].terms[widget.termIndex]
                  .students.length;
          i++) {
        if (isEmpty) {
          break;
        } else {
          if (MainStore.classes[widget.classIndex].terms[widget.termIndex]
              .students[i].subjects.isEmpty) {
            isEmpty = true;
            break;
          } else {
            for (int j = 0;
                j <
                    MainStore.classes[widget.classIndex].terms[widget.termIndex]
                        .students[i].subjects.length;
                j++) {
              if (isEmpty) {
                break;
              } else {
                for (int k = 0; k < 2; k++) {
                  if (MainStore
                          .classes[widget.classIndex]
                          .terms[widget.termIndex]
                          .students[i]
                          .subjects[j]
                          .ass[k] ==
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
    return isEmpty;
  }
}
