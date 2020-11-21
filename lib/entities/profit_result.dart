import 'package:meta/meta.dart';
import 'package:stockcalculator/entities/price_result.dart';

class ProfitResult {
  final PriceResult purchasePriceResult;
  final PriceResult sellingPriceResult;
  final double purchaseContractPrice;
  final double sellingContractPrice;
  final double profit;
  final double profitInPercentage;

  ProfitResult({
    @required this.purchasePriceResult,
    @required this.sellingPriceResult,
    @required this.purchaseContractPrice,
    @required this.sellingContractPrice,
    @required this.profit,
    @required this.profitInPercentage,
  });
}
