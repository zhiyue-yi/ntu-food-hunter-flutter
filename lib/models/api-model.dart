import 'package:ureca_restaurant_reviews_flutter/models/dining-area-partial-model.dart';

class MenuApiModel {
  List<DiningAreaPartialModel> restaurant;
  List<DiningAreaPartialModel> food_court;
  List<DiningAreaPartialModel> nearby_places;

  MenuApiModel(this.restaurant, this.nearby_places, this.food_court);

  MenuApiModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> restaurantList = json['restaurant'];
    List<dynamic> foodCourtList = json['food_court'];
    //List<dynamic> nearByPlacesList = json['nearby_places'];

    restaurant =
        restaurantList.map((v) => DiningAreaPartialModel.fromJson(v)).toList();
    food_court =
        foodCourtList.map((v) => DiningAreaPartialModel.fromJson(v)).toList();
    //nearby_places = nearByPlacesList.map((v) => DiningAreaPartialModel.fromJson(v)).toList();
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
