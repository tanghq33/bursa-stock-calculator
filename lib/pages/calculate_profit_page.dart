import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../entities/broker.dart';
import '../entities/favourite.dart';
import '../entities/price_result.dart';
import '../entities/profit_result.dart';
import '../enums/favourite_target.dart';
import '../helpers/broker_helper.dart';
import '../helpers/calculate_helper.dart';
import '../helpers/convert.dart';
import '../helpers/favourite_helper.dart';
import '../helpers/snack_bar_helper.dart';
import '../helpers/user_preferences.dart';
import '../resources/material_colors.dart';
import '../resources/strings.dart';
import 'profit_result_page.dart';

class CalculateProfitPage extends StatefulWidget {
  @override
  _CalculateProfitPageState createState() => _CalculateProfitPageState();
}

class _CalculateProfitPageState extends State<CalculateProfitPage> {
  SizedBox _horizontalSizedBoxSpace = const SizedBox(height: 20);
  SizedBox _verticalSizedBoxSpace = const SizedBox(width: 15);
  SizedBox _floatingActionButtonSizedBoxSpace = const SizedBox(height: 10);

  TextEditingController _purchasePriceController;
  bool _purchasePriceClearButtonVisible;

  TextEditingController _shareQuantityController;
  bool _shareQuantityClearButtonVisible;

  TextEditingController _sellingPriceController;
  bool _sellingPriceControllerClearButtonVisible;

  OutlineInputBorder _enabledInputBorder;
  OutlineInputBorder _focusedInputBorder;
  OutlineInputBorder _errorInputBorder;

  BrokerHelper _brokerHelper;
  List<String> _brokerList;
  String _selectedBroker;
  List<Broker> _accountList;
  Broker _selectedAccount;

  TextStyle _dropDownListTextStyle;

  bool _isViewingFavourite;
  Favourite _currentFavourite;

  GlobalKey<FormState> _formKey;
  bool _autoValidate;
  RegExp _floatValidator;
  RegExp _integerValidator;

  bool _isExcludeSST;

