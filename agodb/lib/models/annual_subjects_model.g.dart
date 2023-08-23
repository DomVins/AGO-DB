// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annual_subjects_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectAnnualAdapter extends TypeAdapter<SubjectAnnual> {
  @override
  final int typeId = 5;

  @override
  SubjectAnnual read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectAnnual(
      fields[0] as String,
    )
      ..termTotal = (fields[1] as List)?.cast<int>()
      ..yearTotal = fields[2] as int
      ..average = fields[3] as double
      ..position = fields[4] as int
      ..higestInClass = fields[5] as int
      ..loswetInClass = fields[6] as int;
  }

  @override
  void write(BinaryWriter writer, SubjectAnnual obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.termTotal)
      ..writeByte(2)
      ..write(obj.yearTotal)
      ..writeByte(3)
      ..write(obj.average)
      ..writeByte(4)
      ..write(obj.position)
      ..writeByte(5)
      ..write(obj.higestInClass)
      ..writeByte(6)
      ..write(obj.loswetInClass);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectAnnualAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
