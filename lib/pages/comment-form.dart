import 'package:flutter/material.dart';
import 'package:ureca_restaurant_reviews_flutter/models/menu-model.dart';
import 'package:ureca_restaurant_reviews_flutter/widgets/star-rating.dart';

class CommentFormWidget extends StatefulWidget {
  final List<MenuModel> menuItems;

  CommentFormWidget({Key key, @required this.menuItems}) : super(key: key);

  _CommentFormWidgetState createState() => _CommentFormWidgetState(menuItems);
}

class _CommentFormWidgetState extends State<CommentFormWidget> {
  List<MenuModel> menuItemList = [];
  List<MenuModel> likedMenuItems = [];
  List<MenuModel> dislikedMenuItems = [];

  final _formKey = GlobalKey<FormState>();

  _CommentFormWidgetState(this.menuItemList);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = _buildForm(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 40.0,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Leave Your Comments',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return children[index];
            }, childCount: children.length),
          )
        ],
      ),
    );
  }

  _buildForm(BuildContext context) {
    EdgeInsets padding = EdgeInsets.symmetric(horizontal: 16, vertical: 0);
    TextStyle subHeader = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

    return <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Row(
          children: <Widget>[
            Icon(Icons.person),
            SizedBox(width: 10),
            Text(
              'Name *',
              style: subHeader,
            ),
          ],
        ),
      ),
      Padding(
        padding: padding,
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your name';
            }
          },
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Icon(Icons.rate_review),
            SizedBox(width: 10),
            Text(
              'Rate your experience',
              style: subHeader,
            ),
          ],
        ),
      ),
      Center(
        child: StarRatingWidget(),
      ),
      Divider(height: 20),
      Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Icon(Icons.feedback),
            SizedBox(width: 10),
            Text(
              'Provide your honest feedback',
              style: subHeader,
            ),
          ],
        ),
      ),
      Padding(
        padding: padding,
        child: TextFormField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your feedback';
            }
          },
        ),
      ),
      Divider(height: 20),
      SizedBox(
        height: 20.0,
      ),
      Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Icon(Icons.sentiment_very_satisfied),
            SizedBox(width: 10),
            Text(
              'Likes',
              style: subHeader,
            ),
          ],
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildMenuItemCheckbox(menuItemList, true),
      ),
      Divider(height: 20),
      Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Icon(Icons.sentiment_very_dissatisfied),
            SizedBox(width: 10),
            Text(
              'Likes',
              style: subHeader,
            ),
          ],
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildMenuItemCheckbox(menuItemList, false),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
        child: RaisedButton(
          color: Colors.blue[600],
          onPressed: () {
            // Validate will return true if the form is valid, or false if
            // the form is invalid.
            if (_formKey.currentState.validate()) {
              // If the form is valid, we want to show a Snackbar
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Processing Data')));
            }
          },
          child: Text(
            'Submit',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ];
  }

  _buildMenuItemCheckbox(List<MenuModel> menuItems, bool isLike) {
    List<Widget> list = [];

    List<MenuModel> selectedMenuItems =
        isLike ? this.likedMenuItems : this.dislikedMenuItems;

    menuItems.forEach((item) {
      bool isSelected = selectedMenuItems
              .where((selectedItem) => item.id == selectedItem.id)
              .length >
          0;
      list.add(
        Center(
          child: CheckboxListTile(
              value: isSelected,
              title: Text(item.name),
              activeColor: isSelected ? Colors.red : Colors.green,
              controlAffinity: ListTileControlAffinity.platform,
              onChanged: (bool) {
                if (mounted) {
                  setState(() {
                    if (isSelected)
                      selectedMenuItems.add(item);
                    else
                      selectedMenuItems.remove(item);
                  });
                }
              }),
        ),
      );
    });

    return list;
  }
}
