import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/class_model.dart';
import '../../store/colors.dart';
import '../../store/store.dart';

class SubjectPage extends StatefulWidget {
  final String className;
  final int classKey;
  final int classIndex;
  final int termIndex;

  const SubjectPage(
      {Key key, this.className, this.classKey, this.classIndex, this.termIndex})
      : super(key: key);

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  String variable = "";

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
                    "${widget.className} Subjects",
                    style: TextStyle(
                        color: textColors,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5),
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () {
                      if (MainStore.classes[widget.classIndex].terms[0].subjects
                              .isNotEmpty &&
                          widget.termIndex != 0 &&
                          MainStore.classes[widget.classIndex]
                              .terms[widget.termIndex].subjects.isEmpty) {
                        setState(() {
                          MainStore.classes[widget.classIndex]
                              .terms[widget.termIndex].subjects
                              .addAll(MainStore.classes[widget.classIndex]
                                  .terms[0].subjects);
                          classBox.put(widget.classKey,
                              MainStore.classes[widget.classIndex]);
                        });
                      } else if (MainStore.classes[widget.classIndex].terms[1]
                              .subjects.isNotEmpty &&
                          widget.termIndex != 1 &&
                          MainStore.classes[widget.classIndex]
                              .terms[widget.termIndex].subjects.isEmpty) {
                        setState(() {
                          MainStore.classes[widget.classIndex]
                              .terms[widget.termIndex].subjects
                              .addAll(MainStore.classes[widget.classIndex]
                                  .terms[1].subjects);
                          classBox.put(widget.classKey,
                              MainStore.classes[widget.classIndex]);
                        });
                      } else if (MainStore.classes[widget.classIndex].terms[2]
                              .subjects.isNotEmpty &&
                          widget.termIndex != 2 &&
                          MainStore.classes[widget.classIndex]
                              .terms[widget.termIndex].subjects.isEmpty) {
                        setState(() {
                          MainStore.classes[widget.classIndex]
                              .terms[widget.termIndex].subjects
                              .addAll(MainStore.classes[widget.classIndex]
                                  .terms[2].subjects);
                          classBox.put(widget.classKey,
                              MainStore.classes[widget.classIndex]);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Either subjects data is not found on any of the other terms or the current subjects list is not empty.'),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, top: 20, bottom: 20),
                      child: Icon(
                        Icons.download_rounded,
                        color: iconColor,
                        size: 24,
                      ),
                    ),
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
                    .subjects.isEmpty
                ? Center(
                    child: Text(
                      "You have not added any subject yet.\nTap the button below to add a subject.",
                      style: TextStyle(
                          fontSize: 15, height: 1.25, color: textColors),
                    ),
                  )
                : ListView(
                    children: _listWidgets(MainStore.classes[widget.classIndex]
                        .terms[widget.termIndex].subjects),
                  ),
          )
        ],
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
                            border:
                                Border.all(color: borderColors, width: 0.5)),
                        child: TextFormField(
                          onChanged: ((value) {
                            variable = value;
                          }),
                          cursorColor: Colors.black,
                          decoration: const InputDecoration.collapsed(
                              hintText: "Enter Subject Name"),
                        ),
                      ),
                      const SizedBox(height: 10),
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
                                .terms[widget.termIndex].subjects
                                .add(variable.toUpperCase().trim());

                            classBox.put(widget.classKey,
                                MainStore.classes[widget.classIndex]);
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
          label: Text("Add Subject",
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

  _listWidget(String item, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(9),
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
            Expanded(child: Container()),
            InkWell(
              onLongPress: () {
                setState(() {
                  MainStore.classes[widget.classIndex].terms[widget.termIndex]
                      .subjects
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

  _listWidgets(List<String> items) {
    List<Widget> temp = [];

    for (int i = 0; i < items.length; i++) {
      temp.add(_listWidget(items[i], i));
    }
    return temp;
  }
}
