class CommentModel {
  int id; // Dining area ID
  String name; // User's name
  int score; // User score on the dining area
  String feedback;
  List<int> like; // List of Ids of liked dishes
  List<int> dislike; // List of Ids of disliked dishes

  CommentModel(
      {this.id, this.name, this.score, this.feedback, this.like, this.dislike});

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id.toString();
    map["name"] = name;
    map["score"] = score.toString();
    map["feedback"] = feedback;
    map["like"] = like.map((item) => item.toString()).toList();
    map["dislike"] = dislike.map((item) => item.toString()).toList();
    return map;
  }
}
