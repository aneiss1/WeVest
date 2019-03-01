import 'main.dart';
import 'package:flutter/material.dart';

class BankingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _BankingPageState();
}

class _BankingPageState extends State<BankingPage> {
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
                "Financial information",
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
                              InputDecoration(labelText: 'Routing Number'),
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
                              InputDecoration(labelText: 'Account Number'),
                            ),
                          ),
                          Container(
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
                                  "A withdraw of \$25 will be deducted from your account to begin trading.",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
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
                      "Finish",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.greenAccent,
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (_) => false);
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
