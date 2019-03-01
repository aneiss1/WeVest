import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'main.dart';

class AccountRoute extends StatefulWidget {
  AccountRoute();

  @override
  AccountRouteState createState() => new AccountRouteState();
}

class AccountRouteState extends State<AccountRoute> {
  var profile;
  var _isLoading = true;

  AccountRouteState();

  Future<String> getData() async {
    String jsonData =
        await DefaultAssetBundle.of(context).loadString("assets/data.json");
    final jsonResult = json.decode(jsonData);
    profile = jsonResult["000001"]["Profile"];
    print(profile);
    this.setState(() {
      _isLoading = false;
    });
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
                                                    profile["First Name"]
                                                        .toString(),
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
                                                    profile["Last Name"]
                                                        .toString(),
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
                                                profile["Alias"].toString(),
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
                                                profile["Email"].toString(),
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
                                                profile["Phone Number"]
                                                    .toString(),
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
                                                profile["Address"].toString(),
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
                      color: Colors.greenAccent,
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
                              color: Colors.greenAccent,
                              onPressed: () {
                                appAuth.logout().then((_) =>
                                    Navigator.of(context)
                                        .pushReplacementNamed('/login'));
                              }),
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
