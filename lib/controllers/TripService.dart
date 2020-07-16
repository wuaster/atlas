import 'package:flutter/foundation.dart';
import 'package:atlas/controllers/localstorage_service.dart';
import 'package:atlas/controllers/localstorage.dart';

class TripService {
  final LocalStorageService _localStorageService;
  final String _tripDistanceKey = "distance";
  final String _tripMoneyKey = "money";
  final String _tripEmissionsKey = "emissions";
  List<double> distanceList = [];
  List<double> moneyList = [];
  List<int> emissionList = [];

  TripService({
    @required LocalStorageRepository localStorageRepository,
  }) : _localStorageService =
            LocalStorageService(localStorageRepository: localStorageRepository);
  Future<List<double>> getDistance() async {
    var tripDistance = await _localStorageService.getAll(_tripDistanceKey) ?? [0];
    return List<double>.from(tripDistance);
  }
  Future<List<double>> getMoney() async {
    var tripMoney = await _localStorageService.getAll(_tripMoneyKey) ?? [0];
    return List<double>.from(tripMoney);
  }
  Future<List<int>> getEmissions() async {
    var tripEmissions = await _localStorageService.getAll(_tripEmissionsKey) ?? [0];
    return List<int>.from(tripEmissions);
  }

  Future<double> saveDistance(double distance) async {
    distanceList = await getDistance();
    distanceList.insert(0, distance);
    await _localStorageService.save(_tripDistanceKey, distanceList);
  }
  Future<double> saveMoney(double money) async {
    moneyList = await getMoney();
    moneyList.insert(0, money);
    await _localStorageService.save(_tripMoneyKey, moneyList);
  }
  Future<int> saveEmissions(int emissions) async {
    emissionList = await getEmissions();
    emissionList.insert(0, emissions);
    await _localStorageService.save(_tripEmissionsKey, emissionList);
  }
  
}