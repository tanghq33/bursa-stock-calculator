import 'package:meta/meta.dart';

class Fee {
  final double amount;
  final bool isPercentage;

  Fee({
    @required this.amount,
    @required this.isPercentage
  });
}