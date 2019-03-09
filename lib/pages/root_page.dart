import 'package:flutter/material.dart';
import '../pages/login_signup_page.dart';
import '../services/authentication.dart';
//import '../pages/home_page.dart';
import '../pages/create.dart';
import '../main.dart';
import '../signup.dart';
import '../next.dart';
import '../banking.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth, this.type});

  final BaseAuth auth;
  final String type;


  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void _onLoggedIn() {
    print("test here");
    widget.auth.getCurrentUser().then((user){
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;

    });
  }

  void _onSignedOut() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return _buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        if (widget.type == "log"){
          print("NOT LOGGED IN - LOG IN");
          return new LoginSignUpPage(
            auth: widget.auth,
            onSignedIn: _onLoggedIn,
          );
        } else {
          print("NOT LOGGED IN - Create");
          return new CreatePage(
            auth: widget.auth,
            onSignedIn: _onLoggedIn,
          );
        }
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          if (widget.type == "log"){
            print("LOGGED IN - log" + _userId);
            return new HomePage(
              userId: _userId,
              auth: widget.auth,
              onSignedOut: _onSignedOut,
            );
          } else if (widget.type == "create") {
            print("LOGGED IN - create" + _userId);
            return new SignUpPage(
              userId: _userId,
              auth: widget.auth,
              onSignedOut: _onSignedOut,
            );
          } else if (widget.type == "next") {
            print("LOGGED IN - create" + _userId);
            return new NextPage(
              userId: _userId,
              auth: widget.auth,
              onSignedOut: _onSignedOut,
            );
          } else if (widget.type == "bank") {
            print("LOGGED IN - create" + _userId);
            return new BankingPage(
              userId: _userId,
              auth: widget.auth,
              onSignedOut: _onSignedOut,
            );
          }else return _buildWaitingScreen();
        }
        break;
      default:
        return _buildWaitingScreen();
    }
  }
}
