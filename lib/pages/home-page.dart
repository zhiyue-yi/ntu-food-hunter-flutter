import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:ureca_restaurant_reviews_flutter/models/api-model.dart';
import 'package:ureca_restaurant_reviews_flutter/models/dining-area-map-model.dart';
import 'package:ureca_restaurant_reviews_flutter/models/dining-area-partial-model.dart';
import 'package:ureca_restaurant_reviews_flutter/models/home-page-model.dart';
import 'package:ureca_restaurant_reviews_flutter/pages/search-result-page.dart';
import 'package:ureca_restaurant_reviews_flutter/util/constants.dart';
import 'package:ureca_restaurant_reviews_flutter/widgets/dining-area-item.dart';
import 'package:ureca_restaurant_reviews_flutter/widgets/search-box.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();

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

  FutureBuilder<HomePageModel> _buildCustomScroller() {
    return new FutureBuilder<HomePageModel>(
      future: getHomePageModel(),
      builder: (context, snapshot) {
        return _buildPage(context, snapshot);
      },
    );
  }

  _buildPage(BuildContext context, AsyncSnapshot<HomePageModel> snapshot) {
    List<Widget> widgets = new List<Widget>();
    widgets.add(SearchBoxWidget());
    widgets.add(_buildCategoryBlock(context));

    if (snapshot.data != null) {
      widgets.add(_buildGoogleMap(context, snapshot.data.mapData));
      widgets.add(Divider());
      widgets.add(_buildSubtitle());

      if (snapshot.data.diningAreas != null)
        snapshot.data.diningAreas.forEach((DiningAreaPartialModel diningArea) =>
            widgets.add(DiningAreaItemWidget(diningAreaItem: diningArea)));
    } else {
      widgets.add(Divider());
      widgets.add(Center(
        child: Text(
          'No result is found',
          style: TextStyle(fontSize: 20),
        ),
      ));
    }

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
                    Image.asset('assets/canteen-pic-1.jpg'),
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
                    Image.asset('assets/canteen-pic-2.jpg'),
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

  _buildGoogleMap(BuildContext context, List<DiningAreaMapModel> models) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(1.348100, 103.683259), zoom: 14),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: models == null
            ? new Set<Marker>()
            : models
                .map(
                  (model) => new Marker(
                    markerId: MarkerId(model.subArea),
                    position: LatLng(model.latitude, model.longitude),
                    infoWindow: InfoWindow(
                      title: model.subArea,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                new SearchResult(keyword: model.subArea),
                          ),
                        );
                      },
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueAzure,
                    ),
                  ),
                )
                .toSet(),
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

  Future<HomePageModel> getHomePageModel() async {
    final response =
        await get(Constants.API_RESOURCE_URL + '/webapp/api/toprated');
    dynamic responseJson = json.decode(response.body.toString());
    MenuApiModel topRated = MenuApiModel.fromJson(responseJson);

    List<DiningAreaPartialModel> list = new List<DiningAreaPartialModel>();
    list.addAll(topRated.restaurant);
    list.addAll(topRated.foodCourt);

    HomePageModel model = new HomePageModel(list, topRated.nearbyPlaces);
    return model;
  }
}
