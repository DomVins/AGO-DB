import 'package:hive_flutter/hive_flutter.dart';

part 'annual_subjects_model.g.dart';

@HiveType(typeId: 5)
class SubjectAnnual {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<int> termTotal = [0, 0, 0];
  @HiveField(2)
  int yearTotal = 0;
  @HiveField(3)
  double average = 0.0;
  @HiveField(4)
  int position = 0;
  @HiveField(5)
  int higestInClass = 0;
  @HiveField(6)
  int loswetInClass = 0;

  SubjectAnnual(this.name);
}
