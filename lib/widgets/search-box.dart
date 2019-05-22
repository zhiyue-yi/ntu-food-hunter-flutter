import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Card(
      elevation: 4.0,
      child: Container(
          height: 160,
          padding: const EdgeInsets.all(30.0),
          color: Colors.blue[900],
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
                height: 20.0,
              ),
              Container(
                color: Colors.grey[200],
                alignment: Alignment.center,
                child: TextField(
                  decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(13.0, 7.0, 13.0, 7.0),
                      hintText: 'Please enter a search term'),
                ),
              ),
            ],
          )),
    );
  }
}
