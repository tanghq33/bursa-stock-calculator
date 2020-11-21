import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../entities/profit_result.dart';
import '../resources/strings.dart';

class ProfitResultPage extends StatelessWidget {
  final ProfitResult profitResult;
  final SizedBox _horizontalSizedBoxSpace = const SizedBox(height: 20);

  ProfitResultPage({Key key, @required this.profitResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.profitResultTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildCell(Strings.empty, false),
                        _buildCell(
                          Strings.tradePriceLabel,
                          true,
                        ),
                        _buildCell(
                          Strings.totalShareLabel,
                          true,
                        ),
                        _buildCell(
                          Strings.proceedLabel,
                          true,
                        ),
                        _horizontalSizedBoxSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 6),
                          child: Text(
                            Strings.feesLabel,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        _buildCell(
                          Strings.brokerageFeeLabel,
                          true,
                        ),
                        _buildCell(
                          Strings.clearingFeeLabel,
                          true,
                        ),
                        _buildCell(
                          Strings.stampDutyLabel,
                          true,
                        ),
                        _buildCell(
                          Strings.serviceTaxLabel,
                          true,
                        ),
                        _buildCell(
                          Strings.contractPriceLabel,
                          true,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      _buildCell(Strings.purchaseLabel, true),
                      _buildCell(
                        this
                            .profitResult
                            .purchasePriceResult
                            .sharePrice
                            .toStringAsFixed(2),
                        false,
                      ),
                      _buildCell(
                        this
                            .profitResult
                            .purchasePriceResult
                            .shareQuantity
                            .toStringAsFixed(2),
                        false,
                      ),
                      _buildCell(
                        this
                            .profitResult
                            .purchasePriceResult
                            .grossAmount
                            .toStringAsFixed(2),
                        false,
                      ),
                      _horizontalSizedBoxSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          Strings.empty,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      _buildCell(
                        this
                            .profitResult
                            .purchasePriceResult
                            .brokerageFee
                            .toStringAsFixed(2),
                        false,
                      ),
                      _buildCell(
                        this
                            .profitResult
                            .purchasePriceResult
                            .clearingFee
                            .toStringAsFixed(2),
                        false,
                      ),
                      _buildCell(
                        this
                            .profitResult
                            .purchasePriceResult
                            .stampDuty
                            .toStringAsFixed(2),
                        false,
                      ),
                      _buildCell(
                        this
                            .profitResult
                            .purchasePriceResult
                            .serviceTax
                            .toStringAsFixed(2),
                        false,
                      ),
                      _buildCell(
                        this
                            .profitResult
                            .purchaseContractPrice
                            .toStringAsFixed(2),
                        true,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      _buildCell(
                        Strings.sellingLabel,
                        true,
                      ),
                      _buildCell(
                        this
                            .profitResult
                            .sellingPriceResult
                            .sharePrice
                            .toStringAsFixed(2),
                        false,
                      ),
                      _buildCell(
                        this
                            .profitResult
                            .sellingPriceResult
                            .shareQuantity
                            .toStringAsFixed(2),
                        false,
                      ),
                      _buildCell(
                        this
                            .profitResult
                            .sellingPriceResult
                            .grossAmount
                            .toStringAsFixed(2),
                        false,
                      ),
                      _horizontalSizedBoxSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          Strings.empty,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      _buildCell(
                        this
                            .profitResult
                            .sellingPriceResult
                            .brokerageFee
                            .toStringAsFixed(2),
                        false,
                      ),
                      _buildCell(
                        this
                            .profitResult
                            .sellingPriceResult
                            .clearingFee
                            .toStringAsFixed(2),
                        false,
                      ),
                      _buildCell(
                        this
                            .profitResult
                            .sellingPriceResult
                            .stampDuty
                            .toStringAsFixed(2),
                        false,
                      ),
                      _buildCell(
                        this
                            .profitResult
                            .sellingPriceResult
                            .serviceTax
                            .toStringAsFixed(2),
                        false,
                      ),
                      _buildCell(
                        this
                            .profitResult
                            .sellingContractPrice
                            .toStringAsFixed(2),
                        true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _horizontalSizedBoxSpace,
            _horizontalSizedBoxSpace,
            Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  'Profit',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.blueGrey[700],
                  ),
                )),
            DottedBorder(
              dashPattern: [10, 7, 10, 7],
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              padding: EdgeInsets.all(6),
              strokeWidth: 3,
              color: Colors.blueGrey[700],
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Container(
                  height: 120,
                  width: 250,
                  color: _getProfitColor(this.profitResult.profit)
                      .withOpacity(0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "RM" + this.profitResult.profit.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: _getProfitColor(this.profitResult.profit),
                        ),
                      ),
                      Text(
                        "(${this.profitResult.profitInPercentage.toStringAsFixed(2)}%)",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: _getProfitColor(
                              this.profitResult.profitInPercentage),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String label, bool bold) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Text(
        label,
        style: (bold
            ? TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              )
            : TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              )),
      ),
    );
  }

  Color _getProfitColor(double value) {
    Color color;
    if (value > 0) {
      color = Colors.green;
    } else if (value < 0) {
      color = Colors.red;
    } else {
      color = Colors.black;
    }
    return color;
  }
}
