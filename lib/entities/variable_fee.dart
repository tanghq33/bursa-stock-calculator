import 'package:meta/meta.dart';

import '../enums/sign_type.dart';
import 'fee.dart';

class VariableFee {
  final double minValue;
  final SignType minSign;
  final double maxValue;
  final SignType maxSign;
  final Fee fee;

  VariableFee({
    @required this.minValue,
    @required this.minSign,
    @required this.maxValue,
    @required this.maxSign,
    @required this.fee,
  });
}