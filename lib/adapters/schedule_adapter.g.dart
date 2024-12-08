// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleAdapterAdapter extends TypeAdapter<ScheduleAdapter> {
  @override
  final int typeId = 1;

  @override
  ScheduleAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleAdapter(
      id: fields[0] as int,
      hallId: fields[1] as int,
      workoutId: fields[2] as int,
      couchId: fields[3] as int,
      scheduleTimeId: fields[4] as int,
      date: fields[5] as String,
      countRecord: fields[6] as int,
      workoutName: fields[7] as String,
      typeName: fields[8] as String,
      createdAt: fields[9] as String,
      updatedAt: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleAdapter obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.hallId)
      ..writeByte(2)
      ..write(obj.workoutId)
      ..writeByte(3)
      ..write(obj.couchId)
      ..writeByte(4)
      ..write(obj.scheduleTimeId)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.countRecord)
      ..writeByte(7)
      ..write(obj.workoutName)
      ..writeByte(8)
      ..write(obj.typeName)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
