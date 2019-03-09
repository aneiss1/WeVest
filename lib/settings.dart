import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'services/authentication.dart';
import 'services/firestoreBank.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsRoute extends StatefulWidget {

  SettingsRoute();

  @override
  SettingsRouteState createState() =>
      new SettingsRouteState();
}

class SettingsRouteState extends State<SettingsRoute> {
  var profile;
  DocumentSnapshot querySnapshot;
  final CollectionReference basicCollection = Firestore.instance.collection('Basic');

  SettingsRouteState();

  FirebaseFirestoreService db = new FirebaseFirestoreService();

  Future<String> getData() async {

    String jsonData =
    await DefaultAssetBundle.of(context).loadString("assets/data.json");
    final jsonResult = json.decode(jsonData);
    profile = jsonResult["000001"]["Profile"];
    print("hello");
    //var test = db.getBank();
    return "Success!";
  }

  Future<String> getChannelName() async {
    DocumentSnapshot snapshot= await Firestore.instance.collection('Basic').document('-L_Z-WQDH7o8pEw6nW0p').get();
    var channelName = snapshot['id'].toString();
    print(channelName);
    return "success";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
    getChannelName();
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