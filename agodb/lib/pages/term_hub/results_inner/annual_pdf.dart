import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math';

import '../../../store/store.dart';

class Annual extends StatefulWidget {
  final int index;
  const Annual({Key key, this.index}) : super(key: key);

  @override
  State<Annual> createState() => _AnnualState();
}

class _AnnualState extends State<Annual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Annual Results PDF Preview'),
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

    final ByteData byte1 = await rootBundle.load('assets/logo.png');
    final Uint8List list1 = byte1.buffer.asUint8List();

    for (int i = 0;
        i < MainStore.classes[widget.index].studentsAnnual.length;
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
                              pw.Text("ANNUAL RESULTS",
                                  style: pw.TextStyle(
                                      fontSize: 14,
                                      fontWeight: pw.FontWeight.bold,
                                      fontStyle: pw.FontStyle.italic)),
                            ])
                      ]),
                  pw.SizedBox(height: 15),
                  pw.Row(children: [
                    pw.Text(
                        'Name of Student:  ${MainStore.classes[widget.index].studentsAnnual[i].name}'),
                    pw.Expanded(child: pw.Container()),
                    pw.Text('Year: ${MainStore.classes[widget.index].session}'),
                  ]),
                  pw.SizedBox(height: 5),
                  pw.Row(children: [
                    pw.Text("School: AGGO Colledge, Makurdi Benue State."),
                    pw.Expanded(child: pw.Container()),
                    pw.Text(
                        'Sex: ${MainStore.classes[widget.index].terms[2].students[i].gender}'),
                  ]),
                  pw.SizedBox(height: 5),
                  pw.Row(children: [
                    pw.Text(
                        "Adress: Beside Green belt Hotel Abu King Shuluwa road Logo 2 Makurdi"),
                    pw.Expanded(child: pw.Container()),
                    pw.Text(
                        'Age: ${MainStore.classes[widget.index].terms[2].students[i].age} years'),
                  ]),
                  pw.SizedBox(height: 5),
                  pw.Row(children: [
                    pw.Text(
                        "Class: ${MainStore.classes[widget.index].className}"),
                    pw.Expanded(child: pw.Container()),
                    pw.Text(
                        'Number in Class: ${MainStore.classes[widget.index].studentsAnnual.length}'),
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
                                    child: pw.Text('CORE SUBJECTS',
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                        ))),
                              ),
                              pw.Row(children: [
                                pw.Row(children: [
                                  pw.Container(
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all()),
                                      height: 70,
                                      width: 40,
                                      child: pw.Transform.rotate(
                                        angle: pi / 2,
                                        child: pw.Center(
                                            child: pw.Text('TERM 1\nTOTAL',
                                                style: pw.TextStyle(
                                                  fontSize: 8,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
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
                                            child: pw.Text('TERM 2\nTOTAL',
                                                style: pw.TextStyle(
                                                  fontSize: 8,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
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
                                            child: pw.Text('TERM 3\nTOTAL',
                                                style: pw.TextStyle(
                                                  fontSize: 8,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                ))),
                                      )),
                                ]),
                                pw.Container(
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all()),
                                    height: 70,
                                    width: 30,
                                    child: pw.Transform.rotate(
                                      angle: pi / 2,
                                      child: pw.Center(
                                          child: pw.Text('YEAR\nTOTAL',
                                              style: pw.TextStyle(
                                                fontSize: 8,
                                                fontWeight: pw.FontWeight.bold,
                                              ))),
                                    )),
                                pw.Container(
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all()),
                                    height: 70,
                                    width: 35,
                                    child: pw.Transform.rotate(
                                      angle: pi / 2,
                                      child: pw.Center(
                                          child: pw.Text('AVERAGE',
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
                        pw.Column(
                          children: _listWidgets(i),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Row(children: [
                          pw.Text(
                              'NUMBER OF SUBJECTS: ${MainStore.classes[widget.index].studentsAnnual[i].subjects.length.toString()}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'TOTAL OBTAINABLE MARKS: ${MainStore.classes[widget.index].studentsAnnual[i].subjects.length * 300}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'MARKS OBTAINED: ${MainStore.classes[widget.index].studentsAnnual[i].overAllTotal.toString()}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 5),
                        pw.Row(children: [
                          pw.Text(
                              'AVERAGE: ${MainStore.classes[widget.index].studentsAnnual[i].overAllAverage.toStringAsFixed(2)}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'POSITION IN CLASS: ${MainStore.classes[widget.index].studentsAnnual[i].overAllPosition.toString()}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'OUT OF CLASS: ${MainStore.classes[widget.index].studentsAnnual.length}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 10),
                        pw.Text("PRINCIPAL REMARKS: Good result. Promoted. ",
                            style: pw.TextStyle(
                              fontSize: 8,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.SizedBox(height: 5),
                        pw.Row(children: [
                          pw.Text('NAME OF PRINCIPAL: MR. AGONDO SOLOMON',
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
        i < MainStore.classes[widget.index].terms[2].students[stdIndex].subjects.length;
        i++) {
      temp.add(_sujectRow(i, stdIndex));
    }
    return temp;
  }

  _sujectRow(int sub, int stdIndex) {
    return pw.Row(children: [
      // Subject name . . .
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 120,
        child: pw.Center(
            child:
                pw.Text(MainStore.classes[widget.index].terms[2].students[stdIndex].subjects[sub].name,
                    style: pw.TextStyle(
                      fontSize: 8.5,
                      fontWeight: pw.FontWeight.bold,
                    ))),
      ),
      // Term 1 total . . .
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 40,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].studentsAnnual[stdIndex]
                    .subjects[sub].termTotal[0]
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Term 2 total . . .
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 40,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].studentsAnnual[stdIndex]
                    .subjects[sub].termTotal[1]
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Term 3 total . . .
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 40,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].studentsAnnual[stdIndex]
                    .subjects[sub].termTotal[2]
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Yearly total . . .
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 30,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].studentsAnnual[stdIndex]
                    .subjects[sub].yearTotal
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Average . . .
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 35,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].studentsAnnual[stdIndex]
                    .subjects[sub].average
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
                MainStore.classes[widget.index].studentsAnnual[stdIndex]
                    .subjects[sub].higestInClass
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
                MainStore.classes[widget.index].studentsAnnual[stdIndex]
                    .subjects[sub].loswetInClass
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Position in class . . .
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 40,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].studentsAnnual[stdIndex]
                    .subjects[sub].position
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Grade . . .
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 30,
        child: pw.Center(
            child: pw.Text(
                annualGrade(MainStore.classes[widget.index]
                    .studentsAnnual[stdIndex].subjects[sub].average),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
    ]);
  }

  String annualGrade(double average) {
    if (average >= 75 && average <= 100) {
      return "A";
    } else if (average >= 65 && average < 75) {
      return "B";
    } else if (average >= 55 && average < 65) {
      return "C";
    } else if (average >= 40 && average < 55) {
      return "D";
    } else if (average >= 0 && average < 40) {
      return "E";
    } else {
      return "";
    }
  }
}
