import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ntu_foodhunter/models/comment-model.dart';
import 'package:ntu_foodhunter/models/menu-model.dart';
import 'package:ntu_foodhunter/util/constants.dart';
import 'package:ntu_foodhunter/widgets/star-rating.dart';

class CommentFormWidget extends StatefulWidget {
  final List<MenuModel> menuItems;
  final int diningAreaId;

  CommentFormWidget(this.diningAreaId, this.menuItems, {Key key})
      : super(key: key);

  _CommentFormWidgetState createState() =>
      _CommentFormWidgetState(this.diningAreaId, menuItems);
}

class _CommentFormWidgetState extends State<CommentFormWidget> {
  final int diningAreaId;
  int rating = 0;
  List<MenuModel> menuItemList = [];
  List<MenuModel> likedMenuItems = [];
  List<MenuModel> dislikedMenuItems = [];
  TextEditingController nameController = new TextEditingController();
  TextEditingController feedbackController = new TextEditingController();
  StarRatingWidget starRatingWidget;

  _CommentFormWidgetState(this.diningAreaId, this.menuItemList);

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
    starRatingWidget = new StarRatingWidget(
        callback: (value) => {setState(() => rating = value)});
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
          controller: nameController,
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
        child: starRatingWidget,
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
          controller: feedbackController,
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
              'Dislikes',
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
          color: Color(0xff283593),
          onPressed: () {
            CommentModel comment = new CommentModel(
              id: this.diningAreaId,
              name: nameController.text,
              feedback: feedbackController.text,
              score: rating,
              like: this.likedMenuItems.map((item) => item.id).toList(),
              dislike: this.dislikedMenuItems.map((item) => item.id).toList(),
            );
            post(
              Constants.API_RESOURCE_URL + '/webapp/api/feedback',
              body: jsonEncode(comment.toMap()),
            ).then((response) {
              Navigator.of(context).pop();
            }).catchError((error) {
              print(error);
              // TODO: handle errors
            });
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
                isSelected = !isSelected;
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
