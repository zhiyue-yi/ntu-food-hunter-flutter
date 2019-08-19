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

    starScore = starScoreList.length > 0
        ? starScoreList.cast<int>().toList()
        : new List<int>();

    remainderScore = remainderScoreList.length > 0
        ? remainderScoreList.cast<int>().toList()
        : new List<int>();

    likes = likesList.length > 0
        ? likesList.map((x) => x.toString()).toList()
        : new List<String>();

    dislikes = dislikesList.length > 0
        ? dislikesList.map((x) => x.toString()).toList()
        : new List<String>();
  }
}
