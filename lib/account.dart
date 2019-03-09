import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'main.dart';
import 'services/firestoreBasic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/authentication.dart';

class AccountRoute extends StatefulWidget {
  AccountRoute(this.auth, this.userId, this.onSignedOut);
  final VoidCallback onSignedOut;
  final userId;
  final BaseAuth auth;


  @override
  AccountRouteState createState() => new AccountRouteState(this.auth, this.userId, this.onSignedOut);
}

class AccountRouteState extends State<AccountRoute> {
  var profile;
  var _isLoading = true;
  String userId;
  DocumentSnapshot querySnapshot;
  final CollectionReference basicCollection = Firestore.instance.collection('Basic');
  String first;
  String last;
  String address;
  String phone;
  String alias;
  String email;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  VoidCallback onSignedOut;
  BaseAuth auth;

  AccountRouteState(this.auth, this.userId, this.onSignedOut);

  Future<String> getData() async {
    String jsonData =
        await DefaultAssetBundle.of(context).loadString("assets/data.json");
    final jsonResult = json.decode(jsonData);
    profile = jsonResult["000001"]["Profile"];
    print(profile);
    return "Success!";
  }

  Future<String> getBasic() async {
    DocumentSnapshot snapshot= await Firestore.instance.collection('Basic').document(userId).get();
    first = snapshot['first'];
    last = snapshot['last'];
    address = snapshot['address'];
    phone = snapshot['phone'];
    alias = snapshot['alias'];
    FirebaseUser user = await _firebaseAuth.currentUser();
    email = user.email;
    this.setState(() {
      _isLoading = false;
    });
    return "success";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
    getBasic();
  }
  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/root', (_) => false);
    } catch (e) {
      print(e);
    }
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
        body: new Container(
          child: _isLoading
              ? new CircularProgressIndicator()
              : new Column(
                  children: <Widget>[
                    Expanded(
                        child: ScrollConfiguration(
                            behavior: MyBehavior(),
                            child: ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment:MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Column(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          //mainAxisSize: MainAxisSize.max,
                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8.0, left: 8.0),
                                              child: Text(
                                                "Name",
                                                style: new TextStyle(
                                                  fontSize: 24.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8.0, left: 8.0),
                                              child: Text(
                                                "Alias",
                                                style: new TextStyle(
                                                  fontSize: 24.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8.0, left: 8.0),
                                              child: Text(
                                                "Email",
                                                style: new TextStyle(
                                                  fontSize: 24.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8.0, left: 8.0),
                                              child: Text(
                                                "Phone Name",
                                                style: new TextStyle(
                                                  fontSize: 24.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8.0, left: 8.0),
                                              child: Text(
                                                "Address",
                                                style: new TextStyle(
                                                  fontSize: 24.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ]),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          //mainAxisSize: MainAxisSize.max,
                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 8.0, left: 8.0),
                                                  child: Text(
                                                    first,
                                                    style: new TextStyle(
                                                      fontSize: 24.0,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 8.0, left: 8.0),
                                                  child: Text(
                                                    last,
                                                    style: new TextStyle(
                                                      fontSize: 24.0,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8.0, left: 8.0),
                                              child: Text(
                                                alias,
                                                style: new TextStyle(
                                                  fontSize: 24.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8.0, left: 8.0),
                                              child: Text(
                                                email,
                                                style: new TextStyle(
                                                  fontSize: 24.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8.0, left: 8.0),
                                              child: Text(
                                                phone,
                                                style: new TextStyle(
                                                  fontSize: 24.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 250,
                                              margin: EdgeInsets.only(
                                                  top: 8.0, left: 8.0),
                                              child: Text(
                                                address,
                                                overflow: TextOverflow.clip,
                                                //softWrap: true,
                                                style: new TextStyle(
                                                  fontSize: 24.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ]),
                                    ])
                              ],
                            ))),
                    Container(
                      color: Colors.blueGrey,
                      child: Row(children: <Widget>[
                        Expanded(
                          child: FlatButton(
                              disabledColor: Colors.grey,
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              color: Colors.blueGrey,
                              onPressed: _signOut,/*() {
                                appAuth.logout().then((_) =>
                                    Navigator.of(context)
                                        .pushReplacementNamed('/login'));
                              }*/),
                        )
                      ]),
                    )
                  ],
                ),
        ));
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
