import 'package:ureca_restaurant_reviews_flutter/models/dining-area-map-model.dart';
import 'package:ureca_restaurant_reviews_flutter/models/dining-area-partial-model.dart';

class HomePageModel {
  List<DiningAreaPartialModel> diningAreas;
  List<DiningAreaMapModel> mapData;

  HomePageModel(this.diningAreas, this.mapData);
}
