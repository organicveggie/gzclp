import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../defaults.dart';
import 'enums.dart';
import 'exercise.dart';

part 'app_settings.g.dart';

abstract class AppSettings implements Built<AppSettings, AppSettingsBuilder> {
  static Serializer<AppSettings> get serializer => _$appSettingsSerializer;

  AppSettings._();
  factory AppSettings([void Function(AppSettingsBuilder) updates]) = _$AppSettings;
  factory AppSettings.withDefaults() {
    return AppSettings((b) => b
      ..gender = Gender.xy
      ..units = WeightUnit.lb
      ..microplates = true
      ..barWeight = BarWeight.kg20
      ..tier1Exercises = defaultTier1Exercises.toBuilder()
      ..tier2Exercises = defaultTier2Exercises.toBuilder()
      ..tier3Exercises = defaultTier3Exercises.toBuilder());
  }
  Gender get gender;
  WeightUnit get units;
  bool get microplates;
  BarWeight get barWeight;

  BuiltList<Exercise> get tier1Exercises;
  BuiltList<Exercise> get tier2Exercises;
  BuiltList<Exercise> get tier3Exercises;
}
