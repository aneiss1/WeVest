class SecondRouteState extends State<SecondRoute> {
  final title;

  SecondRouteState(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
          color: Colors.greenAccent,
          child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 32.0),
                  child: Transform(
                    alignment: Alignment.bottomLeft,
                    transform: Matrix4.skewY(-math.pi / 12.0)
                      ..rotateZ(math.pi / 12.0),
                    child: Container(
                      height: 80,
                      width: 10,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        border: Border.all(
                          width: 1.0,
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 32.0),
                  child: Transform(
                    alignment: Alignment.bottomLeft,
                    transform: Matrix4.skewY(math.pi / 12.0)
                      ..rotateZ(-math.pi / 12.0),
                    child: Container(
                      height: 80,
                      width: 10,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        border: Border.all(
                          width: 1.0,
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(-83, 0, 0),
                  child: Transform(
                    alignment: Alignment.topRight,
                    transform: Matrix4.skewY(math.pi / 12.0)
                      ..rotateZ(-math.pi / 12.0),
                    child: Container(
                      height: 120,
                      width: 15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 1.0,
                          color: Colors.grey[350],
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  //margin: EdgeInsets.only(left: 38.0),
                  child: Transform(
                    alignment: Alignment.topRight,
                    transform: Matrix4.skewY(-math.pi / 12.0)
                      ..rotateZ(math.pi / 12.0),
                    child: Container(
                      height: 120,
                      width: 15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 1.0,
                          color: Colors.grey[350],
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ]
          )
      ),
    );
  }
}
