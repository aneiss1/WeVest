import 'main.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String _status = 'no-action';
  ScrollController _scrollController = new ScrollController();

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
                    "WeVest",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 60,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                  flex: 3,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      //reverse: true,
                      controller: _scrollController,
                      children: <Widget>[
                        Container(
                          //constraints: BoxConstraints.expand(),
                          width: MediaQuery.of(context).size.width * 0.60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.0,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          margin: EdgeInsets.only(
                              left: 75.0, right: 30.0, top: 60.0, bottom: 60.0),
                          //padding: EdgeInsets.all(1),
                          child: Center(child: Text('Info')),
                        ),
                        Container(
                          //constraints: BoxConstraints.expand(),
                          width: MediaQuery.of(context).size.width * 0.60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.0,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          margin: EdgeInsets.only(
                              right: 30.0, top: 60.0, bottom: 60.0),
                          //padding: EdgeInsets.all(1),
                          child: Center(child: Text('Info')),
                        ),
                        Container(
                          //constraints: BoxConstraints.expand(),
                          width: MediaQuery.of(context).size.width * 0.60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.0,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          margin: EdgeInsets.only(
                              right: 75.0, top: 60.0, bottom: 60.0),
                          //padding: EdgeInsets.all(1),
                          child: Center(child: Text('Info')),
                        ),
                      ])),
              Container(
                color: Colors.blueGrey,
                child: Row(children: <Widget>[
                  Expanded(
                    child: FlatButton(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/create');
                        }),
                  )
                ]),
              )
            ],
          ),
        ),
      );
}
