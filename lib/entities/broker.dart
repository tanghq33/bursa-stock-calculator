import 'package:meta/meta.dart';

import '../enums/brokerage_fee_type.dart';
import 'brokerage_fee.dart';

class Broker {
  final String name;
  final String accountType;
  final BrokerageFeeType brokerageFeeType;
  final double intraday;
  final double minimum;
  final BrokerageFee fee;

  Broker({
    @required this.name,
    @required this.accountType,
    @required this.brokerageFeeType,
    @required this.intraday,
    @required this.minimum,
    @required this.fee,
  });
}