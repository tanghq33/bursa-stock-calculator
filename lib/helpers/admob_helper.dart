class AdmobHelper {
  // AdmobHelper(this.isTest);

  static final AdmobHelper _instance = AdmobHelper._ctor();
  bool _isTest = false;

  factory AdmobHelper() {
    return _instance;
  }

  AdmobHelper._ctor();

  void setTestingMode(bool isTestingMode) {
    _isTest = isTestingMode;
  }

  String getAppId() {
    if (this._isTest == true) {
      return "ca-app-pub-3940256099942544~3347511713";
    } else {
      return "ca-app-pub-2372987964105303~2451080620";
    }
  }

  String getBannerAdId() {
    if (this._isTest == true) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else {
      return "ca-app-pub-2372987964105303/7675788469";
    }
  }

  // String getInterstitialAdId() {
  //   if (this.isTest == true) {
  //     return "ca-app-pub-3940256099942544/1033173712";
  //   } else {
  //     return "ca-app-pub-2372987964105303/4043233049";
  //   }
  // }
}
