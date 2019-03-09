import 'main.dart';
import 'package:flutter/material.dart';
import 'services/authentication.dart';
import 'services/firestoreBasic.dart';
import 'package:we_vest/dataStructures/basic.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.auth, this.userId, this.onSignedOut, this.basic})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final userId;
  final Basic basic;

  @override
  State<StatefulWidget> createState() => new _SignUpPageState(this.userId);
}

class _SignUpPageState extends State<SignUpPage> {
  String userId;
  final _formKey = new GlobalKey<FormState>();
  String _status = 'no-action';

  _SignUpPageState(this.userId);

  FirebaseFirestoreService db = new FirebaseFirestoreService();

  TextEditingController _userIdController;
  TextEditingController _firstController;
  TextEditingController _lastController;
  TextEditingController _aliasController;
  TextEditingController _phoneController;
  TextEditingController _addressController;

  //String _user = userId;
  String _first;
  String _last;
  String _alias;
  String _phone;
  String _address;

  @override
  void initState() {
    super.initState();
    _userIdController = new TextEditingController();
    _firstController = new TextEditingController();
    _lastController = new TextEditingController();
    _aliasController = new TextEditingController();
    _phoneController = new TextEditingController();
    _addressController = new TextEditingController();
  }


  bool _validateAndSave() {
    final form = _formKey.currentState;
    //print(userId);
    form.validate();
    if (form.validate()) {
      form.save();
      db.createBasic(userId, _first, _last, _alias, _phone, _address);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/next', (_) => false);
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
                                      controller: _firstController,
                                      decoration: InputDecoration(
                                          labelText: 'First Name'),
                                      validator: (value) => value.isEmpty
                                          ? 'First name can\'t be empty'
                                          : null,
                                      onSaved: (value) => _first = value,
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
                                      controller: _lastController,
                                      decoration: InputDecoration(
                                          labelText: 'Last Name'),
                                      validator: (value) => value.isEmpty
                                          ? 'First name can\'t be empty'
                                          : null,
                                      onSaved: (value) => _last = value,
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
                                      controller: _aliasController,
                                      decoration:
                                          InputDecoration(labelText: 'Alias'),
                                      validator: (value) => value.isEmpty
                                          ? 'Alias can\'t be empty'
                                          : null,
                                      onSaved: (value) => _alias = value,
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
                                      controller: _phoneController,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          labelText: 'Phone Number'),
                                      validator: (value) => value.isEmpty
                                          ? 'Phone number can\'t be empty'
                                          : null,
                                      onSaved: (value) => _phone = value,
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
                                      controller: _addressController,
                                      decoration:
                                          InputDecoration(labelText: 'Address'),
                                      validator: (value) => value.isEmpty
                                          ? 'Addrtess can\'t be empty'
                                          : null,
                                      onSaved: (value) => _address = value,
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
                        "Next",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blueGrey,
                      onPressed: _validateAndSave,/*() {
                        final form = _formKey.currentState;
                        form.validate();
                        Navigator.of(context).pushReplacementNamed('/next'); //_validateAndSave
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
