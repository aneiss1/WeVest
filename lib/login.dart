import 'main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                          child: Center(child: Text('WeVest')),
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
                          child: Center(child: Text('WeVest')),
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
                          child: Center(child: Text('WeVest')),
                        ),
                      ])),
              Container(
                color: Colors.greenAccent,
                child: Row(children: <Widget>[
                  Expanded(
                    child: FlatButton(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.greenAccent,
                        onPressed: () {
                          setState(() => this._status = 'loading');
                          appAuth.login().then((result) {
                            if (result) {
                              Navigator.of(context)
                                  .pushNamedAndRemoveUntil('/home', (_) => false);
                            } else {
                              setState(() => this._status = 'rejected');
                            }
                          });
                        }),
                  ),
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
                        color: Colors.greenAccent,
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/signup');
                        }),
                  )
                ]),
              )
            ],
          ),
        ),
      );
}
