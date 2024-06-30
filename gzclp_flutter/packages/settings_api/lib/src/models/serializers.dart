import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/serializer.dart';

import 'models.dart';

part 'serializers.g.dart';

@SerializersFor([
  AppSettings,
  BarWeight,
  Gender,
  WeightUnit,
])
final Serializers serializers = _$serializers;

class SettingsApiSerializer {
  SettingsApiSerializer() {
    _standardSerializers = (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
  }

  late final Serializers _standardSerializers;

  AppSettings? appSettingsFromJson(Map<String, dynamic> json) =>
      _standardSerializers.deserializeWith(AppSettings.serializer, json);

  String? appSettingsToJson(AppSettings settings) =>
      _standardSerializers.serializeWith(AppSettings.serializer, settings)?.toString();
}
