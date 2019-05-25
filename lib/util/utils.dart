import 'package:flutter/material.dart';

class Utils {
  static Widget buildStar(
      BuildContext context, List<int> score, List<int> remainderScore) {
    List<Icon> stars = new List<Icon>();

    stars.addAll(score.map((s) => new Icon(
          Icons.star,
          color: Theme.of(context).primaryColor,
        )));

    stars.addAll(remainderScore.map((s) => new Icon(
          Icons.star_border,
          color: Theme.of(context).primaryColor,
        )));

    return new Row(
      children: stars,
    );
  }
}
