// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouriteAdapter extends TypeAdapter<Favourite> {
  @override
  Favourite read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favourite(
      name: fields[0] as String,
      purchasePrice: fields[1] as double,
      shareQuantity: fields[3] as int,
      sellingPrice: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Favourite obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.purchasePrice)
      ..writeByte(2)
      ..write(obj.sellingPrice)
      ..writeByte(3)
      ..write(obj.shareQuantity);
  }
}
