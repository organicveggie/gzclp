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
            ]).toBuilder()
            ..tier2Exercises = BuiltList<Exercise>.of([]).toBuilder()
            ..tier3Exercises = BuiltList<Exercise>.of([]).toBuilder());

          const rawTier1Json = '{"gender":"xy","units":"lb","microplates":true,"barWeight":"kg20",'
              '"tier1Exercises":[{"name":"Bench Press"},{"name":"Deadlift"}],'
              '"tier2Exercises":[],"tier3Exercises":[]}';

          final settings = serializer.appSettingsFromJson(rawTier1Json);
          expect(settings, equals(expected));
        });

        test('works with tier 2 exercises json', () {
          final expected = AppSettings.withDefaults().rebuild((b) => b
            ..tier1Exercises = BuiltList<Exercise>.of([]).toBuilder()
            ..tier2Exercises = BuiltList<Exercise>.of([
              Exercise.byName('Front Squat'),
              Exercise.byName('Sumo Deadlift'),
            ]).toBuilder()
            ..tier3Exercises = BuiltList<Exercise>.of([]).toBuilder());

          const rawTier2Json = '{"gender":"xy","units":"lb","microplates":true,"barWeight":"kg20",'
              '"tier1Exercises":[],'
              '"tier2Exercises":[{"name":"Front Squat"},{"name":"Sumo Deadlift"}],'
              '"tier3Exercises":[]}';

          final settings = serializer.appSettingsFromJson(rawTier2Json);
          expect(settings, equals(expected));
        });
      });

      group('to json', () {
        test('works correctly with defaults', () {
          const expectedJson = '{"gender":"xy","units":"lb","microplates":true,"barWeight":"kg20",'
              '"tier1Exercises":[{"name":"Bench Press"},{"name":"Deadlift"},{"name":"Overhead Press"},{"name":"Squat"}],'
              '"tier2Exercises":[{"name":"Bench Press"},{"name":"Barbell Row"},{"name":"Close Grip Bench Press"},{"name":"Deadlift"},{"name":"Front Squat"},{"name":"Incline Bench"},{"name":"Legs Up Bench"},{"name":"Overhead Press"},{"name":"Paused Bench Press"},{"name":"Squat"},{"name":"Sumo Deadlift"}],'
              '"tier3Exercises":[{"name":"Bicep Curls"},{"name":"Cable Crunch"},{"name":"Cable Row"},{"name":"Calf Raises"},{"name":"Chest Flyes"},{"name":"Chest-Supported Row"},{"name":"Close-Grip Pulldown"},{"name":"DB Batwing Row"},{"name":"DB Curls"},{"name":"DB Hammer Curl"},{"name":"DB Row"},{"name":"DB Seated Press"},{"name":"Dips (Weighted)"},{"name":"Dips (Assisted)"},{"name":"Dumbbell Pullover"},{"name":"EZ Bar Curl"},{"name":"EZ Bar Curl (Reverse)"},{"name":"EZ Bar Pullover"},{"name":"Face Pulls (Cable)"},{"name":"Flat DB Bench"},{"name":"Glute Pull Through"},{"name":"Goblet Squat"},{"name":"Good Mornings"},{"name":"Hammer Curl"},{"name":"Hip Thrust"},{"name":"Incline DB Bench Press"},{"name":"Lateral Raises"},{"name":"Lat Pulldowns"},{"name":"Leg Curls"},{"name":"Leg Extensions"},{"name":"Leg Press"},{"name":"Lunges"},{"name":"Machine Pull-Over"},{"name":"Machine Side Raise"},{"name":"Rack Pull"},{"name":"Rear Delt Flye"},{"name":"Reverse Curls"},{"name":"Romanian DL"},{"name":"Seated DB Press"},{"name":"Shrugs"},{"name":"Side DB Raise"},{"name":"Side Lateral"},{"name":"Skull Crusher"},{"name":"Split Squat"},{"name":"Step Ups"},{"name":"Tricep Extention"},{"name":"Tricep Pushdowns (bar)"},{"name":"Tricep Pushdowns (strap)"},{"name":"Upright Row"},{"name":"Weighted Hyperextensions"}]}';
          final json = serializer.appSettingsToJson(AppSettings.withDefaults());
          expect(json, equals(expectedJson));
        });

        test('works correctly without tier 1/2/3 exercises', () {
          final settings = AppSettings((b) => b
            ..gender = Gender.xy
            ..units = WeightUnit.lb
            ..microplates = true
            ..barWeight = BarWeight.kg20);
          final json = serializer.appSettingsToJson(settings);
          expect(json, equals(rawJson));
        });

        test('works correctly with only tier 1 exercises', () {
          final settings = AppSettings.withDefaults().rebuild((b) => b
            ..tier1Exercises = BuiltList<Exercise>.of([
              Exercise.byName('Bench Press'),
              Exercise.byName('Deadlift'),
            ]).toBuilder()
            ..tier2Exercises = BuiltList<Exercise>.of([]).toBuilder()
            ..tier3Exercises = BuiltList<Exercise>.of([]).toBuilder());
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
