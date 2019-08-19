import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:http/http.dart';
import 'package:ntu_foodhunter/models/dining-area-detail-model.dart';
import 'package:ntu_foodhunter/models/menu-model.dart';
import 'package:ntu_foodhunter/models/review-model.dart';
import 'package:ntu_foodhunter/pages/search-result-page.dart';
import 'package:ntu_foodhunter/util/constants.dart';
import 'package:ntu_foodhunter/pages/comment-form.dart';
import 'package:ntu_foodhunter/widgets/review-stars.dart';

class DiningAreaDetailPage extends StatefulWidget {
  int id = 1;
  DiningAreaDetailPage({int id}) {
    this.id = id;
  }

  @override
  _DiningAreaDetailPageState createState() =>
      _DiningAreaDetailPageState(id: id);
}

class _DiningAreaDetailPageState extends State<DiningAreaDetailPage>
    with TickerProviderStateMixin {
  int id;
  _DiningAreaDetailPageState({int id}) {
    this.id = id;
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<DiningAreaDetailModel>(
      future: getDiningArea(this.id),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: BackButton(color: Colors.black),
              backgroundColor: Colors.white,
              title: Text(
                snapshot.data.name,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            body: _buildDiningAreaDetailsPage(context, snapshot.data),
            bottomNavigationBar: _buildBottomLeaveCommentBar(
                snapshot.data.id, snapshot.data.menu),
          );
        } else {
          return new CircularProgressIndicator();
        }
      },
    );
  }

  Future<DiningAreaDetailModel> getDiningArea(int id) async {
    try {
      final response = await get(Constants.API_RESOURCE_URL +
          '/webapp/api/diningarea/' +
          id.toString());

      dynamic responseJson = json.decode(response.body.toString());

      DiningAreaDetailModel diningArea =
          DiningAreaDetailModel.fromJson(responseJson);

      return diningArea;
    } catch (e) {}
    return null;
  }

  _buildDiningAreaDetailsPage(
      BuildContext context, DiningAreaDetailModel model) {
    Size screenSize = MediaQuery.of(context).size;

    return ListView(
      children: <Widget>[
        Container(
          child: Card(
            elevation: 4.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildDiningAreaImagesWidgets(model.images),
                _buildNameWidget(model.name),
                SizedBox(height: 12.0),
                _buildBasicInfoWidgets(model.addr, 'address'),
                SizedBox(height: 12.0),
                _buildBasicInfoWidgets(model.subLoc, 'subLoc'),
                SizedBox(height: 12.0),
                _buildBasicInfoWidgets(model.phoneNo, 'phoneNo'),
                SizedBox(height: 12.0),
                _buildBasicInfoWidgets(model.operatingHour, 'operatingHour'),
                SizedBox(height: 12.0),
                _buildBasicInfoWidgets(model.capacity.toString(), 'capacity'),
                SizedBox(height: 12.0),
                _buildDivider(screenSize),
                SizedBox(height: 12.0),
                _buildTags(model.tag),
                SizedBox(height: 12.0),
                _buildDivider(screenSize),
                SizedBox(height: 12.0),
                _buildRatingsAndMenuWidgets(model),
                SizedBox(height: 12.0),
                _buildDivider(screenSize),
                SizedBox(height: 12.0),
                _buildReviews(model.review),
                SizedBox(height: 12.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildDivider(Size screenSize) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey[600],
          width: screenSize.width,
          height: 0.25,
        ),
      ],
    );
  }

  _buildDiningAreaImagesWidgets(List<String> images) {
    List<Widget> imageWidgets = [];
    imageWidgets.addAll(images.map(
        (image) => Image.network(Constants.IMAGE_ASSET_RESOURCE_URL + image)));

    TabController imagesController =
        TabController(length: imageWidgets.length, vsync: this);

    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
      child: Container(
        height: 250.0,
        child: Center(
          child: DefaultTabController(
            length: imageWidgets.length,
            child: Stack(
              children: <Widget>[
                TabBarView(
                  controller: imagesController,
                  children: imageWidgets,
                ),
                Container(
                  alignment: FractionalOffset(0.5, 0.95),
                  child: TabPageSelector(
                    controller: imagesController,
                    selectedColor: Colors.grey,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildNameWidget(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Center(
        child: Text(
          name,
          style: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      ),
    );
  }

  _buildBasicInfoWidgets(String text, String type) {
    var iconType = {
      'address': new Icon(
        Icons.room,
        color: Colors.red[600],
      ),
      'subLoc': new Icon(
        Icons.pin_drop,
        color: Color(0xff283593),
      ),
      'phoneNo': new Icon(
        Icons.phone,
        color: Colors.green[600],
      ),
      'operatingHour': new Icon(
        Icons.timer,
        color: Colors.grey[600],
      ),
      'capacity': new Icon(
        Icons.local_dining,
        color: Colors.grey[600],
      ),
    };

    Icon icon = iconType[type];
    if (type == 'capacity') text += ' Seats';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          icon,
          SizedBox(
            width: 8.0,
          ),
          new Container(
            padding: const EdgeInsets.all(4.0),
            width: MediaQuery.of(context).size.width * 0.8,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  text,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildTags(List<String> tags) {
    List<Tag> tagElements = [];

    tags.forEach((t) => tagElements.add(Tag(title: t, active: true)));

    SelectableTags tagWidget = SelectableTags(
      margin: new EdgeInsets.fromLTRB(12, 0, 0, 0),
      alignment: MainAxisAlignment.start,
      tags: tagElements,
      columns: 3,
      onPressed: (tag) {
        tag.active = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => new SearchResult(keyword: tag.title),
          ),
        );
      },
    );

    return Row(
      children: <Widget>[
        Expanded(
          child: tagWidget,
        ),
      ],
    );
  }

  _buildRatingsAndMenuWidgets(DiningAreaDetailModel model) {
    TabController tabController = new TabController(length: 2, vsync: this);
    double totalPoint = model.excellentReview +
        model.aboveReview +
        model.avgReview +
        model.belowReview +
        model.poorReview;

    return Column(children: <Widget>[
      TabBar(
        controller: tabController,
        tabs: <Widget>[
          Tab(
            icon: Icon(Icons.rate_review, color: Colors.black),
            child: Text(
              "RATINGS",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Tab(
            icon: Icon(Icons.menu, color: Colors.black),
            child: Text(
              "MENU",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        height: 200,
        child: TabBarView(
          controller: tabController,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildRating('excellent', totalPoint, model.excellentReview),
                  SizedBox(height: 10),
                  _buildRating('above', totalPoint, model.aboveReview),
                  SizedBox(height: 10),
                  _buildRating('avg', totalPoint, model.avgReview),
                  SizedBox(height: 10),
                  _buildRating('below', totalPoint, model.belowReview),
                  SizedBox(height: 10),
                  _buildRating('poor', totalPoint, model.poorReview),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 200.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _buildMenu(model.menu),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  _buildRating(String ratingType, double totalPoint, double point) {
    String figureKey = ratingType + 'Review';
    String percentKey = ratingType + 'ReviewPercent';

    var iconMap = {
      'poor': Icons.sentiment_very_dissatisfied,
      'below': Icons.sentiment_dissatisfied,
      'avg': Icons.sentiment_neutral,
      'above': Icons.sentiment_satisfied,
      'excellent': Icons.sentiment_very_satisfied
    };

    var ratingText = {
      'poor': 'Poor',
      'below': 'Below Average',
      'avg': 'Average',
      'above': 'Above Average',
      'excellent': 'Excellent',
    };

    Icon icon = new Icon(
      iconMap[ratingType],
      color: Colors.grey[850],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        icon,
        SizedBox(
          width: 10,
        ),
        Container(
          width: 100,
          child: Text(ratingText[ratingType]),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              LinearProgressIndicator(
                value: point.toDouble() / 10,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xff283593),
                ),
                backgroundColor: Colors.grey[200],
              ),
              Text(
                point.toString(),
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          (point / totalPoint * 100).toString() + '%',
        )
      ],
    );
  }

  _buildMenu(List<MenuModel> menuModel) {
    List<Widget> menu = new List<Widget>();
    menuModel.forEach((m) => menu.add(Container(
          child: Container(
            width: 200.0,
            child: Card(
              elevation: 4.0,
              borderOnForeground: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Image.network(
                        'https://d1fd34dzzl09j.cloudfront.net/Images/CFACOM/Stories%20Images/2017/08/Vegetarian/HeaderGardenSaladTrayD.jpg?h=960&w=1440&la=en',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      m.name,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      m.price.toString(),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )));
    return menu;
  }

  _buildReviews(List<ReviewModel> reviewListModel) {
    List<Widget> reviewWidgets = [
      Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Icon(
              Icons.comment,
            ),
            SizedBox(width: 5),
            Text(
              'Comments',
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
      SizedBox(height: 20),
    ];

    reviewListModel.forEach((r) => reviewWidgets.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        r.reviewer,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(r.date),
                    ],
                  ),
                  ReviewStarsWidget(
                      score: r.starScore, remainderScore: r.remainderScore),
                ],
              ),
              SizedBox(height: 10),
              Text(r.comment),
              Divider(),
            ],
          ),
        )));

    return Column(
      children: reviewWidgets,
    );
  }

  _buildBottomLeaveCommentBar(int diningAreaId, List<MenuModel> menuListModel) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        new CommentFormWidget(diningAreaId, menuListModel),
                  ),
                );
              },
              color: Color(0xff283593),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add_comment,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "Leave Your Comment",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
