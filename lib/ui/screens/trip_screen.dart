import 'package:flutter/material.dart';

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
          Text(text),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            Image(
              image: AssetImage('assets/graphics/map.png'),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 128),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: <Widget>[
                        Text("July 10th 2020"),
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
                          Icons.local_gas_station,
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
