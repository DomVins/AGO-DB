import 'package:agodb/models/subject_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../models/class_model.dart';
import '../../../models/student_model.dart';
import '../../../store/colors.dart';
import '../../../store/store.dart';

class SubjectScoreSheet extends StatefulWidget {
  final String className;
  final int classIndex;
  final int termIndex;
  final int subjectIndex;

  const SubjectScoreSheet(
      {Key key,
      this.className,
      this.classIndex,
      this.termIndex,
      this.subjectIndex})
      : super(key: key);

  @override
  State<SubjectScoreSheet> createState() => _SubjectScoreSheetState();
}

class _SubjectScoreSheetState extends State<SubjectScoreSheet> {
  Box<Class> classBox;

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
                        "${MainStore.classes[widget.classIndex].terms[widget.termIndex].subjects[widget.subjectIndex]} Score Sheet",
                        style: TextStyle(
                            color: textColors,
                            fontSize: 18,
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
              SpecialTable(
                classIndex: widget.classIndex,
                termIndex: widget.termIndex,
                subjectIndex: widget.subjectIndex,
              )
            ],
          ),
        ));
  }
}

class SpecialTable extends StatefulWidget {
  final int classIndex;
  final int termIndex;
  final int subjectIndex;
  SpecialTable(
      {Key key,
      this.classIndex,
      this.termIndex,
      this.subjectIndex,
      this.initialScrollOffsetX = 0.0,
      this.initialScrollOffsetY = 0.0,
      this.onEndScrolling,
      ScrollControllers scrollControllers})
      : scrollControllers = scrollControllers ?? ScrollControllers(),
        super(key: key);

  final ScrollControllers scrollControllers;
  final Function(double x, double y) onEndScrolling;
  final double initialScrollOffsetX;
  final double initialScrollOffsetY;

  @override
  State<SpecialTable> createState() => _SpecialTableState();
}

class _SpecialTableState extends State<SpecialTable> {
  _SyncScrollController _horizontalSyncController;
  _SyncScrollController _verticalSyncController;

  double _scrollOffsetX;
  double _scrollOffsetY;

  List<Student> subjectTakers = [];

  @override
  void initState() {
    super.initState();
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
                .students[i].subjects[j].name ==
            MainStore.classes[widget.classIndex].terms[widget.termIndex]
                .subjects[widget.subjectIndex]) {
          subjectTakers.add(MainStore
              .classes[widget.classIndex].terms[widget.termIndex].students[i]);
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _scrollOffsetX = widget.initialScrollOffsetX;
    _scrollOffsetY = widget.initialScrollOffsetY;
    _verticalSyncController = _SyncScrollController([
      widget.scrollControllers._verticalTitleController,
      widget.scrollControllers._verticalBodyController,
    ]);
    _horizontalSyncController = _SyncScrollController([
      widget.scrollControllers._horizontalTitleController,
      widget.scrollControllers._horizontalBodyController,
    ]);

    return Expanded(
      child: Column(
        children: [
          // Horiontal header . . .
          Row(
            children: [
              // Legend . . .
              _namesTitle(),
              // Sticky Row . . .
              Expanded(
                  child: NotificationListener<ScrollNotification>(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller:
                      widget.scrollControllers._horizontalTitleController,
                  child: _scoreHeaders(
                      MainStore
                          .classes[widget.classIndex]
                          .terms[widget.termIndex]
                          .subjects[widget.subjectIndex],
                      widget.subjectIndex),
                ),
                onNotification: (ScrollNotification notification) {
                  final didEndScrolling =
                      _horizontalSyncController.processNotification(
                    notification,
                    widget.scrollControllers._horizontalTitleController,
                  );
                  if (widget.onEndScrolling != null && didEndScrolling) {
                    _scrollOffsetX = widget
                        .scrollControllers._horizontalTitleController.offset;
                    widget.onEndScrolling(_scrollOffsetX, _scrollOffsetY);
                  }
                  return true;
                },
              )),
            ],
          ),
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sticky Column . . .
              NotificationListener<ScrollNotification>(
                child: SingleChildScrollView(
                  controller: widget.scrollControllers._verticalTitleController,
                  child: Column(
                      children: _namesList(_legitmateStudents(
                          MainStore.classes[widget.classIndex]
                              .terms[widget.termIndex].students,
                          MainStore
                              .classes[widget.classIndex]
                              .terms[widget.termIndex]
                              .subjects[widget.subjectIndex]))),
                ),
                onNotification: (ScrollNotification notification) {
                  final didEndScrolling =
                      _verticalSyncController.processNotification(
                    notification,
                    widget.scrollControllers._verticalTitleController,
                  );
                  if (widget.onEndScrolling != null && didEndScrolling) {
                    _scrollOffsetY = widget
                        .scrollControllers._verticalTitleController.offset;
                    widget.onEndScrolling(_scrollOffsetX, _scrollOffsetY);
                  }
                  return true;
                },
              ),

              // Contents . . .
              Expanded(
                  child: NotificationListener<ScrollNotification>(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller:
                      widget.scrollControllers._horizontalBodyController,
                  child: NotificationListener<ScrollNotification>(
                    child: SingleChildScrollView(
                        controller:
                            widget.scrollControllers._verticalBodyController,
                        child: _studentsScoresColumn()),
                    onNotification: (ScrollNotification notification) {
                      final didEndScrolling =
                          _verticalSyncController.processNotification(
                        notification,
                        widget.scrollControllers._verticalBodyController,
                      );
                      if (widget.onEndScrolling != null && didEndScrolling) {
                        _scrollOffsetX = widget
                            .scrollControllers._verticalBodyController.offset;
                        widget.onEndScrolling(_scrollOffsetX, _scrollOffsetY);
                      }
                      return true;
                    },
                  ),
                ),
                onNotification: (ScrollNotification notification) {
                  final didEndScrolling =
                      _horizontalSyncController.processNotification(
                    notification,
                    widget.scrollControllers._horizontalBodyController,
                  );
                  if (widget.onEndScrolling != null && didEndScrolling) {
                    _scrollOffsetX = widget
                        .scrollControllers._horizontalBodyController.offset;
                    widget.onEndScrolling(_scrollOffsetX, _scrollOffsetY);
                  }
                  return true;
                },
              ))
            ],
          ))
        ],
      ),
    );
  }

  // ** Widgets ** . . .

  // Names title . . .
  _namesTitle() {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: textColors)),
        height: 50,
        child: Center(
            child: Text('Names',
                style: TextStyle(
                  color: textColors,
                  fontWeight: FontWeight.bold,
                ))),
      ),
    );
  }

