// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClassAdapter extends TypeAdapter<Class> {
  @override
  final int typeId = 0;

  @override
  Class read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Class(
      fields[0] as String,
      fields[1] as String,
    )
      ..terms = (fields[2] as List)?.cast<TermClass>()
      ..studentsAnnual = (fields[3] as List)?.cast<StudentAnnual>()
      ..ftName = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, Class obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.className)
      ..writeByte(1)
      ..write(obj.session)
      ..writeByte(2)
      ..write(obj.terms)
      ..writeByte(3)
      ..write(obj.studentsAnnual)
      ..writeByte(4)
      ..write(obj.ftName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