  @override
  void dispose() {
    _isViewingFavourite = false;
    _currentFavourite = null;
    _autoValidate = false;
    super.dispose();
  }

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
      if (_purchasePriceClearButtonVisible != _purchasePriceController.text.isNotEmpty) {
        setState(() {
          _purchasePriceClearButtonVisible = _purchasePriceController.text.isNotEmpty;
        });
      }
    });

    _shareQuantityController = TextEditingController();
    _shareQuantityClearButtonVisible = _shareQuantityController.text.isNotEmpty;
    _shareQuantityController.addListener(() {
      if (_shareQuantityClearButtonVisible != _shareQuantityController.text.isNotEmpty) {
        setState(() {
          _shareQuantityClearButtonVisible = _shareQuantityController.text.isNotEmpty;
        });
      }
    });

    _sellingPriceController = TextEditingController();
    _sellingPriceControllerClearButtonVisible = _sellingPriceController.text.isNotEmpty;
    _sellingPriceController.addListener(() {
      if (_sellingPriceControllerClearButtonVisible != _sellingPriceController.text.isNotEmpty) {
        setState(() {
          _sellingPriceControllerClearButtonVisible = _sellingPriceController.text.isNotEmpty;
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
    _brokerList = _brokerHelper.getAllBrokers();
    _accountList = [];

    int favouriteBrokerId = UserPreferences().getFavouriteBrokerAccount();
    if (favouriteBrokerId != -1) {
      Broker tempBroker = _brokerHelper.getAccountById(favouriteBrokerId);
      _selectedBroker = tempBroker.name;
      _accountList = _brokerHelper.getAccounts(_selectedBroker);
      _selectedAccount = tempBroker;
    }

    _dropDownListTextStyle = const TextStyle(fontSize: 14);

    _isViewingFavourite = false;

    if (FavouriteHelper().getTarget() == FavouriteTarget.Profit) {
      Favourite favourite = FavouriteHelper().resetTarget().getFavourite();
      if (favourite != null) {
        _isViewingFavourite = true;
        _currentFavourite = favourite;
        FavouriteHelper().clearFavourite();
        _purchasePriceController.text =
            favourite.purchasePrice == null ? Strings.empty : favourite.purchasePrice.toString();
        _sellingPriceController.text =
            favourite.sellingPrice == null ? Strings.empty : favourite.sellingPrice.toString();
        _shareQuantityController.text =
            favourite.shareQuantity == null ? Strings.empty : favourite.shareQuantity.toString();
      }
    }

    _isExcludeSST = UserPreferences().getExcludeSST();
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
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
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
                    ),
                    _verticalSizedBoxSpace,
                    Expanded(
                      child: TextFormField(
                        controller: _sellingPriceController,
                        decoration: InputDecoration(
                          focusedBorder: _focusedInputBorder,
                          enabledBorder: _enabledInputBorder,
                          errorBorder: _errorInputBorder,
                          focusedErrorBorder: _errorInputBorder,
                          errorStyle: TextStyle(height: 0),
                          labelText: Strings.sellingPriceLabel,
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
                    ),
                  ],
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
                _horizontalSizedBoxSpace,
                Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          focusedBorder: _focusedInputBorder,
                          enabledBorder: _enabledInputBorder,
                          errorBorder: _errorInputBorder,
                          focusedErrorBorder: _errorInputBorder,
                          errorStyle: TextStyle(height: 0),
                          labelText: Strings.brokerLabel,
                        ),
                        value: _selectedBroker,
                        validator: (value) {
                          if (value == null || value.toString() == null)
                            return '';
                          else
                            return null;
                        },
                        onTap: (() {
                          setState(() {
                            _selectedBroker = null;
                            _accountList = [];
                            _selectedAccount = null;
                          });
                        }),
                        onChanged: (String newValue) {
                          setState(() {
                            _selectedBroker = newValue;
                            _accountList = _brokerHelper.getAccounts(_selectedBroker);
                          });
                        },
                        items: _brokerList.map((String brokerName) {
                          return DropdownMenuItem<String>(
                            value: brokerName,
                            child: Text(
                              brokerName,
                              style: _dropDownListTextStyle,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    _verticalSizedBoxSpace,
                    Expanded(
                      child: DropdownButtonFormField<Broker>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          focusedBorder: _focusedInputBorder,
                          enabledBorder: _enabledInputBorder,
                          errorBorder: _errorInputBorder,
                          focusedErrorBorder: _errorInputBorder,
                          errorStyle: TextStyle(height: 0),
                          labelText: Strings.accountLabel,
                        ),
                        value: _selectedAccount,
                        validator: (value) {
                          if (value == null || value.toString() == null)
                            return '';
                          else
                            return null;
                        },
                        onChanged: (Broker broker) {
                          setState(() {
                            _selectedAccount = broker;
                          });
                        },
                        items: _accountList.map((Broker broker) {
                          return DropdownMenuItem<Broker>(
                            value: broker,
                            child: Text(
                              broker.accountType,
                              style: _dropDownListTextStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Switch(
                      value: _isExcludeSST,
                      onChanged: (value) {
                        setState(() {
                          _isExcludeSST = value;
                        });
                        UserPreferences().setExcludeSST(_isExcludeSST);
                      },
                    ),
                    Text('Exclude Service Tax'),
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
                    UserPreferences().setFavouriteBrokerAccount(_brokerHelper.getAccountId(_selectedAccount));

                    PriceResult purchasePrice = CalculateHelper.calculatePrice(
                      Convert.ToDouble(_purchasePriceController.text),
                      Convert.ToInt(_shareQuantityController.text),
                      _selectedAccount,
                      _isExcludeSST,
                    );
                    PriceResult sellingPrice = CalculateHelper.calculatePrice(
                      Convert.ToDouble(_sellingPriceController.text),
                      Convert.ToInt(_shareQuantityController.text),
                      _selectedAccount,
                      _isExcludeSST,
                    );

                    ProfitResult profit = CalculateHelper.calculateProfit(purchasePrice, sellingPrice);

                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => ProfitResultPage(
                          profitResult: profit,
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
              _floatingActionButtonSizedBoxSpace,
              FloatingActionButton(
                heroTag: 'saveButton',
                backgroundColor: Theme.of(context).primaryColorDark,
                child: Icon(_isViewingFavourite
                    ? CommunityMaterialIcons.content_save_edit
                    : CommunityMaterialIcons.content_save),
                onPressed: () {
                  if (_isViewingFavourite) {
                    _updateFavouriteData();
                  } else {
                    _showSaveFavouriteDialog(context);
                  }
                },
              )
            ],
          ),
        )
      ],
    );
  }

  void _updateFavouriteData() {
    int favouriteIndex = (Hive.box('favouriteBox').values.toList()).indexOf(_currentFavourite);
    Favourite newFavourite = Favourite(
      name: _currentFavourite.name,
      purchasePrice: Convert.ToDouble(_purchasePriceController.text),
      sellingPrice: _sellingPriceController.text.isNotEmpty ? Convert.ToDouble(_sellingPriceController.text) : null,
      shareQuantity: Convert.ToInt(_shareQuantityController.text),
    );
    _currentFavourite = newFavourite;
    Hive.box('favouriteBox').putAt(favouriteIndex, newFavourite);
    SnackBarHelper.showSnackBar(context, _currentFavourite.name + " has been updated.");
  }

  _showSaveFavouriteDialog(BuildContext context) {
    TextEditingController controller = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 22, right: 22, top: 10),
            actionsPadding: EdgeInsets.only(right: 15),
            title: Text(
              Strings.saveFavouriteDialogTitle,
              style: const TextStyle(color: Colors.black),
            ),
            content: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                focusedBorder: _focusedInputBorder,
                enabledBorder: _enabledInputBorder,
                labelText: Strings.saveFavouriteDialogPlaceHolder,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                color: Theme.of(context).primaryColorDark,
                onPressed: () async {
                  if (controller.text.isNotEmpty &&
                      _purchasePriceController.text.isNotEmpty &&
                      _shareQuantityController.text.isNotEmpty) {
                    Favourite favourite = new Favourite(
                      name: controller.text,
                      purchasePrice: Convert.ToDouble(_purchasePriceController.text),
                      sellingPrice: _sellingPriceController.text.isNotEmpty
                          ? Convert.ToDouble(_sellingPriceController.text)
                          : null,
                      shareQuantity: Convert.ToInt(_shareQuantityController.text),
                    );

                    Hive.box('favouriteBox').add(favourite);
                    Navigator.pop(context);
                  }
                },
                child: Text(Strings.saveFavouriteDialogButtonText),
              )
            ],
          );
        });
  }
}
