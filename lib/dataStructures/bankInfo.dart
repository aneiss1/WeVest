class Bank {
  String _id;
  String _acct;
  String _rout;

  Bank(this._id, this._acct, this._rout);

  Bank.map(dynamic obj) {
    this._id = obj['id'];
    this._acct = obj['acct'];
    this._rout = obj['rout'];
  }

  String get id => _id;
  String get type => _acct;
  String get invAmt => _rout;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['id'] = _id;
    map['acct'] = _acct;
    map['rout'] = _rout;

    return map;
  }

  Bank.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._acct = map['acct'];
    this._rout = map['rout'];
  }
}