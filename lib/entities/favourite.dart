import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'favourite.g.dart';

@HiveType(typeId: 0)
class Favourite {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double purchasePrice;
  @HiveField(2)
  final double sellingPrice;
  @HiveField(3)
  final int shareQuantity;

  Favourite({@required this.name, @required this.purchasePrice, @required this.shareQuantity, this.sellingPrice});
}
