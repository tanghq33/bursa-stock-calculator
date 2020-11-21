import 'package:stockcalculator/enums/sign_type.dart';

import '../entities/broker.dart';
import '../entities/constant_brokerage_fee.dart';
import '../entities/fee.dart';
import '../entities/variable_brokerage_fee.dart';
import '../entities/variable_fee.dart';
import '../enums/brokerage_fee_type.dart';

class BrokerHelper {
  static final BrokerHelper _instance = BrokerHelper._ctor();
  Map<int, Broker> _brokerMap;

  factory BrokerHelper() {
    return _instance;
  }

  BrokerHelper._ctor() {
    _brokerMap = {};
    _brokerMap[0] = _rakutenTrade();
    _brokerMap[1] = _affinHwangCapitalCashUpfront();
    _brokerMap[2] = _amEquitiesCashUpfront();
    _brokerMap[3] = _amEquitiesCollaterised();
    _brokerMap[4] = _jfApexCashUpfront();
    _brokerMap[5] = _jfApexCollaterised();
    _brokerMap[6] = _bimbSecuritiesCashUpfront();
    _brokerMap[7] = _cgsCimbiTrade();
    _brokerMap[8] = _cimbClicksTrader();
    _brokerMap[9] = _hongLeongBankCashUpfront();
    _brokerMap[10] = _hongLeongBankCollaterised();
    _brokerMap[11] = _kenangaCashUpfront();
    _brokerMap[12] = _maybankCashUpfront();
    _brokerMap[13] = _maybankCollaterised();
    _brokerMap[14] = _mecurySecuritiesCashUpfront();
    _brokerMap[15] = _mplusOnlineSilver();
    _brokerMap[16] = _mplusOnlineGold();
    _brokerMap[17] = _mplusOnlineTPlus7();
    _brokerMap[18] = _publicBankCashUpfront();
    _brokerMap[19] = _rhbInvest();
    _brokerMap[20] = _rhbTradeSmart();
    _brokerMap[21] = _sjSecuritiesCashUpfront();
    _brokerMap[22] = _uobKayHianCashUpfront();
    _brokerMap[23] = _uobKayHianCollaterised();
  }

  List<Broker> getAllAccounts() {
    return _brokerMap.values.toList();
  }

  List<String> getAllBrokers() {
    Map<String, Broker> mp = {};

    for (var broker in _brokerMap.values) {
      mp[broker.name] = broker;
    }

    return mp.keys.toList();
  }

  List<Broker> getAccounts(String brokerName) {
    return _brokerMap.values
        .where((broker) => broker.name == brokerName)
        .toList();
  }

  Broker getAccountById(int id) {
    return _brokerMap[id];
  }

  int getAccountId(Broker broker) {
    return _brokerMap.values.toList().indexOf(broker);
  }

