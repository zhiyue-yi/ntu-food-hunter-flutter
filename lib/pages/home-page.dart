import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ureca_restaurant_reviews_flutter/models/api-model.dart';
import 'package:ureca_restaurant_reviews_flutter/models/dining-area-partial-model.dart';
import 'package:ureca_restaurant_reviews_flutter/pages/search-result-page.dart';
import 'package:ureca_restaurant_reviews_flutter/util/constants.dart';
import 'package:ureca_restaurant_reviews_flutter/widgets/dining-area-item.dart';
import 'package:ureca_restaurant_reviews_flutter/widgets/search-box.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "NTU Food Hunter",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: _buildCustomScroller(),
    );
  }

  FutureBuilder<List<DiningAreaPartialModel>> _buildCustomScroller() {
    return new FutureBuilder<List<DiningAreaPartialModel>>(
      future: getDiningAreas(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            return _buildPage(context, snapshot);
          } else {
            return new CircularProgressIndicator();
          }
        }
        return ErrorWidget(context);
      },
    );
  }

  _buildPage(BuildContext context,
      AsyncSnapshot<List<DiningAreaPartialModel>> snapshot) {
    List<Widget> widgets = new List<Widget>();

    widgets.add(SearchBoxWidget());

    widgets.add(_buildCategoryBlock(context));

    widgets.add(Divider());

    widgets.add(_buildSubtitle());

    snapshot.data.forEach((diningArea) =>
        widgets.add(DiningAreaItemWidget(diningAreaItem: diningArea)));

    return ListView(
      children: <Widget>[
        Container(
          child: Column(
            children: widgets,
          ),
        ),
      ],
    );
  }

  _buildCategoryBlock(BuildContext context) {
    TextStyle categoryTextStyle = TextStyle(
      color: Colors.white,
      shadows: [
        Shadow(
          blurRadius: 4.0,
          color: Colors.black,
        ),
      ],
      fontSize: 20,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      child: Row(
        children: <Widget>[
          Container(
            child: Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          new SearchResult(keyword: 'Restaurant'),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image.network(
                        'https://images.pexels.com/photos/6267/menu-restaurant-vintage-table.jpg?cs=srgb&dl=chairs-menu-restaurant-6267.jpg&fm=jpg'),
                    Text(
                      'Restaurant',
                      style: categoryTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 4),
          Container(
            child: Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          new SearchResult(keyword: 'Food Court'),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image.network(
                        'https://images.pexels.com/photos/2325137/pexels-photo-2325137.jpeg?cs=srgb&dl=adult-buildings-city-2325137.jpg&fm=jpg'),
                    Text(
                      'Food Court',
                      style: categoryTextStyle,
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

  _buildSubtitle() {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'Restaurants in NTU',
            style: TextStyle(color: Colors.black, fontSize: 24, shadows: [
              Shadow(
                blurRadius: 4.0,
                offset: Offset.fromDirection(2),
                color: Colors.grey,
              ),
            ]),
          ),
          Text(
            'Browse through a comprehensive list of available restaurants',
            style: TextStyle(color: Colors.grey[800], fontSize: 12),
          )
        ],
      ),
    );
  }

  Future<List<DiningAreaPartialModel>> getDiningAreas() async {
    final response =
        await get(Constants.API_RESOURCE_URL + '/webapp/api/toprated');
    dynamic responseJson = json.decode(response.body.toString());
    MenuApiModel topRated = MenuApiModel.fromJson(responseJson);

    List<DiningAreaPartialModel> list = new List<DiningAreaPartialModel>();
    list.addAll(topRated.restaurant);
    list.addAll(topRated.food_court);

    return list;
  }
}
