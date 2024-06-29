import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'cycle_settings.g.dart';

enum SchedulingDays {
  days3,
  days4;
}

class DefaultWarmups {
  static final BuiltList<int> three = BuiltList.of([60, 70, 85]);
  static final BuiltList<int> four = BuiltList.of([60, 70, 80, 90]);
}

abstract class CycleSettings implements Built<CycleSettings, CycleSettingsBuilder> {
  CycleSettings._();
  factory CycleSettings([void Function(CycleSettingsBuilder) updates]) = _$CycleSettings;

  SchedulingDays get days;
  bool get amrapWeightIncreases;

  BuiltList<int> get warmupSetsProgression3;
  BuiltList<int> get warmupSetsProgression4;
}
