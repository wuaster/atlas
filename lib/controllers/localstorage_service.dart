import 'package:flutter/foundation.dart';
import 'package:atlas/controllers/localstorage.dart';

class LocalStorageService {
  LocalStorageService(
      {@required LocalStorageRepository localStorageRepository})
      : _localStorageRepository = localStorageRepository;

  LocalStorageRepository _localStorageRepository;

  Future<dynamic> getAll(String key) async {
    return await _localStorageRepository.getAll(key);
  }

  Future<void> save(String key, dynamic item) async {
    await _localStorageRepository.save(key, item);
  }
}