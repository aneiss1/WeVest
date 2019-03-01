import 'main.dart';
import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _NextPageState();
}

class _NextPageState extends State<NextPage> {
  String _status = 'no-action';
  int _radioValue1 = -1;
  int _radioValue2 = -1;
  bool vis0 = false;
  bool vis1 = false;

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          vis0 = true;
          vis1 = false;
          print(_radioValue1);
          break;
        case 1:
          vis0 = false;
          vis1 = true;
          print(_radioValue1);
          break;
        case 2:
          vis0 = true;
          vis1 = true;
          print(_radioValue1);
          break;
      }
    });
  }

  void _handleRadioValueChange2(int value) {
    setState(() {
      _radioValue2 = value;

      switch (_radioValue2) {
        case 0:
          print(_radioValue2);
          break;
        case 1:
          print(_radioValue2);
          break;
        case 2:
          print(_radioValue2);
          break;
        case 3:
          print(_radioValue2);
          break;
        case 4:
          print(_radioValue2);
          break;
      }
    });
  }

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
                    "Interested in",
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
                                //padding: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4.0),
                                  ),
                                ),
                                child: new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    new Radio(
                                      value: 0,
                                      groupValue: _radioValue1,
                                      onChanged: _handleRadioValueChange1,
                                      activeColor: Colors.greenAccent,
                                    ),
                                    new Text(
                                      'Investing',
                                      style: new TextStyle(fontSize: 16.0),
                                    ),
                                    new Radio(
                                      value: 1,
                                      groupValue: _radioValue1,
                                      onChanged: _handleRadioValueChange1,
                                      activeColor: Colors.greenAccent,
                                    ),
                                    new Text(
                                      'Trading  ',
                                      style: new TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    new Radio(
                                      value: 2,
                                      groupValue: _radioValue1,
                                      onChanged: _handleRadioValueChange1,
                                      activeColor: Colors.greenAccent,
                                    ),
                                    new Text(
                                      'Both     ',
                                      style: new TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.10,
                                      right: MediaQuery.of(context).size.width *
                                          0.10,
                                      bottom: 4.0),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1.0,
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Investing",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 24,
                                          color: Colors.greenAccent,
                                        ),
                                      ),
                                      Text(
                                        "How much do you want to start out investing?",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      new Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            new Radio(
                                              value: 0,
                                              groupValue: _radioValue2,
                                              onChanged:
                                                  _handleRadioValueChange2,
                                              activeColor: Colors.greenAccent,
                                            ),
                                            new Text(
                                              '\$250',
                                              style:
                                                  new TextStyle(fontSize: 16.0),
                                            ),
                                          ]),
                                      new Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            new Radio(
                                              value: 1,
                                              groupValue: _radioValue2,
                                              onChanged:
                                                  _handleRadioValueChange2,
                                              activeColor: Colors.greenAccent,
                                            ),
                                            new Text(
                                              '\$500',
                                              style:
                                                  new TextStyle(fontSize: 16.0),
                                            ),
                                          ]),
                                      new Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            new Radio(
                                              value: 2,
                                              groupValue: _radioValue2,
                                              onChanged:
                                                  _handleRadioValueChange2,
                                              activeColor: Colors.greenAccent,
                                            ),
                                            new Text(
                                              '\$750',
                                              style:
                                                  new TextStyle(fontSize: 16.0),
                                            ),
                                          ]),
                                      new Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            new Radio(
                                              value: 3,
                                              groupValue: _radioValue2,
                                              onChanged:
                                                  _handleRadioValueChange2,
                                              activeColor: Colors.greenAccent,
                                            ),
                                            new Text(
                                              '\$1,000',
                                              style:
                                                  new TextStyle(fontSize: 16.0),
                                            ),
                                          ]),
                                      new Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            new Radio(
                                              value: 4,
                                              groupValue: _radioValue2,
                                              onChanged:
                                                  _handleRadioValueChange2,
                                              activeColor: Colors.greenAccent,
                                            ),
                                            new Text(
                                              '\$1,000+',
                                              style:
                                                  new TextStyle(fontSize: 16.0),
                                            ),
                                          ]),
                                    ],
                                  ),
                                ),
                                maintainAnimation: true,
                                maintainState: true,
                                visible: vis0,
                              ),
                              Visibility(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.10,
                                      right: MediaQuery.of(context).size.width *
                                          0.10,
                                      bottom: 4.0),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1.0,
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Trading",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 24,
                                          color: Colors.greenAccent,
                                        ),
                                      ),
                                      Text(
                                        "Great! Everyone starts out at the \$250 level with opportunity to move up based on performance.\n\n "
                                            "You will be required to deposit \$25 to insure the funds you're trading.",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                maintainAnimation: true,
                                maintainState: true,
                                visible: vis1,
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
                          "Banking",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.greenAccent,
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/bank');
                          /*                setState(() => this._status = 'loading');
                      appAuth.login().then((result) {
                        if (result) {
                          Navigator.of(context)
                              .pushReplacementNamed('/home');
                        } else {
                          setState(() => this._status = 'rejected');
                        }
                      });*/
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
