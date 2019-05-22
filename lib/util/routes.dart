import 'package:flutter/material.dart';
import 'package:ureca_restaurant_reviews_flutter/pages/dining-area-detail-page.dart';
import 'package:ureca_restaurant_reviews_flutter/util/constants.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
    Constants.ROUTE_DINING_AREA_DETAIL: (BuildContext context) =>
        DiningAreaDetailPage(),
  };
}
