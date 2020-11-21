import 'package:meta/meta.dart';

import 'brokerage_fee.dart';
import 'fee.dart';

class ConstantBrokerageFee extends BrokerageFee {
  final Fee fee;

  ConstantBrokerageFee({
    @required this.fee,
  });
}