import 'package:meta/meta.dart';

import 'brokerage_fee.dart';
import 'variable_fee.dart';

class VariableBrokerageFee extends BrokerageFee {
  final List<VariableFee> fees;

  const VariableBrokerageFee({
    @required this.fees,
  });
}