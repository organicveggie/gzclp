import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage_settings_api/local_storage_settings_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:settings_api/settings_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group(LocalStorageSettingsApi, () {
    const rawJson = '{"gender": "xx", "units": "kg", "microplates": true, "barWeight": "kg15",'
        '"tier1Exercises":[{"name":"Bench Press"}],'
        '"tier2Exercises":[{"name":"Sumo Deadlift"}],'
        '"tier3Exercises":[{"name":"Bicep Curls"}]}';
    final appSettings = AppSettings((b) => b
      ..gender = Gender.xx
      ..units = WeightUnit.kg
      ..microplates = true
      ..barWeight = BarWeight.kg15
      ..tier1Exercises = BuiltList<Exercise>.of([Exercise.byName('Bench Press')]).toBuilder()
      ..tier2Exercises = BuiltList<Exercise>.of([Exercise.byName('Sumo Deadlift')]).toBuilder()
      ..tier3Exercises = BuiltList<Exercise>.of([Exercise.byName('Bicep Curls')]).toBuilder());

    late SharedPreferences plugin;

    setUp(() {
      plugin = MockSharedPreferences();
      when(() => plugin.getString(any())).thenReturn(rawJson);
      when(() => plugin.setString(any(), any())).thenAnswer((_) async => true);
    });

    LocalStorageSettingsApi createSubject() {
      return LocalStorageSettingsApi(plugin: plugin);
    }

    group('constructor', () {
      test('works correctly', () {
        expect(createSubject, returnsNormally);
      });

      group('initializes the stream', () {
        test('with existing app settings', () {
          final subject = createSubject();
          expect(subject.getAppSettings(), emits(appSettings));
          verify(() => plugin.getString(LocalStorageSettingsApi.kAppSettingsKey)).called(1);
        });

        test('with default when no settings', () {
          when(() => plugin.getString(any())).thenReturn(null);
          final subject = createSubject();
          expect(subject.getAppSettings(), emits(AppSettings.withDefaults()));
          verify(() => plugin.getString(LocalStorageSettingsApi.kAppSettingsKey)).called(1);
        });
      });
    });
  });
}
