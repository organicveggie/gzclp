import 'dart:developer';

import 'package:settings_api/settings_api.dart';

class SettingsRepository {
  SettingsRepository({required SettingsApi settingsApi}) : _settingsApi = settingsApi;

  final SettingsApi _settingsApi;

  Stream<AppSettings> getAppSettings() {
    log('SettingsRepository.getAppSettings()');
    return _settingsApi.getAppSettings();
  }

  Future<void> saveAppSettings() {
    log('SettingsRepository.saveAppSettings()');
    return _settingsApi.saveAppSettings();
  }

  Stream<ExerciseSettings> getExerciseSettings() {
    log('SettingsRepository.getExerciseSettings()');
    return _settingsApi.getExerciseSettings();
  }

  Future<void> addExercise(ExerciseTier tier, Exercise exercise) {
    log('SettingsRepository.addExercise()');
    _settingsApi.addExercise(tier, exercise);
    return _settingsApi.saveExerciseSettings();
  }

  Future<void> removeExercise(ExerciseTier tier, Exercise exercise) {
    _settingsApi.removeExercise(tier, exercise);
    return _settingsApi.saveExerciseSettings();
  }
}
