import 'package:flutter/material.dart';

AppBar appBar = AppBar(
  leading: IconButton(
    icon: Icon(
      Icons.arrow_back_ios,
    ),
    onPressed: () => {},
    // onPressed: () => Navigator.of(context).pop(),
    // problem here is I am not able to figure out how to pass the context to this appBar so that we can use the same appbar for the entire app
  ),
  title: Text("ECO"),
  centerTitle: true,
  backgroundColor: const Color(
    0xff2C2E36,
  ),
  elevation: 0,
  actions: [
    IconButton(
      icon: Icon(
        // Icons.account_circle_outlined,
        Icons.account_circle,
      ),
      onPressed: () {},
    ),
  ],
);
