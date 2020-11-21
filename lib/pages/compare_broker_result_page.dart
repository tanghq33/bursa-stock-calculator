import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stockcalculator/entities/broker.dart';
import 'package:stockcalculator/entities/price_result.dart';
import 'package:stockcalculator/resources/strings.dart';

class CompareBrokerResultPage extends StatelessWidget {
  final bool isIncludeFees;
  final Map<Broker, PriceResult> compareBrokerResult;

  CompareBrokerResultPage({
    @required this.compareBrokerResult,
    @required this.isIncludeFees,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.compareBrokerResultTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            height: 1,
            color: Color(0xFF999999),
          ),
          itemCount: this.compareBrokerResult.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          this.compareBrokerResult.keys.elementAt(index).name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          this
                              .compareBrokerResult
                              .keys
                              .elementAt(index)
                              .accountType,
                          style: const TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Strings.brokerageFeeText,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "RM" +
                              (isIncludeFees
                                  ? this
                                      .compareBrokerResult
                                      .values
                                      .elementAt(index)
                                      .getTotalFees()
                                      .toStringAsFixed(2)
                                  : this
                                      .compareBrokerResult
                                      .values
                                      .elementAt(index)
                                      .brokerageFee
                                      .toStringAsFixed(2)),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // _horizontalSizedBoxSpace,
                  //   Expanded(
                  //     flex: 2,
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: <Widget>[
                  //         Text(
                  //           "Minimum: ",
                  //           style: TextStyle(fontSize: 12),
                  //         ),
                  //         Text(
                  //             "RM${_brokerList[index].minimum.toStringAsFixed(2)}"),
                  //       ],
                  //     ),
                  //   ),
                  //   Expanded(
                  //     flex: 2,
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: <Widget>[
                  //         Text(
                  //           "Fees: ",
                  //           style: TextStyle(fontSize: 12),
                  //         ),
                  //         Text(
                  //           // _convertFeesFormat(_brokerList[index]),
                  //           style: const TextStyle(
                  //             fontSize: 11,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                ],
              ),
            );
          },
        ),
      ),
    );
    //       },
    //     ),
    //   );
  }
}
