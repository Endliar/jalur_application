// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_detail_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutDetailAdapterAdapter extends TypeAdapter<WorkoutDetailAdapter> {
  @override
  final int typeId = 2;

  @override
  WorkoutDetailAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutDetailAdapter(
      id: fields[0] as int,
      typeWorkoutId: fields[1] as int,
      name: fields[2] as String,
      typeName: fields[3] as String,
      description: fields[4] as String,
      images: fields[5] as String,
      createdAt: fields[6] as String,
      updatedAt: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutDetailAdapter obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.typeWorkoutId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.typeName)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.images)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutDetailAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
