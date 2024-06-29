import 'models/models.dart';

abstract class SettingsApi {
  const SettingsApi();

  Stream<AppSettings> getAppSettings();
  Future<void> saveAppSettings(AppSettings settings);
}
