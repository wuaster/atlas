import 'package:flutter/material.dart';
import 'package:atlas/ui/components/trip_card.dart';
import 'package:atlas/controllers/localstorage.dart';
import 'package:atlas/controllers/tripservice.dart';

class HistoryScreen extends StatefulWidget {
 @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  TripService _tripService;
  List<double> _moneyList;
  List<int> _emissionsList;
  List<double> _distanceList;
  @override
  void initState() {
    super.initState();
    _moneyList = [];
    _emissionsList = [];
    _distanceList = [];
    _tripService = TripService(
    localStorageRepository: LocalStorageRepository("trip.json"));
  }

  Widget renderTrips()
  {
    _getMoney();
    _getEmissions();
    _getDistance();
    List<Widget> list = new List<Widget>();
    list.add(new Text(
              "Your Trips",
              style: Theme.of(context).textTheme.headline5,
            ));
    list.add(new Text(
              "Today",
              style: Theme.of(context).textTheme.subtitle1,
            ));
    for(var i = 0; i < _emissionsList.length; i++){
        list.add(TripCard(
                  name: "Trip "+ (i+1).toString(),
                  emission: _emissionsList[i],
                  amount: _moneyList[i],
                  distance: _distanceList[i],
                ));
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: list
        )
      ),
    );
  }
  Future<void> _getMoney() async {
    final List<double> _newMoneyList = await _tripService.getMoney();

    setState(() {
      _moneyList = _newMoneyList;
    });
  }

  Future<void> _getEmissions() async {
    final List<int> _newEmissionsList = await _tripService.getEmissions();

    setState(() {
      _emissionsList = _newEmissionsList;
    });
  }

  Future<void> _getDistance() async {
    final List<double> _newDistanceList = await _tripService.getDistance();

    setState(() {
      _distanceList = _newDistanceList;
    });
  }

  Widget build(BuildContext context) {
    return renderTrips();
  }
}
