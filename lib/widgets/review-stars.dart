import 'package:flutter/material.dart';

class ReviewStarsWidget extends StatelessWidget {
  final List<int> score;
  final List<int> remainderScore;

  const ReviewStarsWidget({Key key, this.score, this.remainderScore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Icon> stars = new List<Icon>();

    stars.addAll(score.map((s) => new Icon(
          Icons.star,
          color: Color(0xff283593),
        )));

    stars.addAll(remainderScore.map((s) => new Icon(
          Icons.star_border,
          color: Color(0xff283593),
        )));

    return new Row(
      children: stars,
    );
  }
}
