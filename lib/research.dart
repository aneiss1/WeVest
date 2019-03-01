import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ResearchRoute extends StatefulWidget {
  final title;
  final data;
  final stocks;

  ResearchRoute(this.title, this.data, this.stocks);

  @override
  ResearchRouteState createState() =>
      new ResearchRouteState(title, data, stocks);
}

class ResearchRouteState extends State<ResearchRoute> {
  final title;
  final data;
  final stocks;
  double duration = 6.5;
  String invSel = "all";
  int invSelNum = 0;
  var _isLoading = true;
  var api = "WGFJVSCRF7IO9CV0";
  var client = new http.Client();
  Map map;
  var quotes = [];
  var open = "";
  var change = "";
  var volume = "";
  var quote = "";
  var total = 0.0;
  var totalInv = 0.0;
  var openAll = 0.0;
  var changeAll = 0.0;
  AnimationController _controller;

  ResearchRouteState(
      this.title, this.data, this.stocks);

  Future<String> getData() async {
    for (var item in stocks) {
      await client
          .get(
          "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=" +
              item +
              "&apikey=" +
              api)
          .then((response) {
        map = json.decode(response.body);
        quotes.add(map);
      });
    }
    print(quotes);
    this.setState(() {
      _isLoading = false;
    });
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    openAll = data[0][0];
    totalInv = data[0][data[0].length - 1];
    changeAll = totalInv - openAll;
    total = totalInv + 0;
    this.getData();

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 35),
              ),
            ),
            Expanded(
              child: Text(
                "\$" + total.toStringAsFixed(2),
                // + (last * 2).toStringAsFixed(2),
                textAlign: TextAlign.right,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 35),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.greenAccent,
        elevation: 0.0,
      ),
      body: new Center(
        child: _isLoading
            ? new CircularProgressIndicator()
            : new RefreshIndicator(
            onRefresh: _refreshStockPrices,
            child: Column(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                ),
                margin: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: new Column(
                  children: <Widget>[
                    //new LinearProgressIndicator(backgroundColor: Colors.transparent),
                    new Container(
                        child: invSel == "all"
                            ? Text(
                          "\$" + totalInv.toStringAsFixed(2),
                          style: new TextStyle(
                            fontSize: 32.0,
                            color: Colors.grey,
                          ),
                        )
                            : Text(
                          "\$" + quote,
                          style: new TextStyle(
                            fontSize: 32.0,
                            color: Colors.grey,
                          ),
                        )),
                    new Container(
                      width: 600.0,
                      height: 240.0,
                      padding: EdgeInsets.only(
                          top: 4.0, left: 4.0, right: 4.0, bottom: 4.0),
                      child: new Sparkline(
                        data: data[invSelNum],
                        lineColor: Colors.greenAccent,
                      ),
                    ),
                    new Container(
                      child: Container(
                          margin:
                          EdgeInsets.only(left: 4.0, right: 4.0),
                          child: new Row(children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Open \$" + open,
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Change \$" + change,
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Volume " + volume,
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ])),
                    ),
                    new Row(children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: new Container(
                          margin: const EdgeInsets.only(
                              top: 4.0, bottom: 4.0, left: 4.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: Colors.grey[350],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          child: new FlatButton(
                            child: new Text(
                              'H',
                              style: new TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: duration == 1
                                    ? Colors.white
                                    : Colors.grey[350],
                              ),
                            ),
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            color: duration == 1
                                ? Colors.grey[350]
                                : Colors.transparent,
                            onPressed: () => setState(() => duration = 1),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: new Container(
                          margin: const EdgeInsets.only(
                              top: 4.0, bottom: 4.0, left: 4.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: Colors.grey[350],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          child: new FlatButton(
                            child: new Text(
                              'D',
                              style: new TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: duration == 6.5
                                    ? Colors.white
                                    : Colors.grey[350],
                              ),
                            ),
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            color: duration == 6.5
                                ? Colors.grey[350]
                                : Colors.transparent,
                            onPressed: () => setState(() => duration = 6.5),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: new Container(
                          margin: const EdgeInsets.only(
                              top: 4.0, bottom: 4.0, left: 4.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: Colors.grey[350],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          child: new FlatButton(
                            child: new Text(
                              'W',
                              style: new TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: duration == 32.5
                                    ? Colors.white
                                    : Colors.grey[350],
                              ),
                            ),
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            color: duration == 32.5
                                ? Colors.grey[350]
                                : Colors.transparent,
                            onPressed: () =>
                                setState(() => duration = 32.5),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: new Container(
                          margin: const EdgeInsets.only(
                              top: 4.0, bottom: 4.0, left: 4.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: Colors.grey[350],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          child: new FlatButton(
                            child: new Text(
                              'M',
                              style: new TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: duration == 125
                                    ? Colors.white
                                    : Colors.grey[350],
                              ),
                            ),
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            color: duration == 125
                                ? Colors.grey[350]
                                : Colors.transparent,
                            onPressed: () => setState(() => duration = 125),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: new Container(
                          margin: const EdgeInsets.only(
                              top: 4.0, bottom: 4.0, left: 4.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: Colors.grey[350],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          child: new FlatButton(
                            child: new Text(
                              'Y',
                              style: new TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: duration == 1690
                                    ? Colors.white
                                    : Colors.grey[350],
                              ),
                            ),
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            color: duration == 1690
                                ? Colors.grey[350]
                                : Colors.transparent,
                            onPressed: () =>
                                setState(() => duration = 1690),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: new Container(
                          margin: const EdgeInsets.only(
                              top: 4.0, bottom: 4.0, left: 4.0, right: 4.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: Colors.grey[350],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          child: new FlatButton(
                            child: new Text(
                              '∞',
                              style: new TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: duration == 0
                                    ? Colors.white
                                    : Colors.grey[350],
                              ),
                            ),
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            color: duration == 0
                                ? Colors.grey[350]
                                : Colors.transparent,
                            onPressed: () => setState(() => duration = 0),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                    ),
                    margin:
                    EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                    padding: EdgeInsets.all(1),
                    child: Column(
                      children: <Widget>[
/*                            new Center(
                              child: new Text(
                                title,
                                style: new TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),*/
                        new Expanded(
                          //margin: EdgeInsets.symmetric(vertical: 20.0),
                          //height: 80.0,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      //mainAxisSize: MainAxisSize.max,
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 4.0, left: 4.0),
                                          child: Text(
                                            "Stock",
                                            style: new TextStyle(
                                              fontSize: 24.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 4.0, left: 4.0),
                                          child: Text(
                                            "Price",
                                            style: new TextStyle(
                                              fontSize: 24.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ]),
                                  _isLoading
                                      ? new CircularProgressIndicator()
                                      : new ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: stocks.length,
                                    itemBuilder: (context, index) {
                                      final stock = stocks[index];
                                      var priceD = double.parse(
                                          quotes[index]["Global Quote"]
                                          ["05. price"]);
                                      assert(priceD is double);
                                      String priceS =
                                      priceD.toStringAsFixed(2);
                                      //total = total + totalD;
                                      //totalInv = totalInv + totalD;
                                      var changeD = double.parse(
                                          quotes[index]["Global Quote"]
                                          ["09. change"]);
                                      assert(changeD is double);
                                      String changeS =
                                      changeD.toStringAsFixed(2);
                                      var openD = double.parse(
                                          quotes[index]["Global Quote"]
                                          ["02. open"]);
                                      assert(openD is double);
                                      String openS =
                                      openD.toStringAsFixed(2);
                                      var vol = quotes[index]
                                      ["Global Quote"]["06. volume"];
                                      var volLen = vol.length;
                                      var vol0;
                                      var vol1;
                                      var volS;
                                      if (volLen == 8) {
                                        vol0 = vol.substring(0, 2);
                                        vol1 = vol.substring(3, 4);
                                        volS = vol0 + "." + vol1 + "M";
                                      } else if (volLen == 7) {
                                        vol0 = vol.substring(0, 1);
                                        vol1 = vol.substring(2, 3);
                                        volS = vol0 + "." + vol1 + "M";
                                      } else if (volLen == 6) {
                                        vol0 = vol.substring(0, 3);
                                        //vol1 = vol.substring(2);
                                        volS = vol0 + "." + vol1 + "K";
                                      }
                                      return Container(
                                        margin: const EdgeInsets.only(
                                            top: 4.0,
                                            bottom: 4.0,
                                            right: 4.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.5,
                                            color: changeS.contains("-")
                                                ? Colors.redAccent
                                                : Colors.greenAccent,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(4.0),
                                          ),
                                        ),
                                        child: new FlatButton(
                                            shape:
                                            new RoundedRectangleBorder(
                                                borderRadius:
                                                new BorderRadius
                                                    .circular(
                                                    3.5)),
                                            child:
                                            Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: <Widget>[
                                                  Center(
                                                    child: new Text(
                                                      stock,
                                                      textAlign: TextAlign
                                                          .center,
                                                      style:
                                                      new TextStyle(
                                                        fontSize: 32.0,
                                                        fontWeight:
                                                        FontWeight
                                                            .w400,
                                                        color:
                                                        Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                    EdgeInsets.only(
                                                        top: 4.0),
                                                    child: Text(
                                                      "\$" + priceS,
                                                      style:
                                                      new TextStyle(
                                                        fontSize: 24.0,
                                                        fontWeight:
                                                        FontWeight
                                                            .w300,
                                                        color:
                                                        Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                            materialTapTargetSize:
                                            MaterialTapTargetSize
                                                .shrinkWrap,
                                            color: invSel == stock
                                                ? Colors.grey[350]
                                                : Colors.transparent,
                                            onPressed: () => setState(() {
                                              invSel = stock;
                                              invSelNum = index;
                                              open = openS;
                                              change = changeS;
                                              volume = volS;
                                              quote = priceS;
                                            })),
                                      );
                                    },
                                  ),
                                ])),
                        new Row(
                          //height: 80.0,
                            children: <Widget>[
                              Container(
                                  height: 100,
                                  width: 89,
                                  margin: EdgeInsets.only(
                                      left: 4.0, bottom: 4.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.5,
                                      color: Colors.blueAccent,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                  ),
                                  child: FlatButton(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(
                                              3.5)),
                                      child: new Text(
                                        'Trade',
                                        style: new TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                      color: Colors.transparent,
                                      onPressed: () => setState(() {}))),
                              Expanded(
                                child: Container(
                                    height: 100,
                                    margin: EdgeInsets.only(
                                        left: 4.0, bottom: 4.0, right: 4.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 0.5,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                    ),
                                    child: FlatButton(
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius.circular(
                                                3.5)),
                                        child: new Text(
                                          'News',
                                          style: new TextStyle(
                                            fontSize: 32.0,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        materialTapTargetSize:
                                        MaterialTapTargetSize
                                            .shrinkWrap,
                                        color: Colors.transparent,
                                        onPressed: () => setState(() {}))),
                              )
                            ])
                      ],
                    )),
              )
            ])),
      ),
    );
  }

  Future<void> _refreshStockPrices() async {
    print('refreshing stocks...');
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(now);
    //this.getData(formatted);
  }
}