// Students names . . .
  _namesList(List<Student> students) {
    List<Widget> temp = [];

    for (int i = 0; i < students.length; i++) {
      temp.add(_names(students[i].name));
    }
    return temp;
  }

  _names(String name) {
    return SizedBox(
      height: 25,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: textColors)),
        padding: const EdgeInsets.only(left: 15),
        alignment: Alignment.centerLeft,
        height: 25,
        child: Text(name,
            style: TextStyle(
              color: textColors,
            )),
      ),
    );
  }

// Scores header . . .
  _scoreHeaders(String subject, int index) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 0.5, color: textColors)),
      height: 60,
      width: MediaQuery.of(context).size.width * 1.3,
      child: Table(
        border: TableBorder.all(color: textColors),
        children: [
          TableRow(children: [
            SizedBox(
              height: 25,
              child: Center(
                  child: Text(subject,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: textColors))),
            )
          ]),
          TableRow(children: [
            Table(
              border: TableBorder.all(color: textColors),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Container(
                    padding: const EdgeInsets.all(2),
                    height: 35,
                    child: Center(
                        child: Text(
                      "1st ASS TEST(10)",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: textColors),
                    )),
                  )),
                  TableCell(
                      child: Container(
                    padding: const EdgeInsets.all(2),
                    height: 35,
                    child: Center(
                        child: Text(
                      "2nd ASS TEST(10)",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: textColors),
                    )),
                  )),
                  TableCell(
                      child: Container(
                    padding: const EdgeInsets.all(2),
                    height: 35,
                    child: Center(
                        child: Text(
                      "3rd ASS TEST(10)",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: textColors),
                    )),
                  )),
                  TableCell(
                      child: Container(
                    padding: const EdgeInsets.all(2),
                    height: 35,
                    child: Center(
                        child: Text(
                      "TERM EXAM(70)",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: textColors),
                    )),
                  )),
                  TableCell(
                      child: Container(
                    padding: const EdgeInsets.all(2),
                    height: 35,
                    child: Center(
                        child: Text(
                      "TOTAL SCORE",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: textColors),
                    )),
                  )),
                  TableCell(
                      child: Container(
                    padding: const EdgeInsets.all(2),
                    height: 35,
                    child: Center(
                        child: Text(
                      "AVERAGE",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: textColors),
                    )),
                  )),
                  TableCell(
                      child: Container(
                    padding: const EdgeInsets.all(2),
                    height: 35,
                    child: Center(
                        child: Text(
                      "POSITION",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: textColors),
                    )),
                  )),
                  TableCell(
                      child: Container(
                    padding: const EdgeInsets.all(2),
                    height: 35,
                    child: Center(
                        child: Text(
                      "GRADE",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: textColors),
                    )),
                  )),
                ])
              ],
            )
          ])
        ],
      ),
    );
  }

  _subjectScores(int stdIndex) {
    return SizedBox(
      height: 25,
      width: MediaQuery.of(context).size.width * 1.3,
      child: Table(
        border: TableBorder.all(color: textColors),
        children: [
          TableRow(children: [
            _textField(1, stdIndex),
            _textField(2, stdIndex),
            _textField(3, stdIndex),
            _textField(4, stdIndex),
            _textField(5, stdIndex),
            _textField(6, stdIndex),
            _textField(7, stdIndex),
            _textField(8, stdIndex),
          ])
        ],
      ),
    );
  }

  _textField(int id, int stdIndex) {
    return TableCell(
        child: Container(
            padding: const EdgeInsets.all(4),
            height: 25,
            child: Center(
                child: Text(
              _textFormValue(id, stdIndex),
              style: TextStyle(
                color: textColors,
              ),
            ))));
  }

  String _textFormValue(int id, int stdIndex) {
    String cont;
    switch (id) {
      case 1:
        cont = subjectTakers[stdIndex]
            .subjects[_indexSearcher(
                subjectTakers[stdIndex].subjects,
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .subjects[widget.subjectIndex])]
            .ass[0]
            .toString();
        break;
      case 2:
        cont = subjectTakers[stdIndex]
            .subjects[_indexSearcher(
                subjectTakers[stdIndex].subjects,
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .subjects[widget.subjectIndex])]
            .ass[1]
            .toString();

        break;
      case 3:
        cont = subjectTakers[stdIndex]
            .subjects[_indexSearcher(
                subjectTakers[stdIndex].subjects,
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .subjects[widget.subjectIndex])]
            .ass[2]
            .toString();

        break;
      case 4:
        cont = subjectTakers[stdIndex]
            .subjects[_indexSearcher(
                subjectTakers[stdIndex].subjects,
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .subjects[widget.subjectIndex])]
            .ass[3]
            .toString();

        break;
      case 5:
        cont = subjectTakers[stdIndex]
            .subjects[_indexSearcher(
                subjectTakers[stdIndex].subjects,
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .subjects[widget.subjectIndex])]
            .total
            .toString();
        break;
      case 6:
        cont = subjectTakers[stdIndex]
            .subjects[_indexSearcher(
                subjectTakers[stdIndex].subjects,
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .subjects[widget.subjectIndex])]
            .average
            .toString();

        break;
      case 7:
        cont = subjectTakers[stdIndex]
            .subjects[_indexSearcher(
                subjectTakers[stdIndex].subjects,
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .subjects[widget.subjectIndex])]
            .pos
            .toString();

        break;
      case 8:
        cont = subjectTakers[stdIndex]
            .subjects[_indexSearcher(
                subjectTakers[stdIndex].subjects,
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .subjects[widget.subjectIndex])]
            .grade
            .toString();

        break;
      default:
        cont = "";
        break;
    }

    return cont;
  }