  Broker _affinHwangCapitalCashUpfront() {
    var fee = VariableBrokerageFee(
      fees: [
        VariableFee(
          minValue: 0,
          minSign: SignType.GreaterOrEqual,
          maxValue: 100000,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.007, isPercentage: true),
        ),
        VariableFee(
          minValue: 100000,
          minSign: SignType.Greater,
          maxValue: double.infinity,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.005, isPercentage: true),
        ),
      ],
    );

    var broker = Broker(
      accountType: 'Cash Upfront',
      brokerageFeeType: BrokerageFeeType.Variable,
      fee: fee,
      intraday: 0.0015,
      minimum: 28,
      name: 'Affin Hwang Capital',
    );
    return broker;
  }

  Broker _amEquitiesCashUpfront() {
    var fee = ConstantBrokerageFee(
      fee: Fee(
        amount: 0.0005,
        isPercentage: true,
      ),
    );

    var broker = Broker(
      accountType: 'Cash Upfront',
      brokerageFeeType: BrokerageFeeType.Constant,
      fee: fee,
      intraday: 0.0015,
      minimum: 8,
      name: 'AmEquities',
    );

    return broker;
  }

  Broker _amEquitiesCollaterised() {
    var fee = VariableBrokerageFee(
      fees: [
        VariableFee(
          minValue: 0,
          minSign: SignType.GreaterOrEqual,
          maxValue: 100000,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.004, isPercentage: true),
        ),
        VariableFee(
          minValue: 100000,
          minSign: SignType.Greater,
          maxValue: double.infinity,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.002, isPercentage: true),
        ),
      ],
    );

    var broker = Broker(
      accountType: 'Collaterised',
      brokerageFeeType: BrokerageFeeType.Variable,
      fee: fee,
      intraday: 0.0015,
      minimum: 28,
      name: 'AmEquities',
    );
    return broker;
  }

  Broker _jfApexCashUpfront() {
    var fee = ConstantBrokerageFee(
      fee: Fee(
        amount: 0.0005,
        isPercentage: true,
      ),
    );

    var broker = Broker(
      accountType: 'Cash Upfront',
      brokerageFeeType: BrokerageFeeType.Constant,
      fee: fee,
      intraday: 0,
      minimum: 28,
      name: 'JF Apex',
    );

    return broker;
  }

  Broker _jfApexCollaterised() {
    var fee = VariableBrokerageFee(
      fees: [
        VariableFee(
          minValue: 0,
          minSign: SignType.GreaterOrEqual,
          maxValue: 100000,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.006, isPercentage: true),
        ),
        VariableFee(
          minValue: 100000,
          minSign: SignType.Greater,
          maxValue: double.infinity,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.003, isPercentage: true),
        ),
      ],
    );

    var broker = Broker(
      accountType: 'Collaterised',
      brokerageFeeType: BrokerageFeeType.Variable,
      fee: fee,
      intraday: 0.0015,
      minimum: 28,
      name: 'JF Apex',
    );
    return broker;
  }

  Broker _bimbSecuritiesCashUpfront() {
    var fee = VariableBrokerageFee(
      fees: [
        VariableFee(
          minValue: 0,
          minSign: SignType.GreaterOrEqual,
          maxValue: 100000,
          maxSign: SignType.SmallerOrEqual,
          fee: new Fee(amount: 0.003, isPercentage: true),
        ),
        VariableFee(
          minValue: 100000,
          minSign: SignType.Greater,
          maxValue: double.infinity,
          maxSign: SignType.SmallerOrEqual,
          fee: new Fee(amount: 0.002, isPercentage: true),
        ),
      ],
    );

    var broker = Broker(
      accountType: 'Cash Upfront',
      brokerageFeeType: BrokerageFeeType.Variable,
      fee: fee,
      intraday: 0.0015,
      minimum: 14,
      name: 'BIMB Securities',
    );
    return broker;
  }

  Broker _cgsCimbiTrade() {
    var fee = ConstantBrokerageFee(
      fee: Fee(
        amount: 0.0042,
        isPercentage: true,
      ),
    );

    var broker = Broker(
      accountType: 'iTrade',
      brokerageFeeType: BrokerageFeeType.Constant,
      fee: fee,
      intraday: 0,
      minimum: 28,
      name: 'CGS-CIMB',
    );

    return broker;
  }

  Broker _cimbClicksTrader() {
    var fee = ConstantBrokerageFee(
      fee: Fee(
        amount: 0.000388,
        isPercentage: true,
      ),
    );

    var broker = Broker(
      accountType: 'Clicks Trader',
      brokerageFeeType: BrokerageFeeType.Constant,
      fee: fee,
      intraday: 0,
      minimum: 8.88,
      name: 'CIMB',
    );

    return broker;
  }

  Broker _hongLeongBankCashUpfront() {
    var fee = ConstantBrokerageFee(
      fee: Fee(
        amount: 0.001,
        isPercentage: true,
      ),
    );

    var broker = Broker(
      accountType: 'Cash Upfront',
      brokerageFeeType: BrokerageFeeType.Constant,
      fee: fee,
      intraday: 0.001,
      minimum: 8,
      name: 'Hong Leong Bank',
    );

    return broker;
  }

  Broker _hongLeongBankCollaterised() {
    var fee = VariableBrokerageFee(
      fees: [
        VariableFee(
          minValue: 0,
          minSign: SignType.GreaterOrEqual,
          maxValue: 100000,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.0038, isPercentage: true),
        ),
        VariableFee(
          minValue: 100000,
          minSign: SignType.Greater,
          maxValue: double.infinity,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.0018, isPercentage: true),
        ),
      ],
    );

    var broker = Broker(
      accountType: 'Collaterised',
      brokerageFeeType: BrokerageFeeType.Variable,
      fee: fee,
      intraday: 0.001,
      minimum: 8,
      name: 'Hong Leong Bank',
    );

    return broker;
  }

  Broker _kenangaCashUpfront() {
    var fee = VariableBrokerageFee(
      fees: [
        VariableFee(
          minValue: 0,
          minSign: SignType.GreaterOrEqual,
          maxValue: 100000,
          maxSign: SignType.SmallerOrEqual,
          fee: new Fee(amount: 0.0042, isPercentage: true),
        ),
        VariableFee(
          minValue: 100000,
          minSign: SignType.Greater,
          maxValue: double.infinity,
          maxSign: SignType.SmallerOrEqual,
          fee: new Fee(amount: 0.0021, isPercentage: true),
        ),
      ],
    );

    var broker = Broker(
      accountType: 'Cash Upfront',
      brokerageFeeType: BrokerageFeeType.Variable,
      fee: fee,
      intraday: 0,
      minimum: 28,
      name: 'Kenanga',
    );
    return broker;
  }

  Broker _maybankCashUpfront() {
    var fee = ConstantBrokerageFee(
      fee: Fee(
        amount: 0.001,
        isPercentage: true,
      ),
    );

    var broker = Broker(
      accountType: 'Cash Upfront',
      brokerageFeeType: BrokerageFeeType.Constant,
      fee: fee,
      intraday: 0,
      minimum: 8,
      name: 'Maybank',
    );

    return broker;
  }

  Broker _maybankCollaterised() {
    var fee = VariableBrokerageFee(
      fees: [
        VariableFee(
          minValue: 0,
          minSign: SignType.GreaterOrEqual,
          maxValue: 100000,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.0042, isPercentage: true),
        ),
        VariableFee(
          minValue: 100000,
          minSign: SignType.Greater,
          maxValue: double.infinity,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.0021, isPercentage: true),
        ),
      ],
    );

    var broker = Broker(
      accountType: 'Collaterised',
      brokerageFeeType: BrokerageFeeType.Variable,
      fee: fee,
      intraday: 0.0015,
      minimum: 12,
      name: 'Maybank',
    );

    return broker;
  }

  Broker _mecurySecuritiesCashUpfront() {
    var fee = VariableBrokerageFee(
      fees: [
        VariableFee(
          minValue: 0,
          minSign: SignType.GreaterOrEqual,
          maxValue: 100000,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.0042, isPercentage: true),
        ),
        VariableFee(
          minValue: 100000,
          minSign: SignType.Greater,
          maxValue: double.infinity,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.0021, isPercentage: true),
        ),
      ],
    );

    var broker = Broker(
      accountType: 'Cash Upfront',
      brokerageFeeType: BrokerageFeeType.Variable,
      fee: fee,
      intraday: 0.0015,
      minimum: 12,
      name: 'Mecury Securities',
    );
    return broker;
  }

  Broker _mplusOnlineSilver() {
    var fee = VariableBrokerageFee(
      fees: [
        VariableFee(
          minValue: 0,
          minSign: SignType.GreaterOrEqual,
          maxValue: 50000,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.0008, isPercentage: true),
        ),
        VariableFee(
          minValue: 50000,
          minSign: SignType.Greater,
          maxValue: double.infinity,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.0005, isPercentage: true),
        ),
      ],
    );

    var broker = Broker(
      accountType: 'M+ Silver',
      brokerageFeeType: BrokerageFeeType.Variable,
      fee: fee,
      intraday: 0.0005,
      minimum: 8,
      name: 'Mplus Online',
    );
    return broker;
  }

  Broker _mplusOnlineGold() {
    var fee = VariableBrokerageFee(
      fees: [
        VariableFee(
          minValue: 0,
          minSign: SignType.GreaterOrEqual,
          maxValue: 50000,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.003, isPercentage: true),
        ),
        VariableFee(
          minValue: 50000,
          minSign: SignType.Greater,
          maxValue: double.infinity,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.002, isPercentage: true),
        ),
      ],
    );

    var broker = Broker(
      accountType: 'M+ Gold',
      brokerageFeeType: BrokerageFeeType.Variable,
      fee: fee,
      intraday: 0.001,
      minimum: 10,
      name: 'Mplus Online',
    );
    return broker;
  }

  Broker _mplusOnlineTPlus7() {
    var fee = VariableBrokerageFee(
      fees: [
        VariableFee(
          minValue: 0,
          minSign: SignType.GreaterOrEqual,
          maxValue: 50000,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.003, isPercentage: true),
        ),
        VariableFee(
          minValue: 50000,
          minSign: SignType.Greater,
          maxValue: double.infinity,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.0025, isPercentage: true),
        ),
      ],
    );

    var broker = Broker(
      accountType: 'T+7',
      brokerageFeeType: BrokerageFeeType.Variable,
      fee: fee,
      intraday: 0.001,
      minimum: 10,
      name: 'Mplus Online',
    );
    return broker;
  }

  Broker _publicBankCashUpfront() {
    var fee = ConstantBrokerageFee(
      fee: Fee(
        amount: 0.0042,
        isPercentage: true,
      ),
    );

    var broker = Broker(
      accountType: 'Cash Upfront',
      brokerageFeeType: BrokerageFeeType.Constant,
      fee: fee,
      intraday: 0,
      minimum: 12,
      name: 'Public Bank',
    );

    return broker;
  }

  Broker _rhbInvest() {
    var fee = ConstantBrokerageFee(
      fee: Fee(
        amount: 0.0042,
        isPercentage: true,
      ),
    );

    var broker = Broker(
      accountType: 'Cash Upfront',
      brokerageFeeType: BrokerageFeeType.Constant,
      fee: fee,
      intraday: 0,
      minimum: 12,
      name: 'RHB Invest',
    );

    return broker;
  }

  Broker _rhbTradeSmart() {
    var fee = VariableBrokerageFee(
      fees: [
        VariableFee(
          minValue: 0,
          minSign: SignType.GreaterOrEqual,
          maxValue: 100000,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.0042, isPercentage: true),
        ),
        VariableFee(
          minValue: 100000,
          minSign: SignType.Greater,
          maxValue: double.infinity,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.0021, isPercentage: true),
        ),
      ],
    );

    var broker = Broker(
      accountType: 'Cash Upfront',
      brokerageFeeType: BrokerageFeeType.Variable,
      fee: fee,
      intraday: 0.0015,
      minimum: 28,
      name: 'RHB TradeSmart',
    );
    return broker;
  }

  Broker _rakutenTrade() {
    var fee = VariableBrokerageFee(
      fees: [
        VariableFee(
          minValue: 0,
          minSign: SignType.GreaterOrEqual,
          maxValue: 1000,
          maxSign: SignType.Smaller,
          fee: new Fee(amount: 7, isPercentage: false),
        ),
        VariableFee(
          minValue: 1000,
          minSign: SignType.GreaterOrEqual,
          maxValue: 10000,
          maxSign: SignType.Smaller,
          fee: new Fee(amount: 9, isPercentage: false),
        ),
        VariableFee(
          minValue: 10000,
          minSign: SignType.GreaterOrEqual,
          maxValue: 100000,
          maxSign: SignType.Smaller,
          fee: new Fee(amount: 0.001, isPercentage: true),
        ),
        VariableFee(
          minValue: 100000,
          minSign: SignType.GreaterOrEqual,
          maxValue: double.infinity,
          maxSign: SignType.SmallerOrEqual,
          fee: new Fee(amount: 100, isPercentage: false),
        ),
      ],
    );

    var broker = Broker(
      accountType: 'Cash Upfront/Contra/RakuMargin',
      brokerageFeeType: BrokerageFeeType.Variable,
      fee: fee,
      intraday: 0,
      minimum: 7,
      name: 'Rakuten Trade',
    );
    return broker;
  }

  Broker _sjSecuritiesCashUpfront() {
    var fee = VariableBrokerageFee(
      fees: [
        VariableFee(
          minValue: 0,
          minSign: SignType.GreaterOrEqual,
          maxValue: 100000,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.0042, isPercentage: true),
        ),
        VariableFee(
          minValue: 100000,
          minSign: SignType.Greater,
          maxValue: double.infinity,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.0035, isPercentage: true),
        ),
      ],
    );

    var broker = Broker(
      accountType: 'Cash Upfront',
      brokerageFeeType: BrokerageFeeType.Variable,
      fee: fee,
      intraday: 0.0015,
      minimum: 12,
      name: 'SJ Securities',
    );
    return broker;
  }

  Broker _uobKayHianCashUpfront() {
    var fee = ConstantBrokerageFee(
      fee: Fee(
        amount: 0.001,
        isPercentage: true,
      ),
    );

    var broker = Broker(
      accountType: 'Cash Upfront',
      brokerageFeeType: BrokerageFeeType.Constant,
      fee: fee,
      intraday: 0,
      minimum: 8,
      name: 'UOB KayHian',
    );

    return broker;
  }

  Broker _uobKayHianCollaterised() {
    var fee = VariableBrokerageFee(
      fees: [
        VariableFee(
          minValue: 0,
          minSign: SignType.GreaterOrEqual,
          maxValue: 100000,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.003, isPercentage: true),
        ),
        VariableFee(
          minValue: 100000,
          minSign: SignType.Greater,
          maxValue: double.infinity,
          maxSign: SignType.SmallerOrEqual,
          fee: Fee(amount: 0.002, isPercentage: true),
        ),
      ],
    );

    var broker = Broker(
      accountType: 'Collaterised',
      brokerageFeeType: BrokerageFeeType.Variable,
      fee: fee,
      intraday: 0.001,
      minimum: 8,
      name: 'UOB KayHian',
    );
    return broker;
  }
}
