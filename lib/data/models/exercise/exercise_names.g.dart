// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_names.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseNamesAdapter extends TypeAdapter<ExerciseNames> {
  @override
  final int typeId = 0;

  @override
  ExerciseNames read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseNames(
      (fields[0] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseNames obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.names);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseNamesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
