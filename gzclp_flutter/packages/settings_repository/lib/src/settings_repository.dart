import 'package:settings_api/settings_api.dart';

class SettingsRepository {
  SettingsRepository({required SettingsApi settingsApi}) : _settingsApi = settingsApi;

  final SettingsApi _settingsApi;

  Stream<AppSettings> getAppSettings() => _settingsApi.getAppSettings();
  Stream<ExerciseSettings> getExerciseSettings() => _settingsApi.getExerciseSettings();

  Future<void> saveAppSettings() => _settingsApi.saveAppSettings();

  Future<void> addExercise(ExerciseTier tier, Exercise exercise) {
    _settingsApi.addExercise(tier, exercise);
    return _settingsApi.saveExerciseSettings();
  }

  Future<void> removeExercise(ExerciseTier tier, Exercise exercise) {
    _settingsApi.removeExercise(tier, exercise);
    return _settingsApi.saveExerciseSettings();
  }
}
