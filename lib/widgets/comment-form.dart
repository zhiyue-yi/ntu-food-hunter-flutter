import 'package:flutter/material.dart';
import 'package:ureca_restaurant_reviews_flutter/models/menu-model.dart';

class CommentFormWidget extends StatefulWidget {
  List<MenuModel> menuItems;

  CommentFormWidget({Key key, List<MenuModel> menuItems}) : super(key: key);

  _CommentFormWidgetState createState() => _CommentFormWidgetState(menuItems);
}

class _CommentFormWidgetState extends State<CommentFormWidget> {
  List<MenuModel> menuItems = [];

  final _formKey = GlobalKey<FormState>();

  _CommentFormWidgetState(List<MenuModel> menuItems);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              labelText: 'Name *',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your name';
              }
            },
          ),
          Center(
            child: DropdownButton<String>(
              onChanged: (String newValue) {
                setState(() {});
              },
              items: menuItems
                  .map<DropdownMenuItem<String>>((menuItem) =>
                      DropdownMenuItem<String>(
                          value: menuItem.id.toString(),
                          child: Text(menuItem.name)))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, we want to show a Snackbar
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
