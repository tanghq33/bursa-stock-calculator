import 'package:stockcalculator/entities/profit_result.dart';

import '../entities/price_result.dart';
import 'compare_helper.dart';

import '../entities/broker.dart';
import '../entities/constant_brokerage_fee.dart';
import '../entities/variable_brokerage_fee.dart';
import '../enums/brokerage_fee_type.dart';

class CalculateHelper {
  static final double _clearingFeeRate = 0.0003; // 0.03%, Maximum 1000
  static final double _stampDutyRate = 0.0015; // RM1.5 for every RM1000 (0.15% ~ 0.0015), Maximum 1000
  static final double _serviceTaxRate = 0.06; // 6% Service Tax

  static PriceResult calculatePrice(
    double sharePrice,
    int numberOfShares,
    Broker broker,
    bool excludeSST,
  ) {
    double grossAmount = sharePrice * numberOfShares;
    double clearingFee = _calculateClearingFee(grossAmount);
    double stampDuty = _calculateStampDuty(grossAmount);
    double brokerageFee;
    double serviceTax;

    if (broker.brokerageFeeType == BrokerageFeeType.Constant) {
      ConstantBrokerageFee constantBrokerageFee = broker.fee as ConstantBrokerageFee;

      if (constantBrokerageFee.fee.isPercentage) {
        brokerageFee = grossAmount * constantBrokerageFee.fee.amount;
      } else {
        brokerageFee = constantBrokerageFee.fee.amount;
      }
    } else {
      VariableBrokerageFee variableBrokerageFee = broker.fee as VariableBrokerageFee;
      var fees = variableBrokerageFee.fees;

      for (int i = 0; i < fees.length; i++) {
        if (grossAmount >= fees[i].minValue && grossAmount < fees[i].maxValue) {
          if (CompareHelper.between(
              grossAmount, fees[i].minValue, fees[i].minSign, fees[i].maxValue, fees[i].maxSign)) {
            if (fees[i].fee.isPercentage) {
              brokerageFee = grossAmount * fees[i].fee.amount;
            } else {
              brokerageFee = fees[i].fee.amount;
            }
            break;
          }
        }
      }
    }

    if (brokerageFee < broker.minimum) {
      brokerageFee = broker.minimum;
    }

    serviceTax = excludeSST ? 0 : _calculateServiceTax(brokerageFee);

    return PriceResult(
      sharePrice: sharePrice,
      shareQuantity: numberOfShares,
      grossAmount: grossAmount,
      brokerageFee: brokerageFee,
      clearingFee: clearingFee,
      stampDuty: stampDuty,
      serviceTax: serviceTax,
    );
  }

  static ProfitResult calculateProfit(PriceResult purchasePrice, PriceResult sellingPrice) {
    double purchasePriceAmount = purchasePrice.getTotalAmount();
    double sellingPriceAmount = sellingPrice.grossAmount - sellingPrice.getTotalFees();

    double profit = sellingPriceAmount - purchasePriceAmount;
    double profitInPercentage = (profit / purchasePriceAmount) * 100;

    return ProfitResult(
      purchasePriceResult: purchasePrice,
      sellingPriceResult: sellingPrice,
      purchaseContractPrice: purchasePriceAmount,
      sellingContractPrice: sellingPriceAmount,
      profit: profit,
      profitInPercentage: profitInPercentage,
    );
  }

  /*
  ** Clearing Fee
  ** 0.03% up to a maximum of RM1,000.00 per contract
  */
  static double _calculateClearingFee(double grossAmount) {
    double clearingFee = num.parse((grossAmount * _clearingFeeRate).toStringAsFixed(2));
    return clearingFee > 1000 ? 1000 : clearingFee;
  }

  /*
  ** Stamp Duty
  ** RM1.00 for every RM1,000.00 in trading value (Maximum amount RM200.00 per contract)
  */
  static double _calculateStampDuty(double grossAmount) {
    double stampDuty = num.parse((grossAmount * _stampDutyRate).ceil().toStringAsFixed(2));
    return stampDuty > 1000 ? 1000 : stampDuty;
  }

  /*
  ** Service Tax
  ** 6% ST will be imposed only brokerage fees
  */
  static double _calculateServiceTax(double brokerageFee) {
    double serviceTax = brokerageFee * _serviceTaxRate;
    return serviceTax;
  }

  /*
  ** Compare Brokers
  ** Calcualte All Brokers brokerage fees and compare
  */
  static Map<Broker, PriceResult> compareBrokers(List<Broker> brokerList, double purchasePrice, int shareQuantity) {
    Map<Broker, PriceResult> compareBrokerResult = new Map<Broker, PriceResult>();
    for (int i = 0; i < brokerList.length; i++) {
      Broker broker = brokerList[i];
      PriceResult result = calculatePrice(purchasePrice, shareQuantity, broker, false);
      compareBrokerResult[broker] = result;
    }
    var sortedMap = Map.fromEntries(
        compareBrokerResult.entries.toList()..sort((e1, e2) => e1.value.brokerageFee.compareTo(e2.value.brokerageFee)));
    return sortedMap;
  }
}
