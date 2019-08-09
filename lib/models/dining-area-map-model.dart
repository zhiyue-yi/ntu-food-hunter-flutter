class DiningAreaMapModel {
  double latitude;
  double longitude;
  String subArea;

  DiningAreaMapModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> subareaList = json['subarea'];

    latitude = json["latitude"];
    longitude = json["longitude"];
    subArea = subareaList[0];
  }
}
