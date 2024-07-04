import 'package:built_collection/built_collection.dart';
import 'package:test/test.dart';
import 'package:settings_api/settings_api.dart';

void main() {
  group(AppSettings, () {
    group('creation', () {
      test('works with defaults', () {
        final settings = AppSettings.withDefaults();
        expect(settings, isNotNull);
      });
    });

    group('serialize', () {
      final serializer = SettingsApiSerializer();

      const rawJson =
          '''{"gender":"xy","units":"lb","microplates":true,"barWeight":"kg20","tier1Exercises":[],"tier2Exercises":[],"tier3Exercises":[]}''';

      group('from json', () {
        test('works with valid json', () {
          final expected = AppSettings((b) => b
            ..gender = Gender.xy
            ..units = WeightUnit.lb
            ..microplates = true
            ..barWeight = BarWeight.kg20);

          final settings = serializer.appSettingsFromJson(rawJson);
          expect(settings, equals(expected));
        });

        test('works with tier 1 exercises json', () {
          final expected = AppSettings.withDefaults().rebuild((b) => b
            ..tier1Exercises = BuiltList<Exercise>.of([
              Exercise.byName('Bench Press'),
              Exercise.byName('Deadlift'),
            ]).toBuilder());

          const rawTier1Json = '{"gender":"xy","units":"lb","microplates":true,"barWeight":"kg20",'
              '"tier1Exercises":[{"name":"Bench Press"},{"name":"Deadlift"}],'
              '"tier2Exercises":[],"tier3Exercises":[]}';

          final settings = serializer.appSettingsFromJson(rawTier1Json);
          expect(settings, equals(expected));
        });

        test('works with tier 2 exercises json', () {
          final expected = AppSettings.withDefaults().rebuild((b) => b
            ..tier2Exercises = BuiltList<Exercise>.of([
              Exercise.byName('Front Squat'),
              Exercise.byName('Sumo Deadlift'),
            ]).toBuilder());

          const rawTier2Json = '{"gender":"xy","units":"lb","microplates":true,"barWeight":"kg20",'
              '"tier1Exercises":[],'
              '"tier2Exercises":[{"name":"Front Squat"},{"name":"Sumo Deadlift"}],'
              '"tier3Exercises":[]}';

          final settings = serializer.appSettingsFromJson(rawTier2Json);
          expect(settings, equals(expected));
        });
      });

      group('to json', () {
        test('works correctly without tier 1/2/3 exercises', () {
          final settings = AppSettings((b) => b
            ..gender = Gender.xy
            ..units = WeightUnit.lb
            ..microplates = true
            ..barWeight = BarWeight.kg20);
          final json = serializer.appSettingsToJson(settings);
          expect(json, equals(rawJson));
        });

        test('works correctly with tier 1 exercises', () {
          final settings = AppSettings.withDefaults().rebuild((b) => b
            ..tier1Exercises = BuiltList<Exercise>.of([
              Exercise.byName('Bench Press'),
              Exercise.byName('Deadlift'),
            ]).toBuilder());
          final json = serializer.appSettingsToJson(settings);

          const rawTier1Json = '{"gender":"xy","units":"lb","microplates":true,"barWeight":"kg20",'
              '"tier1Exercises":[{"name":"Bench Press"},{"name":"Deadlift"}],'
              '"tier2Exercises":[],"tier3Exercises":[]}';
          expect(json, equals(rawTier1Json));
        });
      });
    });
  });
}
