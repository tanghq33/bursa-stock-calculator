import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:admob_flutter/admob_flutter.dart';

import 'entities/favourite.dart';
import 'helpers/admob_helper.dart';
import 'helpers/user_preferences.dart';
import 'home_screen.dart';
import 'resources/material_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Shared Preferences
  await UserPreferences().init();

  // Admob
  // final admobHelper = AdmobHelper();
  // admobHelper.setTestingMode(true);
  // Admob.initialize(testDeviceIds: [admobHelper.getAppId()]);

  // Initialize Hive
  final appDocumetnDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumetnDirectory.path);
  Hive.registerAdapter(FavouriteAdapter());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeData themeData = ThemeData(
    primaryColor: MaterialColors.primaryColor,
    primaryColorLight: MaterialColors.primaryColorLight,
    primaryColorDark: MaterialColors.primaryColorDark,
  );

  @override
  void dispose() {
    Hive.box('favouriteBox').compact();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      title: "Stock Calculator",
      home: FutureBuilder(
        future: Hive.openBox('favouriteBox'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return HomeScreen();
            }
          } else {
            return Scaffold();
          }
        },
      ),
    );
  }
}
