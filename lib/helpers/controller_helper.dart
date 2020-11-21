import 'package:flutter/material.dart';

class ControllerHelper {
  static final ControllerHelper _instance = ControllerHelper._ctor(); 

  factory ControllerHelper() {
    return _instance;
  }

  ControllerHelper._ctor();

  TabController _tabController;

  void setController(TabController tabController) {
    _tabController = tabController;
  }

  TabController getController(){
    return _tabController;
  }
}