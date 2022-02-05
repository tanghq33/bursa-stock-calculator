import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._ctor();
  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._ctor();

  SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
    // _prefs.clear();
  }

  int getFavouriteBrokerAccount() {
    return _prefs.getInt('favBrokerAccountId') ?? -1;
  }

  void setFavouriteBrokerAccount(int id) {
    _prefs.setInt('favBrokerAccountId', id);
  }

  bool getCompareBrokerIncludeFees() {
    return _prefs.getBool('compareBrokerIncludeFees') ?? false;
  }

  void setCompareBrokerIncludeFees(bool value) {
    _prefs.setBool('compareBrokerIncludeFees', value);
  }

  bool getExcludeSST() {
    return _prefs.getBool('excludeSST') ?? false;
  }

  void setExcludeSST(bool value) {
    _prefs.setBool('excludeSST', value);
  }

  // bool getIsAdFree() {
  //   return _prefs.getBool('adFree') ?? false;
  // }
}
