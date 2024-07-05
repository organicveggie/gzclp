import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../defaults.dart';
import 'enums.dart';
import 'exercise.dart';

part 'exercise_settings.g.dart';

abstract class ExerciseSettings implements Built<ExerciseSettings, ExerciseSettingsBuilder> {
  static Serializer<ExerciseSettings> get serializer => _$exerciseSettingsSerializer;

  ExerciseSettings._();
  factory ExerciseSettings([void Function(ExerciseSettingsBuilder) updates]) = _$ExerciseSettings;
  factory ExerciseSettings.withDefaults() => ExerciseSettings((b) => b
    ..exercises = BuiltMap<ExerciseTier, BuiltSet<Exercise>>.of({
      ExerciseTier.tier1: defaultTier1Exercises,
      ExerciseTier.tier2: defaultTier2Exercises,
      ExerciseTier.tier3: defaultTier3Exercises,
    }).toBuilder());

  ExerciseSettings put(ExerciseTier tier, BuiltSet<Exercise> newExercises) =>
      ExerciseSettings((b) => b..exercises[tier] = newExercises);

  BuiltMap<ExerciseTier, BuiltSet<Exercise>> get exercises;

  BuiltSet<Exercise>? getTier(ExerciseTier tier) => exercises[tier];
}
