import 'package:flutter/material.dart';
import '../utils/colors.dart';

Widget AppScaffold({required Widget body,AppBar? appBar,Widget? bottomNavigationBar,FloatingActionButton? floatingActionButton}) {
  return Scaffold(
    floatingActionButton: floatingActionButton,
    appBar: appBar,
    bottomNavigationBar: bottomNavigationBar,
    body: body,
    backgroundColor: kBackgroundColor,
  );
}
