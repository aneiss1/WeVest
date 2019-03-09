import 'main.dart';
import 'package:flutter/material.dart';
import 'services/authentication.dart';
import 'services/firestoreBank.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class BankingPage extends StatefulWidget {
  BankingPage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final userId;

  @override
  State<StatefulWidget> createState() => new _BankingPageState(this.userId);
}

class _BankingPageState extends State<BankingPage> {
  String _acct;
  String _rout;
  final _formKey = new GlobalKey<FormState>();
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  String userId;

  _BankingPageState(this.userId);

  bool _validateAndSave() {
    final form = _formKey.currentState;
    //print(userId);
    form.validate();
    if (form.validate()) {
      form.save();
      db.createBank(userId, _acct, _rout);
      Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (_) => false);
      return true;
    }
    return false;
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
                      child: new Form(
                          key: _formKey,
                          child: ScrollConfiguration(
                              behavior: MyBehavior(),
                              child: ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.10,
                                        right:
                                            MediaQuery.of(context).size.width *
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
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          labelText: 'Routing Number'),
                                      validator: (value) => value.isEmpty
                                          ? 'Rounting number can\'t be empty'
                                          : null,
                                      onSaved: (value) => _rout = value,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.10,
                                        right:
                                            MediaQuery.of(context).size.width *
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
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          labelText: 'Account Number'),
                                      validator: (value) => value.isEmpty
                                          ? 'Account number can\'t be empty'
                                          : null,
                                      onSaved: (value) => _acct = value,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.10,
                                        right:
                                            MediaQuery.of(context).size.width *
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
                              ))))),
              Container(
                color: Colors.blueGrey,
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
                      color: Colors.blueGrey,
                      onPressed:
                          _validateAndSave, /*() {
                      Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (_) => false);
                    }*/
                    ),
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
