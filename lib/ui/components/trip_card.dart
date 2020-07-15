import 'package:flutter/material.dart';
import 'package:atlas/ui/screens/trip_screen.dart';

class TripCard extends StatelessWidget {
  final String name;
  final double amount;
  final double distance;
  TripCard({this.name, this.amount, this.distance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Container(
              child: Image(image: AssetImage('assets/graphics/map.png')),
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        distance.toString() + 'km',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Colors.blueGrey),
                      ),
                      Text(
                        '\$' + amount.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.grey),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TripScreen(
                                name: name,
                                amount: amount,
                                distance: distance,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            Text(
                              "view",
                              style: TextStyle(color: Colors.blue),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.blue,
                              size: 16,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  // Text(),
                ],
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
