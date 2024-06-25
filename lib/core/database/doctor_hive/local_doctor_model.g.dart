// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_doctor_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalDoctorModelAdapter extends TypeAdapter<LocalDoctorModel> {
  @override
  final int typeId = 0;

  @override
  LocalDoctorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalDoctorModel(
      doctorEmail: fields[0] as String?,
      doctorName: fields[1] as String?,
      id: fields[2] as int?,
      phone: fields[3] as String?,
      image: fields[4] as String?,
      gender: fields[5] as String?,
      specialization: fields[6] as String?,
      about: fields[7] as String?,
      workDay: fields[8] as List<String>?,
      averageRating: fields[9] as double?,
      experience: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalDoctorModel obj) {
    writer
      ..writeByte(0)
      ..write(obj.doctorEmail)
      ..writeByte(1)
      ..write(obj.doctorName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.specialization)
      ..writeByte(7)
      ..write(obj.about)
      ..writeByte(8)
      ..write(obj.workDay)
      ..writeByte(9)
      ..write(obj.averageRating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalDoctorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
