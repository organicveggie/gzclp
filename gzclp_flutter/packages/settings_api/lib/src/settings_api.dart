import 'models/models.dart';

abstract class SettingsApi {
  const SettingsApi();

  Stream<AppSettings> getAppSettings();
  Future<void> saveAppSettings(AppSettings settings);

  Stream<ExerciseSettings> getExerciseSettings();
  Future<void> saveExerciseSettings(ExerciseSettings settings);

  void loadDefaultAppSettings();
  void loadDefaultTier1Exercises();
  void loadDefaultTier2Exercises();
  void loadDefaultTier3Exercises();
}
