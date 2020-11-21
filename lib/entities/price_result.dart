import 'package:meta/meta.dart';

class PriceResult {
  final double sharePrice;
  final int shareQuantity;
  final double grossAmount;
  final double clearingFee;
  final double brokerageFee;
  final double stampDuty;
  final double serviceTax;

    PriceResult({
      @required this.sharePrice,
      @required this.shareQuantity,
      @required this.grossAmount,
      @required this.clearingFee,
      @required this.brokerageFee,
      @required this.stampDuty,
      @required this.serviceTax,
    });

    double getTotalAmount() {
      return this.grossAmount + this.clearingFee + this.brokerageFee + this.stampDuty + this.serviceTax;
    }

    double getTotalFees() {
      return this.clearingFee + this.brokerageFee + this.stampDuty + this.serviceTax;
    }
  
}