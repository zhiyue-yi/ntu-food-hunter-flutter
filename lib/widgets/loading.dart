import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Loading',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
