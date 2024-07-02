import 'dart:async';

import 'package:rxdart/subjects.dart';
import 'package:settings_api/settings_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageSettingsApi extends SettingsApi {
  LocalStorageSettingsApi({required SharedPreferences plugin})
      : _settingsApiSerializer = SettingsApiSerializer(),
        _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;
  final SettingsApiSerializer _settingsApiSerializer;

  late final _settingsStreamController =
      BehaviorSubject<AppSettings>.seeded(AppSettings.withDefaults());

  static const kAppSettingsKey = '__app_settings_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) => _plugin.setString(key, value);

  void _init() {
    final appSettingsJson = _getValue(kAppSettingsKey);
    if (appSettingsJson != null) {
      final settings = _settingsApiSerializer.appSettingsFromJson(appSettingsJson);
      _settingsStreamController.add(settings ?? AppSettings.withDefaults());
    } else {
      _settingsStreamController.add(AppSettings.withDefaults());
    }
  }

  @override
  Stream<AppSettings> getAppSettings() => _settingsStreamController.asBroadcastStream();

  @override
  Future<void> saveAppSettings(AppSettings settings) {
    final appSettingsJson = _settingsApiSerializer.appSettingsToJson(settings);
    if (appSettingsJson != null) {
      return _setValue(kAppSettingsKey, appSettingsJson);
    }

    throw const FormatException('unable serialize app settings');
  }
}
