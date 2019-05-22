class DiningAreaPartialModel {
  int id;
  String name;
  String imgurl;
  String subLoc;
  List<int> score;
  List<int> remainderScore;

  DiningAreaPartialModel(this.id, this.name, this.imgurl, this.subLoc,
      this.score, this.remainderScore);

  DiningAreaPartialModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> scoreList = json['score'];
    List<dynamic> remainderScoreList = json['remainder_score'];

    id = json['id'];
    name = json['name'];
    imgurl = json['imgurl'];
    subLoc = json['sub_loc'];
    score = scoreList.cast<int>().toList();
    remainderScore = remainderScoreList.cast<int>().toList();
  }
}
