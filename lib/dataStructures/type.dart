class Type {
  String _id;
  int _type;
  int _invAmt;

  Type(this._id, this._type, this._invAmt);

  Type.map(dynamic obj) {
    this._id = obj['id'];
    this._type = obj['type'];
    this._invAmt = obj['invAmt'];
  }

  String get id => _id;
  int get type => _type;
  int get invAmt => _invAmt;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['id'] = _id;
    map['type'] = _type;
    map['invAmt'] = _invAmt;

    return map;
  }

  Type.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._type = map['type'];
    this._invAmt = map['invAmt'];
  }
}