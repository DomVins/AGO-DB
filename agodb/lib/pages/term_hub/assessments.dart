import 'package:flutter/material.dart';

import '../../store/colors.dart';
import '../../store/store.dart';
import 'assessments_inner/subject_assessments.dart';

class Assessments extends StatefulWidget {
  final String className;
  final int classKey;
  final int classIndex;
  final int termIndex;

  const Assessments(
      {Key key, this.className, this.classKey, this.classIndex, this.termIndex})
      : super(key: key);

  @override
  State<Assessments> createState() => _AssessmentsState();
}

class _AssessmentsState extends State<Assessments> {
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
                        "${MainStore.classes[widget.classIndex].terms[widget.termIndex].termName} Assessments",
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
              Expanded(
                child: MainStore.classes[widget.classIndex]
                        .terms[widget.termIndex].subjects.isEmpty
                    ? Center(
                        child: Text(
                          "You have not added any subject yet.",
                          style: TextStyle(
                              fontSize: 15, height: 1.25, color: textColors),
                        ),
                      )
                    : ListView(
                        children: _listWidgets(MainStore
                            .classes[widget.classIndex]
                            .terms[widget.termIndex]
                            .subjects),
                      ),
              )
            ],
          ),
        ));
  }

  _listWidget(String item, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SubjectAssessments(
                                className: item,
                                classKey: widget.classKey,
                                classIndex: widget.classIndex,
                                termIndex: widget.termIndex,
                                subjectIndex: index,
                              )));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: double.maxFinite,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: Colors.black, blurRadius: 0.5, spreadRadius: 0.5)
            ],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: borderColors, width: 0.5),
            color: Colors.white),
        child: Row(
          children: [
            Text(
              item,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2),
            ),
          ],
        ),
      ),
    );
  }

  _listWidgets(List<String> items) {
    List<Widget> temp = [];

    for (int i = 0; i < items.length; i++) {
      temp.add(_listWidget(items[i], i));
    }
    return temp;
  }
}
