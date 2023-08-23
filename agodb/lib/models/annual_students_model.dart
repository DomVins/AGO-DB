import 'package:hive_flutter/hive_flutter.dart';

import 'annual_subjects_model.dart';

part 'annual_students_model.g.dart';

@HiveType(typeId: 4)
class StudentAnnual {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<SubjectAnnual> subjects = [];
  @HiveField(2)
  int overAllTotal = 0;
  @HiveField(3)
  double overAllAverage = 0.0;
  @HiveField(4)
  int overAllPosition = 0;

  StudentAnnual(this.name);
}
