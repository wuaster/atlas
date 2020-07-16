import 'package:flutter/foundation.dart';
import 'package:atlas/controllers/localstorage_service.dart';
import 'package:atlas/controllers/localstorage.dart';

class MoneyService {
  final LocalStorageService _localStorageService;
  final String _moneyKey = "money";
  final String _emissionsKey = "emissions";
  final String _distanceKey = "distance";

  MoneyService({
    @required LocalStorageRepository localStorageRepository,
  }) : _localStorageService =
            LocalStorageService(localStorageRepository: localStorageRepository);
  Future<double> getMoney() async {
    return await _localStorageService.getAll(_moneyKey) ?? 0;
  }

  Future<double> saveMoney(double money) async {
    double _newMoney = await getMoney();
    money += _newMoney;
    await _localStorageService.save(_moneyKey, money);
  }
}