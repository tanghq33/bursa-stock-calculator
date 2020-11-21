import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../entities/price_result.dart';
import '../resources/strings.dart';

class PriceResultPage extends StatelessWidget {
  final PriceResult priceResult;
  final SizedBox _horizontalSizedBoxSpace = const SizedBox(height: 20);

  PriceResultPage({Key key, @required this.priceResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.priceResultTitle,
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
                      _buildCell(Strings.priceLabel, true),
                      _buildCell(
                        this.priceResult.sharePrice.toStringAsFixed(2),
                        false,
                      ),
                      _buildCell(
                        this.priceResult.shareQuantity.toStringAsFixed(2),
                        false,
                      ),
                      _buildCell(
                        this.priceResult.grossAmount.toStringAsFixed(2),
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
                        this.priceResult.brokerageFee.toStringAsFixed(2),
                        false,
                      ),
                      _buildCell(
                        this.priceResult.clearingFee.toStringAsFixed(2),
                        false,
                      ),
                      _buildCell(
                        this.priceResult.stampDuty.toStringAsFixed(2),
                        false,
                      ),
                      _buildCell(
                        this.priceResult.serviceTax.toStringAsFixed(2),
                        false,
                      ),
                      _buildCell(
                        this.priceResult.getTotalAmount().toStringAsFixed(2),
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
                'Stock Price',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.blueGrey[700],
                ),
              ),
            ),
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
                  height: 100,
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Amount: RM${(this.priceResult.getTotalAmount() - this.priceResult.getTotalFees()).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.blueGrey[700],
                        ),
                      ),
                      Text(
                        "Fees: RM${this.priceResult.getTotalFees().toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.blueGrey[700],
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
}
