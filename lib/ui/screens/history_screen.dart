import 'package:flutter/material.dart';
import 'package:atlas/ui/components/trip_card.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              "Your Trips",
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              "Yesterday",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            TripCard(
              name: "Walmart",
              amount: 1.17,
              distance: 8,
            ),
            TripCard(
              name: "Morning Bike Ride",
              amount: 5.23,
              distance: 20,
            ),
          ],
        ),
      ),
    );
  }
}
