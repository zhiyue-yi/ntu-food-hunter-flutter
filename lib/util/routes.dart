import 'package:flutter/material.dart';
import 'package:ntu_foodhunter/pages/dining-area-detail-page.dart';
import 'package:ntu_foodhunter/util/constants.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
    Constants.ROUTE_DINING_AREA_DETAIL: (BuildContext context) =>
        DiningAreaDetailPage(),
  };
}
