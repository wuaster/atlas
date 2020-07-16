import 'package:flutter/material.dart';
import '../components/card.dart';
import 'package:atlas/controllers/localstorage.dart';
import 'package:atlas/controllers/moneyservice.dart';
import 'package:atlas/controllers/emissionservice.dart';

class DashboardScreen extends StatefulWidget {
 @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double _money;
  int _emissions;
  MoneyService _moneyService;
  EmissionService _emissionService;

  @override
  void initState() {
    super.initState();

    _money = 0;
    _moneyService = MoneyService(
        localStorageRepository: LocalStorageRepository("money.json"));
    _emissions = 0;
    _emissionService = EmissionService(
        localStorageRepository: LocalStorageRepository("emissions.json"));
  }

  Future<void> _getMoney() async {
    final double _newMoney = await _moneyService.getMoney();

    setState(() {
      _money = _newMoney;
    });
  }
  Future<void> _getEmissions() async {
    final int _newEmissions = await _emissionService.getEmissions();

    setState(() {
      _emissions = _newEmissions;
    });
  }
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
                            children: <Widget> [
                            Text(
                              'Money Saved',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black.withOpacity(0.5)),
                            ),
                            Icon(
                              Icons.attach_money,
                              color: Colors.green,
                              size: 24.0,
                            ),
                          ]
                          )
                          
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          primary: false,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: <Widget>[
                            FutureBuilder<double>(
                              future: _moneyService.getMoney(),
                              builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                                if (snapshot.hasData) {
                                  _money = snapshot.data;
                                  return PCard(
                                          front: 'Today',
                                          back:'\$' + _money.toString(),
                                          color: Color(0xFFB2DFDB)
                                        );
                                }
                                return CircularProgressIndicator();
                              },
                            ),
                            FutureBuilder<double>(
                              future: _moneyService.getMoney(),
                              builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                                if (snapshot.hasData) {
                                  _money = snapshot.data;
                                  return PCard(
                                          front: 'This Week',
                                          back: '\$' + _money.toString(),
                                          color: Color(0xFF80CBC4)
                                        );
                                }
                                return CircularProgressIndicator();
                              },
                            ),
                            FutureBuilder<double>(
                              future: _moneyService.getMoney(),
                              builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                                if (snapshot.hasData) {
                                  _money = snapshot.data;
                                  return  PCard(
                                            front: 'This Month',
                                            back: '\$' + _money.toString(),
                                            color: Color(0xFF4DB6AC)
                                          );
                                }
                                return CircularProgressIndicator();
                              },
                            ),
                            FutureBuilder<double>(
                              future: _moneyService.getMoney(),
                              builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                                if (snapshot.hasData) {
                                  _money = snapshot.data;
                                  return  PCard(
                                            front: 'This Year',
                                            back: '\$' + _money.toString(),
                                            color: Color(0xFF26A69A)
                                          );
                                }
                                return CircularProgressIndicator();
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: <Widget> [
                            Text(
                              'Emissions',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black.withOpacity(0.5)),
                            ),
                            Icon(
                              Icons.local_gas_station,
                              color: Colors.blue,
                              size: 24.0,
                            ),
                          ]
                          )
                        ),
                         GridView.count(
                          shrinkWrap: true,
                          primary: false,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: <Widget>[
                            FutureBuilder<int>(
                              future: _emissionService.getEmissions(),
                              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                if (snapshot.hasData) {
                                  _emissions = snapshot.data;
                                  return PCard(
                                          front: 'Today',
                                          back: _emissions.toString() + " kg",
                                          color: Color(0xFFCFD8DC)
                                        );
                                }
                                return CircularProgressIndicator();
                              },
                            ),
                            FutureBuilder<int>(
                              future: _emissionService.getEmissions(),
                              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                if (snapshot.hasData) {
                                  _emissions = snapshot.data;
                                  return PCard(
                                          front: 'This Week',
                                          back: _emissions.toString() + " kg",
                                          color: Color(0xFFB0BEC5)
                                        );
                                }
                                return CircularProgressIndicator();
                              },
                            ),
                            FutureBuilder<int>(
                              future: _emissionService.getEmissions(),
                              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                if (snapshot.hasData) {
                                  _emissions = snapshot.data;
                                  return PCard(
                                          front: 'This Month',
                                          back: _emissions.toString() + " kg",
                                          color: Color(0xFF90A4AE)
                                        );
                                }
                                return CircularProgressIndicator();
                              },
                            ),
                            FutureBuilder<int>(
                              future: _emissionService.getEmissions(),
                              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                if (snapshot.hasData) {
                                  _emissions = snapshot.data;
                                  return PCard(
                                          front: 'This Year',
                                          back: _emissions.toString() + " kg",
                                          color: Color(0xFF78909C)
                                        );
                                }
                                return CircularProgressIndicator();
                              },
                            ),       
                          ],
                        ),
                      ],
                    )
                )
    );
              

 }
}
