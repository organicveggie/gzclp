import 'package:settings_api/settings_api.dart';

class SettingsRepository {
  const SettingsRepository({required SettingsApi settingsApi}) : _settingsApi = settingsApi;

  final SettingsApi _settingsApi;

  Stream<AppSettings> getAppSettings() => _settingsApi.getAppSettings();

  Future<void> saveAppSettings(AppSettings settings) => _settingsApi.saveAppSettings(settings);
}
