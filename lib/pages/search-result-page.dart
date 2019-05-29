import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ureca_restaurant_reviews_flutter/models/api-model.dart';
import 'package:ureca_restaurant_reviews_flutter/models/dining-area-partial-model.dart';
import 'package:ureca_restaurant_reviews_flutter/util/constants.dart';
import 'package:ureca_restaurant_reviews_flutter/widgets/dining-area-item.dart';

class SearchResult extends StatefulWidget {
  String keyword;
  SearchResult({String keyword}) {
    this.keyword = keyword;
  }

  _SearchResultState createState() => _SearchResultState(keyword: keyword);
}

class _SearchResultState extends State<SearchResult> {
  String keyword;

  _SearchResultState({String keyword}) {
    this.keyword = keyword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
        title: Text(
          "Search " + this.keyword,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: new FutureBuilder<List<DiningAreaPartialModel>>(
        future: searchDiningAreas(this.keyword),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DiningAreaItemWidget(
                        diningAreaItem: snapshot.data[index]);
                  });
            } else {
              return new CircularProgressIndicator();
            }
          }
          return ErrorWidget(context);
        },
      ),
    );
  }

  Future<List<DiningAreaPartialModel>> searchDiningAreas(String keyword) async {
    print(Constants.API_RESOURCE_URL + '/webapp/api/query/' + keyword);

    final response =
        await get(Constants.API_RESOURCE_URL + '/webapp/api/query/' + keyword);
    dynamic responseJson = json.decode(response.body.toString());

    SearchApiModel result = SearchApiModel.fromJson(responseJson);

    List<DiningAreaPartialModel> list = new List<DiningAreaPartialModel>();
    list.addAll(result.diningAreas);

    return list;
  }
}
