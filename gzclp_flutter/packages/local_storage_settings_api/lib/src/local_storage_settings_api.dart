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
  void loadDefaultAppSettings() {
    _settingsStreamController.add(AppSettings.withDefaults());
  }

  @override
  void loadDefaultTier1Exercises() {
    final settings = _settingsStreamController.value;
    final newSettings =
        settings.rebuild((b) => b..tier1Exercises = defaultTier1Exercises.toBuilder());
    _settingsStreamController.add(newSettings);
  }

  @override
  void loadDefaultTier2Exercises() {
    final settings = _settingsStreamController.value;
    _settingsStreamController
        .add(settings.rebuild((b) => b..tier2Exercises = defaultTier2Exercises.toBuilder()));
  }

  @override
  void loadDefaultTier3Exercises() {
    final settings = _settingsStreamController.value;
    _settingsStreamController
        .add(settings.rebuild((b) => b..tier3Exercises = defaultTier3Exercises.toBuilder()));
  }

  @override
  Future<void> saveAppSettings(AppSettings settings) {
    final appSettingsJson = _settingsApiSerializer.appSettingsToJson(settings);
    if (appSettingsJson != null) {
      return _setValue(kAppSettingsKey, appSettingsJson);
    }

    throw const FormatException('unable serialize app settings');
  }
}
