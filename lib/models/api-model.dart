import 'package:ureca_restaurant_reviews_flutter/models/dining-area-partial-model.dart';

import 'dining-area-map-model.dart';

class MenuApiModel {
  List<DiningAreaPartialModel> restaurant;
  List<DiningAreaPartialModel> food_court;
  List<DiningAreaMapModel> nearby_places;

  MenuApiModel(this.restaurant, this.nearby_places, this.food_court);

  MenuApiModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> restaurantList = json['restaurant'];
    List<dynamic> foodCourtList = json['food_court'];
    Map<String, dynamic> nearByPlaces = json['nearby_places'];

    restaurant =
        restaurantList.map((v) => DiningAreaPartialModel.fromJson(v)).toList();
    food_court =
        foodCourtList.map((v) => DiningAreaPartialModel.fromJson(v)).toList();

    nearby_places = new List<DiningAreaMapModel>();
    nearByPlaces
        .forEach((k, v) => nearby_places.add(DiningAreaMapModel.fromJson(v)));
  }
}

class SearchApiModel {
  List<DiningAreaPartialModel> diningAreas;

  SearchApiModel.fromJson(dynamic json) {
    List<dynamic> diningAreaList = json;

    diningAreas =
        diningAreaList.map((v) => DiningAreaPartialModel.fromJson(v)).toList();
  }
}
