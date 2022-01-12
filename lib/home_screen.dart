import 'package:admob_flutter/admob_flutter.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import 'helpers/admob_helper.dart';
import 'helpers/controller_helper.dart';
import 'pages/about_page.dart';
import 'pages/calculate_price_page.dart';
import 'pages/calculate_profit_page.dart';
import 'pages/compare_broker_page.dart';
import 'pages/favourite_page.dart';
import 'pages/view_broker_page.dart';
import 'resources/strings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  static List<Widget> _pageWidgets = <Widget>[
    FavouritePage(),
    CalculateProfitPage(),
    CalculatePricePage(),
    ViewBrokerPage(),
    CompareBrokerPage(),
    AboutPage(),
  ];

  bool _isAdDisplayed;
  AdmobBannerSize _bannerSize;
  AdmobHelper _admobHelper;
  AdmobBanner _admobBanner;
  bool _adFree;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: _pageWidgets.length);
    ControllerHelper().setController(_tabController);

    // _adFree = UserPreferences().getIsAdFree();
    _adFree = true;

    _isAdDisplayed = true;

    _admobHelper = AdmobHelper();

    _bannerSize = AdmobBannerSize.BANNER;

    _admobBanner = _adFree
        ? null
        : AdmobBanner(
            adUnitId: _admobHelper.getBannerAdId(),
            adSize: _bannerSize,
            listener: (AdmobAdEvent event, Map<String, dynamic> args) async {
              if (event == AdmobAdEvent.failedToLoad) {
                setState(() {
                  _isAdDisplayed = false;
                });
              }
            },
          );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
          child: Text(
            Strings.appTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(CommunityMaterialIcons.star),
              text: Strings.favouriteTabItemName,
            ),
            Tab(
              icon: Icon(CommunityMaterialIcons.trending_up),
              text: Strings.calculateStockProfitTabItemName,
            ),
            Tab(
              icon: Icon(CommunityMaterialIcons.calculator_variant),
              text: Strings.calculateStockPriceTabItemName,
            ),
            Tab(
              icon: Icon(Icons.people),
              text: Strings.viewBrokerTabItemName,
            ),
            Tab(
              icon: Icon(CommunityMaterialIcons.nature_people),
              text: Strings.compareBrokerTabItemName,
            ),
            Tab(
              icon: Icon(CommunityMaterialIcons.information),
              text: Strings.aboutPageTabItemName,
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: _pageWidgets,
            ),
          ),
          Visibility(
            visible: _isAdDisplayed,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[_admobBanner == null ? Container() : _admobBanner],
              ),
            ),
          ),
        ],
        // child:
      ),
    );
  }
}
