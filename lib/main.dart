import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:material_search/material_search.dart';
import 'package:unicorndial/unicorndial.dart';
import 'trading.dart';
import 'investing.dart';
import 'settings.dart';
import 'account.dart';
import 'research.dart';
import 'home.dart';
import 'login.dart';
import 'auth.dart';
import 'signup.dart';
import 'next.dart';
import 'banking.dart';
import 'welcome.dart';

AuthService appAuth = new AuthService();

void main() async {
  // Set default home.
  Widget _defaultHome = new LoginPage();

  // Get result of the login function.
  bool _result = await appAuth.login();
  print(_result);
  if (_result) {
    _defaultHome = new HomePage();
  }

  runApp(new MaterialApp(
    home: _defaultHome,
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new HomePage(),
      '/login': (BuildContext context) => new LoginPage(),
      '/signup': (BuildContext context) => new SignUpPage(),
      '/next': (BuildContext context) => new NextPage(),
      '/bank': (BuildContext context) => new BankingPage(),
      '/welcome': (BuildContext context) => new WelcomePage(),
    },
    //home: new HomePage(),
    title: 'WeVest',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  var _isLoading = true;
  List data = List<double>.generate(78, (i) => 0.0);

  //bool pressAttention = false;
  //double duration = 1;
  //String chartSet = 'Trading';
  var subData = [];
  var tempData = [];
  var watch = [];
  var watchVal = [];
  Map map;
  Map parse;
  Map investments;
  var stocks = [];
  var quant = [];
  var doubList;
  var api = "I99SYY531EJ79C3S";
  Iterable inReverse;
  var doubListInReverse;
  int pos = 0;
  int keyPos = 0;
  double unIn;
  double last;
  String _name = 'No one';
  var _names;

  Future<String> getData(date) async {
    var client = new http.Client();
    String jsonData =
        await DefaultAssetBundle.of(context).loadString("assets/data.json");
    final jsonResult = json.decode(jsonData);
    String jsonData0 =
        await DefaultAssetBundle.of(context).loadString("assets/nasdaq.json");
    final jsonResult0 = json.decode(jsonData0);
    _names = [];
    for (var item in jsonResult0) {
      _names.add(item['Symbol']);
    }
    investments = jsonResult["000001"]["Trading"]["Investments"];
    unIn = jsonResult["000001"]["Trading"]["Uninvested Funds"];
    watch = jsonResult["000001"]["Trading"]["Watchlist"];
    investments.forEach((k, v) {
      stocks.add(k);
      quant.add(v);
    });
    for (var item in stocks) {
      await client
          .get(
              "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=" +
                  item +
                  "&interval=5min&outputsize=full&apikey=" +
                  api)
          .then((response) {
        tempData = [];
        map = json.decode(response.body);
        parse = map["Time Series (5min)"];
        void iterateMapEntry(key, value) {
          if (keyPos == 0) {
            date = key.split(" ")[0];
            keyPos++;
          }
          if (key.contains(date)) {
            value = parse[key]["4. close"];
            tempData.add(double.parse(value) * quant[pos]);
          }
        }

        parse.forEach(iterateMapEntry);
        doubList = new List<double>.from(tempData);
        inReverse = doubList.reversed;
        doubListInReverse = inReverse.toList();
        subData.add(doubListInReverse);
      });
      pos++;
    }
    for (var item in watch) {
      await client
          .get(
          "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=" +
              item +
              "&interval=5min&outputsize=full&apikey=" +
              api)
          .then((response) {
        tempData = [];
        map = json.decode(response.body);
        parse = map["Time Series (5min)"];
        void iterateMapEntry(key, value) {
          if (keyPos == 0) {
            date = key.split(" ")[0];
            keyPos++;
          }
          if (key.contains(date)) {
            value = parse[key]["4. close"];
            tempData.add(double.parse(value));
          }
        }
        parse.forEach(iterateMapEntry);
        doubList = new List<double>.from(tempData);
        inReverse = doubList.reversed;
        doubListInReverse = inReverse.toList();
        watchVal.add(doubListInReverse);
      });
    }
    //watchVal = new List<double>.from(watchVal);
    print(watchVal);
    for (var item0 in subData) {
      pos = 0;
      for (var item1 in item0) {
        data[pos] = data[pos] + item1;
        pos++;
      }
    }
    print(subData);
    pos = 0;
    for (var item in data) {
      data[pos] = item + unIn;
      pos++;
      last = item + unIn;
    }

    data.add(last);
    pos = 0;
    for (var item in data) {
      if (item == unIn) {
        data[pos] = last;
      } else {
        last = data[pos];
      }
      pos++;
    }
    print(data);
    this.setState(() {
      _isLoading = false;
    });
    client.close();
    return "Success!";
  }

  _buildMaterialSearchPage(BuildContext context) {
    final names = new List<String>.from(_names);
    names.sort();
    return new MaterialPageRoute<String>(
        settings: new RouteSettings(
          name: 'material_search',
          isInitialRoute: false,
        ),
        builder: (BuildContext context) {
          return new Material(
            child: new MaterialSearch<String>(
              placeholder: 'Search',
              results: names
                  .map((String v) => new MaterialSearchResult<String>(
                        //icon: Icons.person,
                        value: v,
                        text: "$v",
                      ))
                  .toList(),
              filter: (dynamic value, String criteria) {
                return value.toLowerCase().trim().contains(
                    new RegExp(r'' + criteria.toLowerCase().trim() + ''));
              },
              onSelect: (dynamic value) => Navigator.of(context).pop(value),
              onSubmit: (String value) => Navigator.of(context).pop(value),
            ),
          );
        });
  }

  _showMaterialSearch(BuildContext context) {
    Navigator.of(context)
        .push(_buildMaterialSearchPage(context))
        .then((dynamic value) {
      setState(() => _name = value as String);
    });
  }

  @override
  void initState() {
    super.initState();
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(now);
    this.getData(formatted);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "WeVest",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 35),
              ),
            ),
            Expanded(
              child: Text(
                "\$1k", // + (last * 2).toStringAsFixed(2),
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
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              color: Colors.grey[350],
                              child: Column(children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    icon: new Icon(Icons.home),
                                    onPressed: () {},
                                    iconSize: 28,
                                    padding: const EdgeInsets.all(16),
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    icon: new Icon(Icons.account_circle),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AccountRoute()),
                                      );
                                    },
                                    padding: const EdgeInsets.all(16),
                                    iconSize: 28,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    icon: new Icon(Icons.mail_outline),
                                    onPressed: () {},
                                    iconSize: 28,
                                    padding: const EdgeInsets.all(16),
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    icon: new Icon(Icons.settings),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SettingsRoute()),
                                      );
                                    },
                                    iconSize: 28,
                                    padding: const EdgeInsets.all(16),
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: IconButton(
                                    icon: new Icon(Icons.search),
                                    alignment: Alignment.bottomCenter,
                                    onPressed: () {
                                      _showMaterialSearch(context);
                                    },
                                    iconSize: 28,
                                    padding: const EdgeInsets.all(16),
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _mainChart('Trading', data),
                          _mainChart('Investing', watchVal),
                          _mainChart('Watch List', watchVal),
                        ],
                      ),
                    ),
                  ],
                )),
        //RefreshIndicator(child: null, onRefresh: null),
      ),
    );
  }

  Future<void> _refreshStockPrices() async {
    print('refreshing stocks...');
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(now);
    this.getData(formatted);
  }

  Widget _mainChart(title, mainData) {
    var lineData = [];
    print(title);
    print(mainData);
    if (title == "Trading") {
      print(mainData);
      lineData = mainData;
    } else if (title == "Investing") {
      print(mainData[1]);
      lineData = mainData[1];
    } else {
      print(mainData[0]);
      lineData = mainData[0];
    }

    return new Expanded(
        flex: 1,
        child: Container(
            margin: title != 'Investing'
                ? EdgeInsets.all(6.0)
                : EdgeInsets.only(left: 6.0, right: 6.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(4.0),
              ),
            ),
            child: Container(
                padding: EdgeInsets.all(4.0),
                //
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(left: 12.0),
                          child: Text(
                            title != 'Watch List'
                                ? "\$" + last.toStringAsFixed(2)
                                : "",
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.greenAccent,
                                fontSize: 26.0),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: IconButton(
                            icon: new Icon(Icons.add_circle_outline),
                            onPressed: () {
                              if (title == 'Investing') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InvestingRoute(
                                          title, mainData, stocks, quant, subData),
                                ));
                              } else if (title == 'Trading') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TradingRoute(
                                          title, mainData, stocks, quant, subData),
                                    ));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResearchRoute(
                                          title, mainData, watch),
                                    ));
                              }
                            },
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.all(12.0),
                            iconSize: 28,
                            color: Colors.greenAccent,
                          )),
                    ],
                  ),
                  Expanded(
                      child: Sparkline(
                    data: lineData,
                    lineColor: Colors.greenAccent,
                  ))
                ]))));
  }
}
