import 'package:hive_flutter/hive_flutter.dart';

import 'subject_model.dart';

part 'student_model.g.dart';

@HiveType(typeId: 2)
class Student {
  @HiveField(0)
  String name;
  @HiveField(1)
  String gender;
  @HiveField(2)
  String age;
  @HiveField(3)
  int total = 0;
  @HiveField(4)
  double average = 0.00;
  @HiveField(5)
  int position = 0;
  @HiveField(6)
  String remark = "";
  @HiveField(7)
  List<Subject> subjects;
  @HiveField(8)
  String id;

  Student(this.name, this.gender, this.age, this.id, this.subjects);
}
