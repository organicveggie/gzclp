import 'package:flutter_test/flutter_test.dart';

import 'package:settings_api/settings_api.dart';

class TestSettingsApi extends SettingsApi {
  const TestSettingsApi() : super();

  @override
  Stream<AppSettings> getAppSettings() => throw UnimplementedError("getAppSettings");

  @override
  Future<void> saveAppSettings(AppSettings settings) => throw UnimplementedError("saveAppSettings");

  @override
  void loadDefaultAppSettings() {
    throw UnimplementedError("loadDefaultAppSettings");
  }

  @override
  void loadDefaultTier1Exercises() {
    throw UnimplementedError("loadDefaultTier1Exercises");
  }

  @override
  void loadDefaultTier2Exercises() {
    throw UnimplementedError("loadDefaultTier2Exercises");
  }

  @override
  void loadDefaultTier3Exercises() {
    throw UnimplementedError("loadDefaultTier3Exercises");
  }

  @override
  Stream<ExerciseSettings> getExerciseSettings() {
    throw UnimplementedError("getExerciseSettings");
  }

  @override
  Future<void> saveExerciseSettings(ExerciseSettings settings) {
    throw UnimplementedError("saveExerciseSettings");
  }
}

void main() {
  group(SettingsApi, () {
    test('can be constructed', () {
      expect(TestSettingsApi.new, returnsNormally);
    });
  });
}
