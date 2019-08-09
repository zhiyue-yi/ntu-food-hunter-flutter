import 'package:flutter/material.dart';
import 'package:ureca_restaurant_reviews_flutter/models/dining-area-partial-model.dart';
import 'package:ureca_restaurant_reviews_flutter/pages/dining-area-detail-page.dart';
import 'package:ureca_restaurant_reviews_flutter/util/constants.dart';
import 'package:ureca_restaurant_reviews_flutter/widgets/review-stars.dart';

class DiningAreaDetailRouteArguments {
  DiningAreaDetailRouteArguments({this.id});
  final int id;
}

class DiningAreaItemWidget extends StatelessWidget {
  final DiningAreaPartialModel diningAreaItem;

  const DiningAreaItemWidget({Key key, this.diningAreaItem}) : super(key: key);

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
                Constants.IMAGE_ASSET_RESOURCE_URL + diningAreaItem.imgUrl,
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
                  ReviewStarsWidget(
                      score: diningAreaItem.score,
                      remainderScore: diningAreaItem.remainderScore),
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
}
