import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:stockcalculator/entities/price_result.dart';
import 'package:stockcalculator/helpers/convert.dart';
import 'package:stockcalculator/pages/compare_broker_result_page.dart';

import '../entities/broker.dart';
import '../helpers/broker_helper.dart';
import '../helpers/calculate_helper.dart';
import '../helpers/user_preferences.dart';
import '../resources/material_colors.dart';
import '../resources/strings.dart';

class CompareBrokerPage extends StatefulWidget {
  @override
  _CompareBrokerPageState createState() => _CompareBrokerPageState();
}

class _CompareBrokerPageState extends State<CompareBrokerPage> {
  SizedBox _horizontalSizedBoxSpace = const SizedBox(height: 20);

  TextEditingController _purchasePriceController;
  bool _purchasePriceClearButtonVisible;

  TextEditingController _shareQuantityController;
  bool _shareQuantityClearButtonVisible;

  OutlineInputBorder _enabledInputBorder;
  OutlineInputBorder _focusedInputBorder;
  OutlineInputBorder _errorInputBorder;

  BrokerHelper _brokerHelper;

  CalculateHelper _calculateHelper;

  TextStyle _dropDownListTextStyle;

  bool _isIncludeOtherFees;

  GlobalKey<FormState> _formKey;
  bool _autoValidate;
  RegExp _floatValidator;
  RegExp _integerValidator;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
    _autoValidate = false;
    _floatValidator = new RegExp(r'^([0-9]+([.][0-9]*)?|[.][0-9]+)$');
    _integerValidator = new RegExp(r'(^[1-9]\d*$)');

    _purchasePriceController = TextEditingController();
    _purchasePriceClearButtonVisible = _purchasePriceController.text.isNotEmpty;
    _purchasePriceController.addListener(() {
      if (_purchasePriceClearButtonVisible !=
          _purchasePriceController.text.isNotEmpty) {
        setState(() {
          _purchasePriceClearButtonVisible =
              _purchasePriceController.text.isNotEmpty;
        });
      }
    });

    _shareQuantityController = TextEditingController();
    _shareQuantityClearButtonVisible = _shareQuantityController.text.isNotEmpty;
    _shareQuantityController.addListener(() {
      if (_shareQuantityClearButtonVisible !=
          _shareQuantityController.text.isNotEmpty) {
        setState(() {
          _shareQuantityClearButtonVisible =
              _shareQuantityController.text.isNotEmpty;
        });
      }
    });

    _enabledInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    );

    _focusedInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: MaterialColors.primaryColor,
        width: 2,
      ),
    );

    _errorInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
      ),
    );

    _brokerHelper = BrokerHelper();

    _calculateHelper = new CalculateHelper();

    _isIncludeOtherFees = UserPreferences().getCompareBrokerIncludeFees();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _purchasePriceController,
                  decoration: InputDecoration(
                    focusedBorder: _focusedInputBorder,
                    enabledBorder: _enabledInputBorder,
                    errorBorder: _errorInputBorder,
                    focusedErrorBorder: _errorInputBorder,
                    errorStyle: TextStyle(height: 0),
                    labelText: Strings.purchasePriceLabel,
                    prefixText: Strings.currencyPrefix,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (!_floatValidator.hasMatch(value))
                      return '';
                    else
                      return null;
                  },
                ),
                _horizontalSizedBoxSpace,
                TextFormField(
                  controller: _shareQuantityController,
                  decoration: InputDecoration(
                    focusedBorder: _focusedInputBorder,
                    enabledBorder: _enabledInputBorder,
                    errorBorder: _errorInputBorder,
                    focusedErrorBorder: _errorInputBorder,
                    errorStyle: TextStyle(height: 0),
                    labelText: Strings.shareQuantityLabel,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (!_integerValidator.hasMatch(value))
                      return '';
                    else
                      return null;
                  },
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        Strings.includeOtherFees,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Switch(
                      value: _isIncludeOtherFees,
                      onChanged: (value) => {
                        setState(() {
                          _isIncludeOtherFees = value;
                        }),
                        UserPreferences()
                            .setCompareBrokerIncludeFees(_isIncludeOtherFees)
                      },
                      activeColor: MaterialColors.primaryColorLight,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          right: 30,
          child: Column(
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              FloatingActionButton(
                heroTag: 'calculateBtn',
                backgroundColor: Colors.deepOrange[600],
                child: Icon(CommunityMaterialIcons.calculator),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    List<Broker> brokers = _brokerHelper.getAllAccounts();
                    Map<Broker, PriceResult> compareResult =
                        CalculateHelper.compareBrokers(
                            brokers,
                            Convert.ToDouble(_purchasePriceController.text),
                            Convert.ToInt(_shareQuantityController.text));

                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => CompareBrokerResultPage(
                          compareBrokerResult: compareResult,
                          isIncludeFees: _isIncludeOtherFees,
                        ),
                      ),
                    );
                  } else {
                    setState(() {
                      _autoValidate = true;
                    });
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
