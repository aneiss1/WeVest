import 'package:flutter/material.dart';

class ShoppingBasket extends StatefulWidget {
  @override
  ShoppingBasketState createState() => new ShoppingBasketState();
}

class MyItem {
  MyItem({this.isExpanded: false, this.header, this.body});

  bool isExpanded;
  final String header;
  final String body;
}

class ShoppingBasketState extends State<ShoppingBasket> {
  List<MyItem> _items = <MyItem>[new MyItem(header: 'header', body: 'body')];

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin:
      const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: Colors.grey[350],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
      child: new ListView(
        children: [
          new ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _items[index].isExpanded = !_items[index].isExpanded;
              });
            },
            children: _items.map((MyItem item) {
              return new ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Container(
                    padding: EdgeInsets.only(left: 18.0),
                    margin: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                        color: Colors.grey[350],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(24.0),
                      ),
                    ),
                    child: Row(children: [
                      Text(
                        "What's included",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: 'Bold',
                            fontSize: 33.0,
                            color: Theme.of(context).backgroundColor),
                      ),
                    ]),
                  );
                },
                isExpanded: item.isExpanded,
                body: new Container(
                  child: new Text("body"),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text('ExpansionPanel Example'),
      ),
      body: new ShoppingBasket(),
    ),
  ));
}
