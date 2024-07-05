import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:settings_api/settings_api.dart';

import 'package:settings_repository/settings_repository.dart';

class MockSettingsApi extends Mock implements SettingsApi {}

class FakeAppSettings extends Fake implements AppSettings {}

void main() {
  group(SettingsRepository, () {
    late SettingsApi api;

    final appSettings = AppSettings((b) => b
      ..gender = Gender.xx
      ..units = WeightUnit.kg
      ..microplates = true
      ..barWeight = BarWeight.kg15);

    final exerciseSettings = ExerciseSettings((b) => b
      ..exercises = BuiltMap<ExerciseTier, BuiltSet<Exercise>>.of({
        ExerciseTier.tier1:
            BuiltSet<Exercise>.of([Exercise.byName('Bench Press'), Exercise.byName('Deadlift')])
      }).toBuilder());

    setUpAll(() {
      registerFallbackValue(FakeAppSettings());
    });

    setUp(() {
      api = MockSettingsApi();
      when(() => api.getAppSettings()).thenAnswer((_) => Stream.value(appSettings));
      when(() => api.saveAppSettings()).thenAnswer((_) async {});
      when(() => api.getExerciseSettings()).thenAnswer((_) => Stream.value(exerciseSettings));
      when(() => api.saveExerciseSettings()).thenAnswer((_) async {});
    });

    SettingsRepository createSubject() => SettingsRepository(settingsApi: api);

    group('constructor', () {
      test('works properly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });
    });

    group('getAppSettings', () {
      test('makes correct SettingsApi request', () {
        final subject = createSubject();
        expect(
          subject.getAppSettings(),
          isNot(throwsA(anything)),
        );

        verify(() => api.getAppSettings()).called(1);
      });

      test('returns stream', () {
        final subject = createSubject();
        expect(
          subject.getAppSettings(),
          emits(appSettings),
        );
      });
    });

    group('saveAppSettings', () {
      test('completes normally', () {
        final subject = createSubject();
        expect(subject.saveAppSettings(), completes);
      });
    });

    group('addExercise', () {
      test('completes normally', () {
        final subject = createSubject();
        expect(subject.addExercise(ExerciseTier.tier1, Exercise.byName('Squats')), completes);
      });
    });
  });
}
