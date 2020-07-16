import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TripScreen extends StatelessWidget {
  final String name;
  final double amount;
  final double distance;
  TripScreen({this.name, this.amount, this.distance});

  Widget stat(text, icon, color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: color,
          ),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget charityLink(name, url, img) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image(
            image: AssetImage('assets/graphics/$img'),
            width: 100,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.right,
              ),
              FlatButton.icon(
                padding: EdgeInsets.all(0),
                onPressed: () => _launchURL(url),
                icon: Icon(
                  Icons.monetization_on,
                  color: Colors.green,
                ),
                label: Text("Donate \$$amount"),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Hero(
            tag: name,
            child: Image(
              image: AssetImage('assets/graphics/map.png'),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(32, 128, 32, 32),
            child: Column(
              children: <Widget>[
                Hero(
                  tag: "$name card",
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "July 10th 2020",
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          "To $name",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        stat(
                          "7 kg CO2",
                          Icons.local_gas_station,
                          Colors.blue,
                        ),
                        stat(
                          "\$$amount saved",
                          Icons.money_off,
                          Colors.green,
                        ),
                        stat(
                          "$distance km travelled",
                          Icons.directions,
                          Colors.amber,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                Image(
                  image: AssetImage('assets/graphics/turbines.png'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Curated Organizations",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        charityLink(
                          "Tree Canada",
                          "https://treecanada.ca/",
                          "treecan.png",
                        ),
                        charityLink(
                          "Arbor Day",
                          "https://shop.arborday.org/forest-replanting-donation",
                          "arbor.png",
                        ),
                        charityLink(
                          "Charity: Water",
                          "https://www.charitywater.org/donate",
                          "charitywater.png",
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
