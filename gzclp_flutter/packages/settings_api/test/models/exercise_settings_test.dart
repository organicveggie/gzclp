import 'package:built_collection/built_collection.dart';
import 'package:test/test.dart';
import 'package:settings_api/settings_api.dart';

void main() {
  group(ExerciseSettings, () {
    group('creation', () {
      test('works with defaults', () {
        final settings = ExerciseSettings.withDefaults();
        expect(settings, isNotNull);
      });
    });

    group('serialize', () {
      final serializer = SettingsApiSerializer();

      final emptyMap = BuiltMap<ExerciseTier, BuiltList<Exercise>>.of({});
      final emptyExercises = BuiltMap<ExerciseTier, BuiltList<Exercise>>.of({
        ExerciseTier.tier1: BuiltList<Exercise>.of([]),
        ExerciseTier.tier2: BuiltList<Exercise>.of([]),
        ExerciseTier.tier3: BuiltList<Exercise>.of([])
      });

      const rawJson = '{"exercises":{"\\"tier1\\"":[],"\\"tier2\\"":[],"\\"tier3\\"":[]}}';

      group('from json', () {
        test('works with empty lists', () {
          final expected = ExerciseSettings((b) => b..exercises = emptyExercises.toBuilder());
          final settings = serializer.exerciseSettingsFromJson(rawJson);
          expect(settings, equals(expected));
        });

        test('works with tier 1 exercises json', () {
          final expected = ExerciseSettings((b) => b..exercises = emptyMap.toBuilder()).put(
              ExerciseTier.tier1,
              BuiltList<Exercise>.of([
                Exercise.byName('Bench Press'),
                Exercise.byName('Deadlift'),
              ]));

          const rawTier1Json =
              '{"exercises":{"\\"tier1\\"":[{"name":"Bench Press"},{"name":"Deadlift"}]}}';

          final settings = serializer.exerciseSettingsFromJson(rawTier1Json);
          expect(settings, equals(expected));
        });

        test('works with tier 2 exercises json', () {
          final expected = ExerciseSettings((b) => b..exercises = emptyMap.toBuilder()).put(
              ExerciseTier.tier2,
              BuiltList<Exercise>.of([
                Exercise.byName('Front Squat'),
                Exercise.byName('Sumo Deadlift'),
              ]));

          const rawTier2Json =
              '{"exercises":{"\\"tier2\\"":[{"name":"Front Squat"},{"name":"Sumo Deadlift"}]}}';

          final settings = serializer.exerciseSettingsFromJson(rawTier2Json);
          expect(settings, equals(expected));
        });

        test('works with tier 3 exercises json', () {
          final expected = ExerciseSettings((b) => b..exercises = emptyMap.toBuilder()).put(
              ExerciseTier.tier3,
              BuiltList<Exercise>.of([
                Exercise.byName('Bicep Curls'),
                Exercise.byName('Cable Row'),
              ]));

          const rawTier3Json =
              '{"exercises":{"\\"tier3\\"":[{"name":"Bicep Curls"},{"name":"Cable Row"}]}}';

          final settings = serializer.exerciseSettingsFromJson(rawTier3Json);
          expect(settings, equals(expected));
        });
      });
      group('to json', () {
        test('works with defaults', () {
          const expectedJson = '{"exercises":{'
              '"\\"tier1\\"":[{"name":"Bench Press"},{"name":"Deadlift"},{"name":"Overhead Press"},{"name":"Squat"}],'
              '"\\"tier2\\"":[{"name":"Bench Press"},{"name":"Barbell Row"},{"name":"Close Grip Bench Press"},{"name":"Deadlift"},{"name":"Front Squat"},{"name":"Incline Bench"},{"name":"Legs Up Bench"},{"name":"Overhead Press"},{"name":"Paused Bench Press"},{"name":"Squat"},{"name":"Sumo Deadlift"}],'
              '"\\"tier3\\"":[{"name":"Bicep Curls"},{"name":"Cable Crunch"},{"name":"Cable Row"},{"name":"Calf Raises"},{"name":"Chest Flyes"},{"name":"Chest-Supported Row"},{"name":"Close-Grip Pulldown"},{"name":"DB Batwing Row"},{"name":"DB Curls"},{"name":"DB Hammer Curl"},{"name":"DB Row"},{"name":"DB Seated Press"},{"name":"Dips (Weighted)"},{"name":"Dips (Assisted)"},{"name":"Dumbbell Pullover"},{"name":"EZ Bar Curl"},{"name":"EZ Bar Curl (Reverse)"},{"name":"EZ Bar Pullover"},{"name":"Face Pulls (Cable)"},{"name":"Flat DB Bench"},{"name":"Glute Pull Through"},{"name":"Goblet Squat"},{"name":"Good Mornings"},{"name":"Hammer Curl"},{"name":"Hip Thrust"},{"name":"Incline DB Bench Press"},{"name":"Lateral Raises"},{"name":"Lat Pulldowns"},{"name":"Leg Curls"},{"name":"Leg Extensions"},{"name":"Leg Press"},{"name":"Lunges"},{"name":"Machine Pull-Over"},{"name":"Machine Side Raise"},{"name":"Rack Pull"},{"name":"Rear Delt Flye"},{"name":"Reverse Curls"},{"name":"Romanian DL"},{"name":"Seated DB Press"},{"name":"Shrugs"},{"name":"Side DB Raise"},{"name":"Side Lateral"},{"name":"Skull Crusher"},{"name":"Split Squat"},{"name":"Step Ups"},{"name":"Tricep Extention"},{"name":"Tricep Pushdowns (bar)"},{"name":"Tricep Pushdowns (strap)"},{"name":"Upright Row"},{"name":"Weighted Hyperextensions"}]}}';
          final json = serializer.exerciseSettingsToJson(ExerciseSettings.withDefaults());
          expect(json, equals(expectedJson));
        });

        test('works with empty lists of exercises', () {
          final settings = ExerciseSettings((b) => b..exercises = emptyExercises.toBuilder());
          final json = serializer.exerciseSettingsToJson(settings);
          expect(json, equals(rawJson));
        });
      });
    });
  });
}
