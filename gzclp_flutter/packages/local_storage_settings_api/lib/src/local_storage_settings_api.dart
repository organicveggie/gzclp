import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:rxdart/subjects.dart';
import 'package:settings_api/settings_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageSettingsApi extends SettingsApi {
  LocalStorageSettingsApi(
      {required SharedPreferences plugin,
      AppSettings? appSettings,
      ExerciseSettings? exerciseSettings})
      : _settingsApiSerializer = SettingsApiSerializer(),
        _plugin = plugin {
    _init(appSettings, exerciseSettings);
  }

  final SharedPreferences _plugin;
  final SettingsApiSerializer _settingsApiSerializer;

  late final _settingsStreamController =
      BehaviorSubject<AppSettings>.seeded(AppSettings.withDefaults());
  late final _exerciseSettingsStreamController =
      BehaviorSubject<ExerciseSettings>.seeded(ExerciseSettings.withDefaults());

  static const kAppSettingsKey = '__app_settings_key__';
  static const kExerciseSettingsKey = '__exercise_settings_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) => _plugin.setString(key, value);

  void _init(AppSettings? appSettings, ExerciseSettings? exerciseSettings) {
    if (appSettings != null) {
      _settingsStreamController.add(appSettings);
    } else {
      final appSettingsJson = _getValue(kAppSettingsKey);
      if (appSettingsJson != null) {
        final settings = _settingsApiSerializer.appSettingsFromJson(appSettingsJson);
        _settingsStreamController.add(settings ?? AppSettings.withDefaults());
      } else {
        _settingsStreamController.add(AppSettings.withDefaults());
      }
    }

    if (exerciseSettings != null) {
      _exerciseSettingsStreamController.add(exerciseSettings);
    } else {
      final exerciseSettingsJson = _getValue(kExerciseSettingsKey);
      if (exerciseSettingsJson != null) {
        final settings = _settingsApiSerializer.exerciseSettingsFromJson(exerciseSettingsJson);
        _exerciseSettingsStreamController.add(settings ?? ExerciseSettings.withDefaults());
      } else {
        _exerciseSettingsStreamController.add(ExerciseSettings.withDefaults());
      }
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
    final settings = _exerciseSettingsStreamController.value;
    _exerciseSettingsStreamController.add(settings.put(ExerciseTier.tier1, defaultTier1Exercises));
  }

  @override
  void loadDefaultTier2Exercises() {
    final settings = _exerciseSettingsStreamController.value;
    _exerciseSettingsStreamController.add(settings.put(ExerciseTier.tier2, defaultTier2Exercises));
  }

  @override
  void loadDefaultTier3Exercises() {
    final settings = _exerciseSettingsStreamController.value;
    _exerciseSettingsStreamController.add(settings.put(ExerciseTier.tier3, defaultTier3Exercises));
  }

  @override
  Future<void> saveAppSettings() {
    final settings = _settingsStreamController.value;
    final appSettingsJson = _settingsApiSerializer.appSettingsToJson(settings);
    if (appSettingsJson != null) {
      return _setValue(kAppSettingsKey, appSettingsJson);
    }

    throw const FormatException('unable to serialize app settings');
  }

  @override
  Stream<ExerciseSettings> getExerciseSettings() =>
      _exerciseSettingsStreamController.asBroadcastStream();

  @override
  Future<void> saveExerciseSettings() {
    final settings = _exerciseSettingsStreamController.value;
    final settingsJson = _settingsApiSerializer.exerciseSettingsToJson(settings);
    if (settingsJson != null) {
      return _setValue(kExerciseSettingsKey, settingsJson);
    }

    throw const FormatException('unable to serialize exercise settings');
  }

  @override
  ExerciseSettings addExercise(ExerciseTier tier, Exercise exercise) {
    final settings = _exerciseSettingsStreamController.value;
    final exerciseList = settings.getTier(tier)?.toList() ?? <Exercise>[];
    exerciseList.add(exercise);
    exerciseList.sort((a, b) => a.name.compareTo(b.name));

    _exerciseSettingsStreamController.add(settings.put(tier, exerciseList.toBuiltList()));
    return _exerciseSettingsStreamController.value;
  }
}
