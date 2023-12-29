// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employe_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeAdapter extends TypeAdapter<Employe> {
  @override
  final int typeId = 0;

  @override
  Employe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Employe()
      ..firstName = fields[0] as String
      ..lastName = fields[1] as String
      ..status = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, Employe obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
