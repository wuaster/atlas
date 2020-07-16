import 'package:flutter/foundation.dart';
import 'package:atlas/controllers/localstorage_service.dart';
import 'package:atlas/controllers/localstorage.dart';

class EmissionService {
  final LocalStorageService _localStorageService;
  final String _emissionsKey = "emissions";

  EmissionService({
    @required LocalStorageRepository localStorageRepository,
  }) : _localStorageService =
            LocalStorageService(localStorageRepository: localStorageRepository);
  Future<int> getEmissions() async {
    return await _localStorageService.getAll(_emissionsKey) ?? 0;
  }

  Future<int> saveEmissions(int emissions) async {
    await _localStorageService.save(_emissionsKey, emissions);
  }
}