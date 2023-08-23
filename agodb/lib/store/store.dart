import '../models/class_model.dart';

class SubPosList {
  String studentName;
  int subTotal;
  SubPosList(this.studentName, this.subTotal);
}

class MainStore {
  static List<Class> classes = [];
  static bool annualCompiled = false;
  static String htName = "";
}

// flutter packages pub run build_runner build
