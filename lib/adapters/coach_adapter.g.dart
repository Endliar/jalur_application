// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coach_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CoachAdapterAdapter extends TypeAdapter<CoachAdapter> {
  @override
  final int typeId = 3;

  @override
  CoachAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CoachAdapter(
      id: fields[0] as int,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      middleName: fields[3] as String?,
      age: fields[4] as int?,
      description: fields[5] as String?,
      role: fields[6] as String,
      gender: fields[7] as String,
      image: fields[8] as String?,
      sizeCloth: fields[9] as int?,
      phone: fields[10] as String,
      updatedAt: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CoachAdapter obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.middleName)
      ..writeByte(4)
      ..write(obj.age)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.role)
      ..writeByte(7)
      ..write(obj.gender)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.sizeCloth)
      ..writeByte(10)
      ..write(obj.phone)
      ..writeByte(11)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoachAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
