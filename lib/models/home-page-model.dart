import 'package:ntu_foodhunter/models/dining-area-map-model.dart';
import 'package:ntu_foodhunter/models/dining-area-partial-model.dart';

class HomePageModel {
  List<DiningAreaPartialModel> diningAreas;
  List<DiningAreaMapModel> mapData;

  HomePageModel(this.diningAreas, this.mapData);
}
