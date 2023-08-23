// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectAdapter extends TypeAdapter<Subject> {
  @override
  final int typeId = 3;

  @override
  Subject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Subject(
      fields[0] as String,
    )
      ..ass = (fields[1] as List)?.cast<int>()
      ..total = fields[2] as int
      ..highest = fields[3] as int
      ..lowest = fields[4] as int
      ..pos = fields[5] as int
      ..average = fields[6] as double
      ..grade = fields[7] as String;
  }

  @override
  void write(BinaryWriter writer, Subject obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.ass)
      ..writeByte(2)
      ..write(obj.total)
      ..writeByte(3)
      ..write(obj.highest)
      ..writeByte(4)
      ..write(obj.lowest)
      ..writeByte(5)
      ..write(obj.pos)
      ..writeByte(6)
      ..write(obj.average)
      ..writeByte(7)
      ..write(obj.grade);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
