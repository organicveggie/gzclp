import 'dart:developer';

import 'package:settings_api/settings_api.dart';

class SettingsRepository {
  const SettingsRepository({required SettingsApi settingsApi}) : _settingsApi = settingsApi;

  final SettingsApi _settingsApi;

  Stream<AppSettings> getAppSettings() {
    log('SettingsRepository.getAppSettings()');
    return _settingsApi.getAppSettings();
  }

  Future<void> saveAppSettings(AppSettings settings) {
    log('SettingsRepository.saveAppSettings()');
    return _settingsApi.saveAppSettings(settings);
  }
}
