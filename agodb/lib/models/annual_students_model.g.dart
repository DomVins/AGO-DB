// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annual_students_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentAnnualAdapter extends TypeAdapter<StudentAnnual> {
  @override
  final int typeId = 4;

  @override
  StudentAnnual read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentAnnual(
      fields[0] as String,
    )
      ..subjects = (fields[1] as List)?.cast<SubjectAnnual>()
      ..overAllTotal = fields[2] as int
      ..overAllAverage = fields[3] as double
      ..overAllPosition = fields[4] as int;
  }

  @override
  void write(BinaryWriter writer, StudentAnnual obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.subjects)
      ..writeByte(2)
      ..write(obj.overAllTotal)
      ..writeByte(3)
      ..write(obj.overAllAverage)
      ..writeByte(4)
      ..write(obj.overAllPosition);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAnnualAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
