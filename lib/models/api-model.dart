import 'package:ureca_restaurant_reviews_flutter/models/dining-area-partial-model.dart';

import 'dining-area-map-model.dart';

class MenuApiModel {
  List<DiningAreaPartialModel> restaurant;
  List<DiningAreaPartialModel> foodCourt;
  List<DiningAreaMapModel> nearbyPlaces;

  MenuApiModel(this.restaurant, this.nearbyPlaces, this.foodCourt);

  MenuApiModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> restaurantList = json['restaurant'];
    List<dynamic> foodCourtList = json['food_court'];
    Map<String, dynamic> nearByPlaces = json['nearby_places'];

    restaurant =
        restaurantList.map((v) => DiningAreaPartialModel.fromJson(v)).toList();
    foodCourt =
        foodCourtList.map((v) => DiningAreaPartialModel.fromJson(v)).toList();

    nearbyPlaces = new List<DiningAreaMapModel>();
    nearByPlaces
        .forEach((k, v) => nearbyPlaces.add(DiningAreaMapModel.fromJson(v)));
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
