import 'package:flutter/material.dart';

import '../entities/broker.dart';
import '../entities/constant_brokerage_fee.dart';
import '../entities/fee.dart';
import '../entities/variable_brokerage_fee.dart';
import '../entities/variable_fee.dart';
import '../enums/brokerage_fee_type.dart';
import '../helpers/broker_helper.dart';
import '../resources/strings.dart';

class ViewBrokerPage extends StatefulWidget {
  @override
  _ViewBrokerPageState createState() => _ViewBrokerPageState();
}

class _ViewBrokerPageState extends State<ViewBrokerPage> {
  BrokerHelper _brokerHelper;
  List<Broker> _brokerList;
  final TextStyle _headerStyle = const TextStyle(
    fontWeight: FontWeight.w800,
  );
  final TextStyle _cellStyle = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );
  final SizedBox _horizontalSizedBoxSpace = const SizedBox(width: 10);

  @override
  void initState() {
    super.initState();

    _brokerHelper = BrokerHelper();
    _brokerList = _brokerHelper.getAllAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: Color(0xFF999999),
        ),
        itemCount: _brokerList.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(15),
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
                      Text(_brokerList[index].name),
                      Text(
                        _brokerList[index].accountType,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                _horizontalSizedBoxSpace,
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Minimum: ",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                          "RM${_brokerList[index].minimum.toStringAsFixed(2)}"),
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
                        "Fees: ",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        _convertFeesFormat(_brokerList[index]),
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<DataRow> _buildRows() {
    List<DataRow> rows = [];
    for (int i = 0; i < _brokerList.length; i++) {
      Broker broker = _brokerList[i];
      rows.add(
        DataRow(
          cells: [
            _buildCell(broker.name),
            _buildCell(broker.accountType),
            _buildCell(_convertFeesFormat(broker)),
            _buildCell(broker.minimum.toString()),
          ],
        ),
      );
    }

    return rows;
  }

  DataCell _buildCell(String text) {
    return DataCell(
      Text(text, style: _cellStyle),
    );
  }

  DataColumn _buildHeader(String text) {
    return DataColumn(
      label: Text(text, style: _headerStyle),
    );
  }

  String _convertFeesFormat(Broker broker) {
    String stringBuilder = Strings.empty;
    if (broker.brokerageFeeType == BrokerageFeeType.Constant) {
      ConstantBrokerageFee fee = broker.fee as ConstantBrokerageFee;
      stringBuilder += _convertFeeAmount(fee.fee);
    } else {
      List<VariableFee> fees = (broker.fee as VariableBrokerageFee).fees;
      for (int i = 0; i < fees.length; i++) {
        String newLine = (i != fees.length - 1) ? "\n" : "";
        VariableFee fee = fees[i];
        if (fee.maxValue == double.infinity) {
          stringBuilder +=
              ">${_addNumericPrefix(fee.minValue)}: ${_convertFeeAmount(fee.fee)}${newLine}";
        } else {
          stringBuilder +=
              "${_addNumericPrefix(fee.minValue)}-${_addNumericPrefix(fee.maxValue)}: ${_convertFeeAmount(fee.fee)}${newLine}";
        }
      }
    }

    return stringBuilder;
  }

  String _addNumericPrefix(double value) {
    double divide = value / 1000;
    if (divide >= 1) {
      return "${divide.toInt()}K";
    } else {
      return "${divide.toInt()}";
    }
  }

  String _convertFeeAmount(Fee fee) {
    if (fee.isPercentage) {
      return "${fee.isPercentage ? '' : 'RM'} ${fee.amount}${fee.isPercentage ? '%' : Strings.empty}";
    } else {
      return "${fee.isPercentage ? '' : 'RM'} ${fee.amount.toStringAsFixed(2)}${fee.isPercentage ? '%' : Strings.empty}";
    }
  }
}
