// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TermClassAdapter extends TypeAdapter<TermClass> {
  @override
  final int typeId = 1;

  @override
  TermClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TermClass(
      fields[0] as String,
    )
      ..students = (fields[1] as List)?.cast<Student>()
      ..subjects = (fields[2] as List)?.cast<String>();
  }

  @override
  void write(BinaryWriter writer, TermClass obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.termName)
      ..writeByte(1)
      ..write(obj.students)
      ..writeByte(2)
      ..write(obj.subjects);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TermClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
