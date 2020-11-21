import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';

import '../resources/material_colors.dart';
import '../resources/strings.dart';

class AboutPage extends StatelessWidget {
  final _verticalSpace = const SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Bursa Stock Calculator",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          Text(
            Strings.versionLabel + Strings.version,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          _verticalSpace,
          Text(
              "Bursa Stock Calculator is FREE and ad-supported. You can use the full features of Bursa Stock Calculator. You may also request feature or report bug by dropping an email to unsignedapps@gmail.com."),
          _verticalSpace,
          _verticalSpace,
          // Center(
          //   child: RaisedButton(
          //     child: SizedBox(
          //       width: 120,
          //       height: 30,
          //       child: Center(
          //         child: Text(Strings.supportAppText,
          //             style: TextStyle(fontWeight: FontWeight.w400)),
          //       ),
          //     ),
          //     color: MaterialColors.primaryColorDark,
          //     textColor: Colors.white,
          //     onPressed: _launchURL,
          //   ),
          // ),
          Center(
            child: RaisedButton(
              child: SizedBox(
                width: 120,
                height: 30,
                child: Center(
                  child: Text(Strings.rateAppText,
                      style: TextStyle(fontWeight: FontWeight.w400)),
                ),
              ),
              color: MaterialColors.primaryColorDark,
              textColor: Colors.white,
              onPressed: () => StoreRedirect.redirect(
                  androidAppId: Strings.rateAppPackageName,
                  iOSAppId: "585027354"),
            ),
          )
        ],
      ),
    );
  }

  // _launchURL() async {
  //   const url = Strings.supportAppUrl;
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   }
  // }
}
