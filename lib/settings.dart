import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SettingsRoute extends StatefulWidget {

  SettingsRoute();

  @override
  SettingsRouteState createState() =>
      new SettingsRouteState();
}

class SettingsRouteState extends State<SettingsRoute> {
  var profile;

  SettingsRouteState();

  Future<String> getData() async {
    String jsonData =
    await DefaultAssetBundle.of(context).loadString("assets/data.json");
    final jsonResult = json.decode(jsonData);
    profile = jsonResult["000001"]["Profile"];
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "Settings",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 35),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.greenAccent,
        elevation: 0.0,
      ),
      body: new Container()
    );
  }
}