import 'main.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _status = 'no-action';

  @override
  Widget build(BuildContext context) => new Scaffold(
        body: new Container(
          child: new Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  //color: Colors.grey[350],
                  constraints: BoxConstraints.expand(),
                  alignment: Alignment(0.0, 1.0),
                  child: Text(
                    "General information",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 36,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                  flex: 4,
                  child: Center(
                      child: ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.10,
                                    right: MediaQuery.of(context).size.width *
                                        0.10,
                                    bottom: 4.0),
                                padding: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4.0),
                                  ),
                                ),
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'First Name'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.10,
                                    right: MediaQuery.of(context).size.width *
                                        0.10,
                                    bottom: 4.0),
                                padding: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4.0),
                                  ),
                                ),
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Last Name'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.10,
                                    right: MediaQuery.of(context).size.width *
                                        0.10,
                                    bottom: 4.0),
                                padding: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4.0),
                                  ),
                                ),
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Alias'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.10,
                                    right: MediaQuery.of(context).size.width *
                                        0.10,
                                    bottom: 4.0),
                                padding: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4.0),
                                  ),
                                ),
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Email'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.10,
                                    right: MediaQuery.of(context).size.width *
                                        0.10,
                                    bottom: 4.0),
                                padding: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4.0),
                                  ),
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Phone Number'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.10,
                                    right: MediaQuery.of(context).size.width *
                                        0.10,
                                    bottom: 4.0),
                                padding: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4.0),
                                  ),
                                ),
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Address'),
                                ),
                              ),
                            ],
                          )))),
              Container(
                color: Colors.greenAccent,
                child: Row(children: <Widget>[
                  Expanded(
                    child: FlatButton(
                        disabledColor: Colors.grey,
                        child: Text(
                          "Next",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.greenAccent,
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/next');
                        }),
                  )
                ]),
              )
            ],
          ),
        ),
      );
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
