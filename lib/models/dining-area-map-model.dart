class DiningAreaMapModel {
  double latitude;
  double longitude;
  String subarea;

  DiningAreaMapModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> subareaList = json['subarea'];

    latitude = json["latitude"];
    longitude = json["longitude"];
    subarea = subareaList[0];
  }
}
