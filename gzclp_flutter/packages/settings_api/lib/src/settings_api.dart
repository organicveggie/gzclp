import 'models/models.dart';

abstract class SettingsApi {
  const SettingsApi();

  Stream<AppSettings> getAppSettings();
  Future<void> saveAppSettings();

  Stream<ExerciseSettings> getExerciseSettings();
  Future<void> saveExerciseSettings();

  void loadDefaultAppSettings();
  void loadDefaultTier1Exercises();
  void loadDefaultTier2Exercises();
  void loadDefaultTier3Exercises();

  ExerciseSettings addExercise(ExerciseTier tier, Exercise exercise);
}
