class DiningAreaPartialModel {
  int id;
  String name;
  String imgUrl;
  String subLoc;
  List<int> score;
  List<int> remainderScore;

  DiningAreaPartialModel(this.id, this.name, this.imgUrl, this.subLoc,
      this.score, this.remainderScore);

  DiningAreaPartialModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> scoreList = json['score'];
    List<dynamic> remainderScoreList = json['remainder_score'];

    id = json['id'];
    name = json['name'];
    imgUrl = json['imgurl'];
    subLoc = json['sub_loc'];
    score = scoreList.cast<int>().toList();
    remainderScore = remainderScoreList.cast<int>().toList();
  }
}
