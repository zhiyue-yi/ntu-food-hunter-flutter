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

  _buildPage(BuildContext context, AsyncSnapshot<HomePageModel> snapshot) {
    List<Widget> widgets = new List<Widget>();

    widgets.add(SearchBoxWidget());

    widgets.add(_buildCategoryBlock(context));

    widgets.add(_buildGoogleMap(context, snapshot.data.mapData));

    widgets.add(Divider());

    widgets.add(_buildSubtitle());

    snapshot.data.diningAreas.forEach((DiningAreaPartialModel diningArea) =>
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

  _buildGoogleMap(BuildContext context, List<DiningAreaMapModel> models) {
    Set<Marker> markers = models
        .map(
          (model) => new Marker(
                markerId: MarkerId(model.subarea),
                position: LatLng(model.latitude, model.longitude),
                infoWindow: InfoWindow(
                  title: model.subarea,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            new SearchResult(keyword: model.subarea),
                      ),
                    );
                  },
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueAzure,
                ),
              ),
        )
        .toSet();

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
        markers: markers,
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
    list.addAll(topRated.food_court);

    HomePageModel model = new HomePageModel(list, topRated.nearby_places);
    return model;
  }
}
