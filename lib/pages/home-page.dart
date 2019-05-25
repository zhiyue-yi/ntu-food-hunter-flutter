import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ureca_restaurant_reviews_flutter/models/api-model.dart';
import 'package:ureca_restaurant_reviews_flutter/models/dining-area-partial-model.dart';
import 'package:ureca_restaurant_reviews_flutter/util/constants.dart';
import 'package:ureca_restaurant_reviews_flutter/widgets/dining-area-item.dart';
import 'package:ureca_restaurant_reviews_flutter/widgets/search-box.dart';

class HomePage extends StatelessWidget {
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;

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
            return CustomScrollView(
              slivers: <Widget>[
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width,
                    childAspectRatio: 2.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return SearchBox();
                  }, childCount: 1),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return DiningAreaListItem(
                        diningAreaItem: snapshot.data[index]);
                  }, childCount: snapshot.data.length),
                )
              ],
            );
          } else {
            return new CircularProgressIndicator();
          }
        }
      },
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
