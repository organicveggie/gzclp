import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'enums.g.dart';

class Gender extends EnumClass {
  static Serializer<Gender> get serializer => _$genderSerializer;

  static const Gender xx = _$xx;
  static const Gender xy = _$xy;

  const Gender._(String name) : super(name);

  static BuiltSet<Gender> get values => _$values;
  static Gender valueOf(String name) => _$valueOf(name);
}

class WeightUnit extends EnumClass {
  static Serializer<WeightUnit> get serializer => _$weightUnitSerializer;

  static const WeightUnit kg = _$kg;
  static const WeightUnit lb = _$lb;

  const WeightUnit._(String name) : super(name);

  static BuiltSet<WeightUnit> get values => _$weightUnitValues;
  static WeightUnit valueOf(String name) => _$valueOfWU(name);
}

class BarWeight extends EnumClass {
  static Serializer<BarWeight> get serializer => _$barWeightSerializer;

  static const BarWeight custom = _$custom;
  static const BarWeight kg20 = _$kg20;
  static const BarWeight kg15 = _$kg15;

  const BarWeight._(String name) : super(name);

  static BuiltSet<BarWeight> get values => _$barWeightValues;
  static BarWeight valueOf(String name) => _$valueOfBW(name);
}
