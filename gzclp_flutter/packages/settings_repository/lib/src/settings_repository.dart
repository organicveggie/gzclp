import 'dart:developer';

import 'package:settings_api/settings_api.dart';

class SettingsRepository {
  SettingsRepository({required SettingsApi settingsApi}) : _settingsApi = settingsApi;

  final SettingsApi _settingsApi;

  Stream<AppSettings> getAppSettings() {
    log('SettingsRepository.getAppSettings()');
    return _settingsApi.getAppSettings();
  }

  Future<void> saveAppSettings(AppSettings settings) {
    log('SettingsRepository.saveAppSettings()');
    return _settingsApi.saveAppSettings(settings);
  }

  Stream<ExerciseSettings> getExerciseSettings() {
    log('SettingsRepository.getExerciseSettings()');
    return _settingsApi.getExerciseSettings();
  }

  Future<void> addExercise(ExerciseTier tier, Exercise exercise) {
    log('SettingsRepository.addExercise()');
    final newSettings = _settingsApi.addExercise(tier, exercise);
    return _settingsApi.saveExerciseSettings(newSettings);
  }
}
