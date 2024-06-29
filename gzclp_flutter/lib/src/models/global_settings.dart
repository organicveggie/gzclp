import 'package:built_value/built_value.dart';

part 'global_settings.g.dart';

enum Gender {
  xx,
  xy;
}

enum WeightUnits {
  kg,
  lb;
}

enum BarWeight {
  custom,
  kg20,
  kg15;
}

abstract class GlobalSettings implements Built<GlobalSettings, GlobalSettingsBuilder> {
  GlobalSettings._();
  factory GlobalSettings([void Function(GlobalSettingsBuilder) updates]) = _$GlobalSettings;

  Gender get gender;
  WeightUnits get units;
  bool get microplates;
  BarWeight get barWeight;
}
