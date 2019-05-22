class MenuModel {
  int id;
  String name;
  double price;

  MenuModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }
}
