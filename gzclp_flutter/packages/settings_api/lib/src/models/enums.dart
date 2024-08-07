import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'enums.g.dart';

class Gender extends EnumClass {
  static Serializer<Gender> get serializer => _$genderSerializer;

  static const Gender xx = _$xx;
  static const Gender xy = _$xy;

  const Gender._(super.name);

  static BuiltSet<Gender> get values => _$values;
  static Gender valueOf(String name) => _$valueOf(name);
}

class WeightUnit extends EnumClass {
  static Serializer<WeightUnit> get serializer => _$weightUnitSerializer;

  static const WeightUnit kg = _$kg;
  static const WeightUnit lb = _$lb;

  const WeightUnit._(super.name);

  static BuiltSet<WeightUnit> get values => _$weightUnitValues;
  static WeightUnit valueOf(String name) => _$valueOfWU(name);
}

class BarWeight extends EnumClass {
  static Serializer<BarWeight> get serializer => _$barWeightSerializer;

  static const BarWeight custom = _$custom;
  static const BarWeight kg20 = _$kg20;
  static const BarWeight kg15 = _$kg15;

  const BarWeight._(super.name);

  static BuiltSet<BarWeight> get values => _$barWeightValues;
  static BarWeight valueOf(String name) => _$valueOfBW(name);
}

class ExerciseTier extends EnumClass {
  static Serializer<ExerciseTier> get serializer => _$exerciseTierSerializer;

  static const ExerciseTier tier1 = _$tier1;
  static const ExerciseTier tier2 = _$tier2;
  static const ExerciseTier tier3 = _$tier3;

  const ExerciseTier._(super.name);

  static BuiltSet<ExerciseTier> get values => _$exerciseTierValues;
  static ExerciseTier valueOf(String name) => _$valueOfET(name);
}
