import 'package:flutter/material.dart';

class StarRatingWidget extends StatefulWidget {
  final void Function(int) callback;
  final int value;
  final IconData filledStar;
  final IconData unfilledStar;
  const StarRatingWidget({
    Key key,
    this.callback,
    this.value = 0,
    this.filledStar,
    this.unfilledStar,
  })  : assert(value != null),
        super(key: key);

  @override
  _StarRatingWidgetState createState() =>
      _StarRatingWidgetState(value, callback);
}

class _StarRatingWidgetState extends State<StarRatingWidget> {
  int value = 0;
  void Function(int) callback;

  _StarRatingWidgetState(this.value, this.callback);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).accentColor;
    final size = 36.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {
            setState(() {
              value = index + 1;
            });
            callback(value);
          },
          color: index < this.value ? color : null,
          iconSize: size,
          icon: Icon(
            index < this.value
                ? widget.filledStar ?? Icons.star
                : widget.unfilledStar ?? Icons.star_border,
          ),
          padding: EdgeInsets.zero,
          tooltip: "${index + 1} of 5",
        );
      }),
    );
  }
}
