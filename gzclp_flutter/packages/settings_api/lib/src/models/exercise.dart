import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'exercise.g.dart';

abstract class Exercise implements Built<Exercise, ExerciseBuilder> {
  static Serializer<Exercise> get serializer => _$exerciseSerializer;

  Exercise._();
  factory Exercise([void Function(ExerciseBuilder) updates]) = _$Exercise;
  factory Exercise.byName(String name) {
    return Exercise((b) => b..name = name);
  }

  String get name;
}
