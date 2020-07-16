import 'package:flutter/material.dart';
import '../components/card.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(left: 24.0, top: 48.0, right: 24.0),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Dashboard',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Money Saved',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                      Icon(
                        Icons.attach_money,
                        color: Colors.green,
                        size: 24.0,
                      ),
                    ],
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    PCard(front: 'Today', back: '\$', color: Color(0xFFB2DFDB)),
                    PCard(
                        front: 'This Week',
                        back: '\$\$',
                        color: Color(0xFF80CBC4)),
                    PCard(
                        front: 'This Month',
                        back: '\$\$',
                        color: Color(0xFF4DB6AC)),
                    PCard(
                        front: 'This Year',
                        back: '\$\$',
                        color: Color(0xFF26A69A)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Emissions',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                      Icon(
                        Icons.local_gas_station,
                        color: Colors.blue,
                        size: 24.0,
                      ),
                    ],
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    PCard(front: 'Today', back: '\$', color: Color(0xFFCFD8DC)),
                    PCard(
                        front: 'This Week',
                        back: '\$\$',
                        color: Color(0xFFB0BEC5)),
                    PCard(
                        front: 'This Month',
                        back: '\$\$',
                        color: Color(0xFF90A4AE)),
                    PCard(
                        front: 'This Year',
                        back: '\$\$',
                        color: Color(0xFF78909C)),
                  ],
                ),
              ],
            )));
  }
}
