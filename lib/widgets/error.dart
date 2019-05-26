import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'Sorry, your Internet connection seems to have problems. Please try again later',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
