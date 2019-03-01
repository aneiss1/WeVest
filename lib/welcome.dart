import 'main.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 2),
            () => Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false));
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
    body: new Container(
      child: new Column(
        children: <Widget>[
          Expanded(
              child: Center(
                child: Container(
                  //color: Colors.grey[350],
                  constraints: BoxConstraints.expand(),
                  alignment: Alignment(0.0, 0.0),
                  child: Text(
                    "Welcome to WeVest!",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 42,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
              ),
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
