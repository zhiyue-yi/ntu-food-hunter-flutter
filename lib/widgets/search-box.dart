import 'package:flutter/material.dart';
import 'package:ureca_restaurant_reviews_flutter/pages/search-result-page.dart';

class SearchBoxWidget extends StatelessWidget {
  final keywordCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Container(
        height: 172,
        padding: const EdgeInsets.all(30.0),
        color: Color(0xff283593),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text(
              'Waiting in NTU and feeling hungry?',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[200],
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Browse your cravings today!',
              style: TextStyle(fontSize: 14.0, color: Colors.grey[100]),
            ),
            SizedBox(
              height: 19.0,
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.grey[200],
                      child: TextField(
                        controller: keywordCtrl,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[200],
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 13.0, vertical: 7.0),
                            hintText: 'Begin to search'),
                      ),
                    ),
                  ),
                  Container(
                    width: 56.0,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                new SearchResult(keyword: keywordCtrl.text),
                          ),
                        );
                      },
                      color: Colors.orange[600],
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
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