// All Students . . .
  _studentsScoresColumn() {
    return Column(
      children: _scoreColumnList(),
    );
  }

// Column widget list . . .
  _scoreColumnList() {
    List<Widget> temp = [];

    for (int i = 0; i < subjectTakers.length; i++) {
      temp.add(_subjectScores(i));
    }
    return temp;
  }
}

class ScrollControllers {
  final ScrollController _verticalTitleController;
  final ScrollController _verticalBodyController;

  final ScrollController _horizontalBodyController;
  final ScrollController _horizontalTitleController;

  ScrollControllers({
    ScrollController verticalTitleController,
    ScrollController verticalBodyController,
    ScrollController horizontalBodyController,
    ScrollController horizontalTitleController,
  })  : _verticalTitleController =
            verticalTitleController ?? ScrollController(),
        _verticalBodyController = verticalBodyController ?? ScrollController(),
        _horizontalBodyController =
            horizontalBodyController ?? ScrollController(),
        _horizontalTitleController =
            horizontalTitleController ?? ScrollController();
}

// SyncScrollController keeps scroll controllers in sync.
class _SyncScrollController {
  _SyncScrollController(List<ScrollController> controllers) {
    for (var controller in controllers) {
      _registeredScrollControllers.add(controller);
    }
  }

  final List<ScrollController> _registeredScrollControllers = [];

  ScrollController _scrollingController;
  bool _scrollingActive = false;

  /// Returns true if reached scroll end
  bool processNotification(
    ScrollNotification notification,
    ScrollController controller,
  ) {
    if (notification is ScrollStartNotification && !_scrollingActive) {
      _scrollingController = controller;
      _scrollingActive = true;
      return false;
    }

    if (identical(controller, _scrollingController) && _scrollingActive) {
      if (notification is ScrollEndNotification) {
        _scrollingController = null;
        _scrollingActive = false;
        return true;
      }

      if (notification is ScrollUpdateNotification) {
        for (ScrollController controller in _registeredScrollControllers) {
          if (identical(_scrollingController, controller)) continue;
          controller.jumpTo(_scrollingController.offset);
        }
      }
    }
    return false;
  }
}

// ** Utilities ** . . .
_legitmateStudents(List<Student> studs, String subject) {
  List<Student> chosenOnes = [];
  for (int i = 0; i < studs.length; i++) {
    for (int j = 0; j < studs[i].subjects.length; j++) {
      if (studs[i].subjects[j].name == subject) {
        chosenOnes.add(studs[i]);
        break;
      }
    }
  }
  return chosenOnes;
}

_indexSearcher(List<Subject> subjects, String subject) {
  return subjects.indexWhere((element) => element.name == subject);
}
