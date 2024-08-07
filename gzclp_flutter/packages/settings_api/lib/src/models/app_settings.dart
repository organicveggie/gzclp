import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'enums.dart';

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
      ..barWeight = BarWeight.kg20);
  }
  Gender get gender;
  WeightUnit get units;
  bool get microplates;
  BarWeight get barWeight;
}
