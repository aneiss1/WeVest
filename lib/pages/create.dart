import 'package:flutter/material.dart';
import '../services/authentication.dart';

class CreatePage extends StatefulWidget {
  CreatePage({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _CreatePageState();
}

enum FormMode { LOGIN, SIGNUP }

class _CreatePageState extends State<CreatePage> {
  final _formKey = new GlobalKey<FormState>();
  ScrollController _scrollController = new ScrollController();

  String _email;
  String _password;
  String _errorMessage;
  String _button = "Create Account";

  // Initial form is login form
  FormMode _formMode = FormMode.SIGNUP;
  bool _isIos;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    print(_validateAndSave());
    if (_validateAndSave()) {
      String userId = "";
      try {
        if (_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          widget.auth.sendEmailVerification();
          _showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 &&
            userId != null &&
            _formMode == FormMode.LOGIN) {
          print("THIS IS THE USERID" + userId);
          widget.onSignedIn();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.message;
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    //_formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
      _button = "Continue";
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
                "Sign Up",
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
                                  maxLines: 1,
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: false,
                                  decoration: new InputDecoration(
                                    hintText: 'Email',
                                  ),
                                  validator: (value) => value.isEmpty
                                      ? 'Email can\'t be empty'
                                      : null,
                                  onSaved: (value) => _email = value,
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
                                  maxLines: 1,
                                  obscureText: true,
                                  autofocus: false,
                                  decoration: new InputDecoration(
                                    hintText: 'Password',
                                  ),
                                  validator: (value) => value.isEmpty
                                      ? 'Password can\'t be empty'
                                      : null,
                                  onSaved: (value) => _password = value,
                                ),
                              ),
                              _showErrorMessage(),
                              //_showCircularProgress(),
                            ],
                          ))))),
          Container(
            color: Colors.blueGrey,
            child: Row(children: <Widget>[
              Expanded(
                child: FlatButton(
                  child: Text(
                    _button,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blueGrey,
                  onPressed: _validateAndSubmit,
/*                          setState(() => this._status = 'loading');
                          appAuth.login().then((result) {
                            if (result) {
                              Navigator.of(context)
                                  .pushNamedAndRemoveUntil('/home', (_) => false);
                            } else {
                              setState(() => this._status = 'rejected');
                            }
                          });*/
                ),
              ),
            ]),
          )
        ],
      ),
    ),
  );

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your email account"),
          content:
          new Text("A link to verify your account has been sent to your email. Please confirm then continue."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                _changeFormToLogin();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showBody() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              //_showLogo(),
              _showEmailInput(),
              _showPasswordInput(),
              // _showPrimaryButton(),
              //_showSecondaryButton(),
              _showErrorMessage(),
            ],
          ),
        ));
  }

  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/flutter-icon.png'),
        ),
      ),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Email',
          /*icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )*/
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value,
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Password',
          /*icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )*/
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _showSecondaryButton() {
    return new FlatButton(
      child: _formMode == FormMode.LOGIN
          ? new Text('Create an account',
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
          : new Text('Have an account? Sign in',
          style:
          new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignUp
          : _changeFormToLogin,
    );
  }

  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: _formMode == FormMode.LOGIN
                ? new Text('Login',
                style: new TextStyle(fontSize: 20.0, color: Colors.white))
                : new Text('Create account',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: _validateAndSubmit,
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
