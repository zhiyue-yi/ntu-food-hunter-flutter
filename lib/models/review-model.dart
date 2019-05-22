class ReviewModel {
  int id;
  String reviewer;
  String date;
  String comment;
  List<dynamic> likes;
  List<dynamic> dislikes;
  List<int> starScore;
  List<int> remainderScore;

  ReviewModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> likesList = json['likes'];
    List<dynamic> dislikesList = json['dislikes'];
    List<dynamic> starScoreList = json['star_score'];
    List<dynamic> remainderScoreList = json['remainder_score'];

    id = json['id'];
    reviewer = json['reviewer'];
    date = json['date'];
    comment = json['comment'];
    starScore = starScoreList.cast<int>().toList();
    remainderScore = remainderScoreList.cast<int>().toList();
    likes = likesList.map((x) => x.toString()).toList();
    dislikes = dislikesList.map((x) => x.toString()).toList();
  }
}
