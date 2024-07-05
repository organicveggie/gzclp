import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage_settings_api/local_storage_settings_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:settings_api/settings_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group(LocalStorageSettingsApi, () {
    const rawAppJson = '{"gender": "xx", "units": "kg", "microplates": true, "barWeight": "kg15"}';
    final appSettings = AppSettings((b) => b
      ..gender = Gender.xx
      ..units = WeightUnit.kg
      ..microplates = true
      ..barWeight = BarWeight.kg15);

    const rawExerciseJson = '{"exercises":{'
        '"\\"tier1\\"": [{"name":"Bench Press"},{"name":"Deadlift"}],'
        '"\\"tier2\\"":[{"name":"Front Squat"},{"name":"Sumo Deadlift"}],'
        '"\\"tier3\\"":[{"name":"Bicep Curls"},{"name":"Cable Row"}]'
        '}}';
    final exerciseSettings = ExerciseSettings((b) => b
      ..exercises = BuiltMap<ExerciseTier, BuiltList<Exercise>>.of({
        ExerciseTier.tier1:
            BuiltList<Exercise>.of([Exercise.byName('Bench Press'), Exercise.byName('Deadlift')]),
        ExerciseTier.tier2: BuiltList<Exercise>.of(
            [Exercise.byName('Front Squat'), Exercise.byName('Sumo Deadlift')]),
        ExerciseTier.tier3:
            BuiltList<Exercise>.of([Exercise.byName('Bicep Curls'), Exercise.byName('Cable Row')]),
      }).toBuilder());

    late SharedPreferences plugin;

    setUp(() {
      plugin = MockSharedPreferences();
      when(() => plugin.getString(LocalStorageSettingsApi.kAppSettingsKey)).thenReturn(rawAppJson);
      when(() => plugin.getString(LocalStorageSettingsApi.kExerciseSettingsKey))
          .thenReturn(rawExerciseJson);
      when(() => plugin.setString(any(), any())).thenAnswer((_) async => true);
    });

    LocalStorageSettingsApi createSubject() {
      return LocalStorageSettingsApi(plugin: plugin);
    }

    group('constructor', () {
      test('works correctly', () {
        expect(createSubject, returnsNormally);
      });

      group('initializes the streams', () {
        group('with existing', () {
          test('app settings', () {
            final subject = createSubject();
            expect(subject.getAppSettings(), emits(appSettings));
            verify(() => plugin.getString(LocalStorageSettingsApi.kAppSettingsKey)).called(1);
          });
          test('exercise settings', () {
            final subject = createSubject();
            expect(subject.getExerciseSettings(), emits(exerciseSettings));
            verify(() => plugin.getString(LocalStorageSettingsApi.kExerciseSettingsKey)).called(1);
          });
        });

        group('with default when missing', () {
          test('app settings', () {
            when(() => plugin.getString(any())).thenReturn(null);
            final subject = createSubject();
            expect(subject.getAppSettings(), emits(AppSettings.withDefaults()));
            verify(() => plugin.getString(LocalStorageSettingsApi.kAppSettingsKey)).called(1);
          });
          test('exercise settings', () {
            when(() => plugin.getString(any())).thenReturn(null);
            final subject = createSubject();
            expect(subject.getExerciseSettings(), emits(ExerciseSettings.withDefaults()));
            verify(() => plugin.getString(LocalStorageSettingsApi.kExerciseSettingsKey)).called(1);
          });
        });
      });
    });

    group('loads', () {
      test('app settings defaults', () {
        final subject = createSubject();
        subject.loadDefaultAppSettings();
        expect(subject.getAppSettings(), emits(AppSettings.withDefaults()));
      });

      test('tier 1 defaults', () async {
        final subject = createSubject();
        await subject.saveExerciseSettings(exerciseSettings);

        final modifiedSettings = exerciseSettings.put(ExerciseTier.tier1, defaultTier1Exercises);

        subject.loadDefaultTier1Exercises();
        expect(subject.getExerciseSettings(), emits(modifiedSettings));
      });

      test('tier 2 defaults', () async {
        final subject = createSubject();
        await subject.saveExerciseSettings(exerciseSettings);

        final modifiedSettings = exerciseSettings.put(ExerciseTier.tier2, defaultTier2Exercises);

        subject.loadDefaultTier2Exercises();
        expect(subject.getExerciseSettings(), emits(modifiedSettings));
      });

      test('tier 3 defaults', () async {
        final subject = createSubject();
        await subject.saveExerciseSettings(exerciseSettings);

        final modifiedSettings = exerciseSettings.put(ExerciseTier.tier3, defaultTier3Exercises);

        subject.loadDefaultTier3Exercises();
        expect(subject.getExerciseSettings(), emits(modifiedSettings));
      });
    });
  });
}
