import 'package:agodb/store/colors.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math';

import '../../../store/store.dart';

class ShowResult extends StatefulWidget {
  final int index;
  final int termIndex;
  const ShowResult({Key key, this.index, this.termIndex}) : super(key: key);

  @override
  State<ShowResult> createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        title: const Text('Results PDF Preview'),
      ),
      body: PdfPreview(
        dynamicLayout: false,
        canChangePageFormat: false,
        canDebug: false,
        maxPageWidth: 700,
        build: (format) => generateDocument(format),
      ),
    );
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);
    final ByteData byte = await rootBundle.load('assets/stamp.jpg');
    final Uint8List list = byte.buffer.asUint8List();

    final ByteData byte1 = await rootBundle.load('assets/logo.png');
    final Uint8List list1 = byte1.buffer.asUint8List();

    for (int i = 0;
        i <
            MainStore
                .classes[widget.index].terms[widget.termIndex].students.length;
        i++) {
      doc.addPage(
        pw.Page(
          build: (context) {
            return pw.Padding(
              padding: const pw.EdgeInsets.only(
                left: 0,
                right: 0,
                bottom: 0,
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            children: [
                              pw.SizedBox(
                                height: 60,
                                width: 60,
                                child: pw.Image(pw.MemoryImage(list1)),
                              ),
                              pw.SizedBox(height: 4),
                              pw.Text('AGGO COLLEGE MAKURDI',
                                  style: pw.TextStyle(
                                      fontSize: 16,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('BENUE STATE NIGERIA',
                                  style: pw.TextStyle(
                                      fontSize: 16,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.SizedBox(height: 8),
                              pw.Text("TERM RESULTS",
                                  style: pw.TextStyle(
                                      fontSize: 14,
                                      fontWeight: pw.FontWeight.bold,
                                      fontStyle: pw.FontStyle.italic)),
                            ])
                      ]),
                  pw.SizedBox(height: 15),
                  pw.Row(children: [
                    pw.Text(
                        'Name of Student: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].name}'),
                    pw.Expanded(child: pw.Container()),
                    pw.Text('Year: ${MainStore.classes[widget.index].session}'),
                  ]),
                  pw.SizedBox(height: 5),
                  pw.Row(children: [
                    pw.Text("School: AGGO College, Makurdi Benue State."),
                    pw.Expanded(child: pw.Container()),
                    pw.Text(
                        'Sex:${MainStore.classes[widget.index].terms[widget.termIndex].students[i].gender}'),
                  ]),
                  pw.SizedBox(height: 5),
                  pw.Row(children: [
                    pw.Text(
                        "Adress: Beside Green belt Hotel Abu King Shuluwa road Logo 2 Makurdi"),
                    pw.Expanded(child: pw.Container()),
                    pw.Text(
                        'Age: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].age} years'),
                  ]),
                  pw.SizedBox(height: 5),
                  pw.Row(children: [
                    pw.Text(
                        "Class: ${MainStore.classes[widget.index].className}"),
                    pw.Expanded(child: pw.Container()),
                    pw.Text(
                        'Number in Class: ${MainStore.classes[widget.index].terms[widget.termIndex].students.length}'),
                  ]),
                  pw.SizedBox(height: 5),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 70,
                                width: 120,
                                child: pw.Center(
                                    child: pw.Text('TERM',
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                        ))),
                              ),
                              pw.Row(children: [
                                pw.Column(children: [
                                  pw.Container(
                                      padding:
                                          const pw.EdgeInsets.only(left: 2),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all()),
                                      height: 30,
                                      width: 120,
                                      child: pw.Center(
                                          child: pw.Text(
                                              'SUMMARY OF C. ASSESSMENT SCORES',
                                              style: pw.TextStyle(
                                                fontSize: 8,
                                                fontWeight: pw.FontWeight.bold,
                                              )))),
                                  pw.Row(children: [
                                    pw.Container(
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border.all()),
                                        height: 40,
                                        width: 40,
                                        child: pw.Transform.rotate(
                                          angle: pi / 2,
                                          child: pw.Center(
                                              child: pw.Text('WKS 1-4',
                                                  style: pw.TextStyle(
                                                    fontSize: 8,
                                                    fontWeight:
                                                        pw.FontWeight.bold,
                                                  ))),
                                        )),
                                    pw.Container(
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border.all()),
                                        height: 40,
                                        width: 40,
                                        child: pw.Transform.rotate(
                                          angle: pi / 2,
                                          child: pw.Center(
                                              child: pw.Text('WKS 5-8',
                                                  style: pw.TextStyle(
                                                    fontSize: 8,
                                                    fontWeight:
                                                        pw.FontWeight.bold,
                                                  ))),
                                        )),
                                    pw.Container(
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border.all()),
                                        height: 40,
                                        width: 40,
                                        child: pw.Transform.rotate(
                                          angle: pi / 2,
                                          child: pw.Center(
                                              child: pw.Text('WKS 9-12',
                                                  style: pw.TextStyle(
                                                    fontSize: 8,
                                                    fontWeight:
                                                        pw.FontWeight.bold,
                                                  ))),
                                        )),
                                  ])
                                ]),
                                pw.Container(
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all()),
                                    height: 70,
                                    width: 25,
                                    child: pw.Transform.rotate(
                                      angle: pi / 2,
                                      child: pw.Center(
                                          child: pw.Text('TERM\nEXAM',
                                              style: pw.TextStyle(
                                                fontSize: 8,
                                                fontWeight: pw.FontWeight.bold,
                                              ))),
                                    )),
                                pw.Container(
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all()),
                                    height: 70,
                                    width: 40,
                                    child: pw.Transform.rotate(
                                      angle: pi / 2,
                                      child: pw.Center(
                                          child: pw.Text('COMBINED\nSCORES',
                                              overflow: pw.TextOverflow.visible,
                                              style: pw.TextStyle(
                                                fontSize: 7,
                                                fontWeight: pw.FontWeight.bold,
                                              ))),
                                    )),
                                pw.Container(
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all()),
                                    height: 70,
                                    width: 40,
                                    child: pw.Transform.rotate(
                                      angle: pi / 2,
                                      child: pw.Center(
                                          child: pw.Text('CLASS\nAVERAGE',
                                              overflow: pw.TextOverflow.visible,
                                              style: pw.TextStyle(
                                                fontSize: 7,
                                                fontWeight: pw.FontWeight.bold,
                                              ))),
                                    )),
                                pw.Container(
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all()),
                                    height: 70,
                                    width: 40,
                                    child: pw.Transform.rotate(
                                      angle: pi / 2,
                                      child: pw.Center(
                                          child: pw.Text('HIGHEST\nIN CLASS',
                                              overflow: pw.TextOverflow.visible,
                                              style: pw.TextStyle(
                                                fontSize: 7,
                                                fontWeight: pw.FontWeight.bold,
                                              ))),
                                    )),
                                pw.Container(
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all()),
                                    height: 70,
                                    width: 40,
                                    child: pw.Transform.rotate(
                                      angle: pi / 2,
                                      child: pw.Center(
                                          child: pw.Text('LOWEST\nIN CLASS',
                                              overflow: pw.TextOverflow.visible,
                                              style: pw.TextStyle(
                                                fontSize: 7,
                                                fontWeight: pw.FontWeight.bold,
                                              ))),
                                    )),
                                pw.Container(
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all()),
                                    height: 70,
                                    width: 40,
                                    child: pw.Transform.rotate(
                                      angle: pi / 2,
                                      child: pw.Center(
                                          child: pw.Text('POSITION\nIN CLASS',
                                              overflow: pw.TextOverflow.visible,
                                              style: pw.TextStyle(
                                                fontSize: 7,
                                                fontWeight: pw.FontWeight.bold,
                                              ))),
                                    )),
                                pw.Container(
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all()),
                                    height: 70,
                                    width: 30,
                                    child: pw.Transform.rotate(
                                      angle: pi / 2,
                                      child: pw.Center(
                                          child: pw.Text('GRADE',
                                              overflow: pw.TextOverflow.visible,
                                              style: pw.TextStyle(
                                                fontSize: 7,
                                                fontWeight: pw.FontWeight.bold,
                                              ))),
                                    )),
                              ])
                            ]),
                        pw.Row(children: [
                          pw.Container(
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            height: 40,
                            width: 120,
                            child: pw.Center(
                                child: pw.Text("        'A'\nSUBJECTS",
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    ))),
                          ),
                          pw.Container(
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              height: 40,
                              width: 40,
                              child: pw.Transform.rotate(
                                angle: pi / 2,
                                child: pw.Center(
                                    child: pw.Text('1ST C.A\n    10',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        ))),
                              )),
                          pw.Container(
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              height: 40,
                              width: 40,
                              child: pw.Transform.rotate(
                                angle: pi / 2,
                                child: pw.Center(
                                    child: pw.Text('2ND C.A\n    10',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        ))),
                              )),
                          pw.Container(
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              height: 40,
                              width: 40,
                              child: pw.Transform.rotate(
                                angle: pi / 2,
                                child: pw.Center(
                                    child: pw.Text('3RD C.A\n    10',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        ))),
                              )),
                          pw.Container(
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              height: 40,
                              width: 25,
                              child: pw.Transform.rotate(
                                angle: pi / 2,
                                child: pw.Center(
                                    child: pw.Text('E.70%',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        ))),
                              )),
                          pw.Container(
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            height: 40,
                            width: 40,
                          ),
                          pw.Container(
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            height: 40,
                            width: 40,
                          ),
                          pw.Container(
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            height: 40,
                            width: 40,
                          ),
                          pw.Container(
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            height: 40,
                            width: 40,
                          ),
                          pw.Container(
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            height: 40,
                            width: 40,
                          ),
                          pw.Container(
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            height: 40,
                            width: 30,
                          ),
                        ]),
                        pw.Column(
                          children: _listWidgets(i),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Row(children: [
                          pw.Text(
                              'NUMBER OF SUBJECTS: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].subjects.length}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'TOTAL OBTAINABLE MARKS: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].subjects.length * 100}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'MARKS OBTAINED: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].total}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 5),
                        pw.Row(children: [
                          pw.Text(
                              'AVERAGE: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].average.toStringAsFixed(2)}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'POSITION IN CLASS: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].position}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'OUT OF CLASS: ${MainStore.classes[widget.index].terms[widget.termIndex].students.length}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 8),
                        pw.Text(
                            "PRINCIPAL'S REMARKS: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].remark} ",
                            style: pw.TextStyle(
                              fontSize: 8,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.SizedBox(height: 5),
                        pw.Row(children: [
                          pw.Text('NAME OF PRINCIPAL: ${MainStore.htName}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text('SIGNATURE AND SCHOOL STAMP: ',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.SizedBox(
                            height: 45,
                            width: 75,
                          ),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'DATE: ${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 1),
                        pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Expanded(child: pw.Container()),
                              pw.Container(
                                  width: 320,
                                  padding: const pw.EdgeInsets.all(2),
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      children: [
                                        pw.Text(
                                            "            'B'\nPSYCHOMOTOR\n        SKILLS",
                                            style: pw.TextStyle(
                                              fontSize: 8,
                                              fontWeight: pw.FontWeight.bold,
                                            )),
                                        pw.SizedBox(height: 5),
                                        pw.Text(
                                            "HandWriting: 3  Fluency: 4  Game/Sports: 3  Musical Skills: 3  Construction: 3",
                                            style: pw.TextStyle(
                                              fontSize: 8,
                                              fontWeight: pw.FontWeight.bold,
                                            )),
                                      ])),
                              pw.SizedBox(width: 10),
                              pw.Text(
                                  "KEYS TO GRADING:\n5:Excellent, 4:Very Good, 3: Good, 2: Fair, 1: Poor",
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                    fontWeight: pw.FontWeight.bold,
                                  )),
                            ])
                      ])
                ],
              ),
            );
          },
        ),
      );
    }

    return await doc.save();
  }

  _listWidgets(int stdIndex) {
    List<pw.Widget> temp = [];
    for (int i = 0;
        i <
            MainStore.classes[widget.index].terms[widget.termIndex]
                .students[stdIndex].subjects.length;
        i++) {
      temp.add(_sujectRow(i, stdIndex));
    }
    return temp;
  }

  _sujectRow(int sub, int stdIndex) {
    return pw.Row(children: [
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 120,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                .students[stdIndex].subjects[sub].name,
                style: pw.TextStyle(
                  fontSize: 8.5,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 40,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                    .students[stdIndex].subjects[sub].ass[0]
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 40,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                    .students[stdIndex].subjects[sub].ass[1]
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 40,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                    .students[stdIndex].subjects[sub].ass[2]
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 25,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                    .students[stdIndex].subjects[sub].ass[3]
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 40,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                    .students[stdIndex].subjects[sub].total
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 40,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                    .students[stdIndex].subjects[sub].average
                    .toStringAsFixed(2),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Highest in Class . . .
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 40,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                    .students[stdIndex].subjects[sub].highest
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Lowest in class . . .
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 40,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                    .students[stdIndex].subjects[sub].lowest
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 40,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                    .students[stdIndex].subjects[sub].pos
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 30,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                    .students[stdIndex].subjects[sub].grade
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
    ]);
  }
}
