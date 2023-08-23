import 'package:hive_flutter/hive_flutter.dart';

part 'subject_model.g.dart';

@HiveType(typeId: 3)
class Subject {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<int> ass = [-1, -1, -1, -1];
  @HiveField(2)
  int total = 0;
  @HiveField(3)
  int highest = 0;
  @HiveField(4)
  int lowest = 0;
  @HiveField(5)
  int pos = 0;
  @HiveField(6)
  double average = 0.0;
  @HiveField(7)
  String grade = "";

  Subject(this.name);

  void setPos(int position) {
    pos = position;
  }
}
