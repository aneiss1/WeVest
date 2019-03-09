class Basic {
  String _id;
  String _first;
  String _last;
  String _alias;
  String _phone;
  String _address;

  Basic(this._id, this._first, this._last, this._alias, this._phone, this._address);

  Basic.map(dynamic obj) {
    this._id = obj['id'];
    this._first = obj['first'];
    this._last = obj['last'];
    this._alias = obj['alias'];
    this._phone = obj['phone'];
    this._address = obj['address'];
  }

  String get id => _id;
  String get first => _first;
  String get last => _last;
  String get alias => _alias;
  String get phone => _phone;
  String get address => _address;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['id'] = _id;
    map['first'] = _first;
    map['last'] = _last;
    map['alias'] = _alias;
    map['phone'] = _phone;
    map['address'] = _address;

    return map;
  }

  Basic.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._first = map['first'];
    this._last = map['last'];
    this._alias = map['alias'];
    this._phone = map['phone'];
    this._address = map['address'];
  }
}