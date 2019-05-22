import 'package:flutter/material.dart';
import 'package:ureca_restaurant_reviews_flutter/models/dining-area-partial-model.dart';
import 'package:ureca_restaurant_reviews_flutter/pages/dining-area-detail-page.dart';
import 'package:ureca_restaurant_reviews_flutter/util/constants.dart';

class DiningAreaDetailRouteArguments {
  DiningAreaDetailRouteArguments({this.id});
  final int id;
}

class DiningAreaListItem extends StatelessWidget {
  final DiningAreaPartialModel diningAreaItem;

  const DiningAreaListItem({Key key, this.diningAreaItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildProductItemCard(context),
      ],
    );
  }

  _buildProductItemCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    new DiningAreaDetailPage(id: diningAreaItem.id)));
      },
      child: Card(
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Image.network(
                Constants.API_RESOURCE_URL + diningAreaItem.imgurl,
              ),
              width: MediaQuery.of(context).size.width * 0.975,
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    diningAreaItem.name,
                    style: TextStyle(fontSize: 20.0, color: Colors.grey[900]),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    diningAreaItem.subLoc,
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  _buildStar(context, diningAreaItem.score,
                      diningAreaItem.remainderScore),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStar(
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
